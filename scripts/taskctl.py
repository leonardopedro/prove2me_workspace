#!/usr/bin/env python3
"""Declarative task runner for the driver workspace.

Manifest pattern adapted from `ax` (../ax, Apache-2.0): a k8s-style subset —
`apiVersion / kind / metadata / spec.steps[]` YAML Task resources — applied
by a small CLI (`list` / `run` / `health`, the health view being the ax
/healthz idea: one aggregate exit code over declared probes).

Manifests only WRAP existing commands (upload pipeline, doc index, sibling
repo gates); no logic moves into them. Commands run without a shell
(shlex-split), each step's combined output tee'd to state/tasks/<task>.<step>.log.

Usage:
    python3 scripts/taskctl.py list
    python3 scripts/taskctl.py run pipeline --dry-run
    python3 scripts/taskctl.py run --all
    python3 scripts/taskctl.py health          # all steps with health: true
"""
from __future__ import annotations

import argparse
import os
import shlex
import subprocess
import sys

try:
    import yaml
except ImportError:  # pragma: no cover
    print("[error] PyYAML is required (pip install pyyaml)", file=sys.stderr)
    raise SystemExit(2)

REPO_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TASKS_DIR = os.path.join(REPO_ROOT, "tasks")
LOG_DIR = os.path.join(REPO_ROOT, "state", "tasks")


def load_tasks() -> dict[str, dict]:
    tasks: dict[str, dict] = {}
    if not os.path.isdir(TASKS_DIR):
        return tasks
    for fn in sorted(os.listdir(TASKS_DIR)):
        if not fn.endswith((".yaml", ".yml")):
            continue
        path = os.path.join(TASKS_DIR, fn)
        with open(path, encoding="utf-8") as fh:
            docs = list(yaml.safe_load_all(fh))
        for doc in docs:
            if not doc:
                continue
            if doc.get("kind") != "Task":
                print(f"[warn] {fn}: skipping non-Task document", file=sys.stderr)
                continue
            name = (doc.get("metadata") or {}).get("name")
            if not name:
                print(f"[warn] {fn}: Task without metadata.name skipped", file=sys.stderr)
                continue
            steps = (doc.get("spec") or {}).get("steps") or []
            for i, step in enumerate(steps):
                if not isinstance(step, dict) or "run" not in step:
                    raise SystemExit(f"[error] {fn}: task '{name}' step {i} "
                                     f"needs a 'run' field")
            tasks[name] = {
                "file": fn,
                "description": (doc.get("metadata") or {}).get("description", ""),
                "steps": steps,
            }
    return tasks


def step_label(task: str, step: dict, idx: int) -> str:
    return f"{task}/{step.get('name', idx)}"


def exec_step(task: str, step: dict, idx: int, dry_run: bool) -> int:
    cmd = step["run"]
    if isinstance(cmd, list):
        cmd_str, argv = " ".join(cmd), list(cmd)
    else:
        cmd_str = str(cmd)
        argv = shlex.split(cmd_str)
    cwd = os.path.join(REPO_ROOT, step.get("cwd", "."))
    label = step_label(task, step, idx)
    print(f"$ [{label}] {cmd_str}   (cwd={os.path.relpath(cwd, REPO_ROOT)})")
    if dry_run:
        return 0
    os.makedirs(LOG_DIR, exist_ok=True)
    log_path = os.path.join(LOG_DIR, f"{task}.{step.get('name', idx)}.log")
    try:
        with open(log_path, "w", encoding="utf-8") as log:
            log.write(f"# {cmd_str}\n# cwd: {cwd}\n")
            proc = subprocess.Popen(argv, cwd=cwd, stdout=subprocess.PIPE,
                                    stderr=subprocess.STDOUT, text=True, bufsize=1)
            assert proc.stdout is not None
            for line in proc.stdout:
                sys.stdout.write(f"  | {line}")
                log.write(line)
            rc = proc.wait()
    except FileNotFoundError as exc:
        print(f"  [error] {exc}")
        return 127
    print(f"  -> exit {rc} (log: {os.path.relpath(log_path, REPO_ROOT)})")
    return rc


def cmd_list(tasks: dict[str, dict]) -> int:
    if not tasks:
        print("no task manifests found under tasks/")
        return 1
    for name, t in tasks.items():
        print(f"{name:<22} {t['description']}  [{t['file']}]")
        for i, s in enumerate(t["steps"]):
            mark = " (health)" if s.get("health") else ""
            print(f"    - {step_label(name, s, i)}{mark}: {s['run']}")
    return 0


def cmd_run(tasks: dict[str, dict], names: list[str], run_all: bool,
            dry_run: bool, health_only: bool) -> int:
    if run_all or not names:
        if not names and not run_all:
            print("usage: run TASK [TASK…] | run --all   (see: list)", file=sys.stderr)
            return 2
        names = list(tasks)
    failures = 0
    for name in names:
        if name not in tasks:
            print(f"[error] unknown task '{name}' (see: list)", file=sys.stderr)
            return 2
        steps = [s for s in tasks[name]["steps"] if s.get("health")] if health_only \
            else tasks[name]["steps"]
        if health_only and not steps:
            continue
        print(f"== {name} ==")
        for i, step in enumerate(tasks[name]["steps"]):
            if health_only and not step.get("health"):
                continue
            rc = exec_step(name, step, i, dry_run)
            if rc != 0:
                failures += 1
                if not health_only:
                    print(f"[fail] {name}: step '{step.get('name', i)}' "
                          f"exited {rc}; stopping task")
                    break
    if dry_run:
        print("[dry-run] no commands executed")
        return 0
    if failures:
        print(f"[fail] {failures} step(s) failed")
        return 1
    print("[ok] all selected steps passed")
    return 0


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    sub = ap.add_subparsers(dest="cmd")
    sub.add_parser("list", help="show declared tasks")
    p_run = sub.add_parser("run", help="run task steps")
    p_run.add_argument("tasks", nargs="*")
    p_run.add_argument("--all", action="store_true")
    p_run.add_argument("--dry-run", action="store_true")
    p_health = sub.add_parser("health", help="run only steps marked health: true")
    p_health.add_argument("tasks", nargs="*")
    args = ap.parse_args(argv)

    tasks = load_tasks()
    if args.cmd is None or args.cmd == "list":
        return cmd_list(tasks)
    if args.cmd == "run":
        return cmd_run(tasks, args.tasks, args.all, args.dry_run, health_only=False)
    if args.cmd == "health":
        return cmd_run(tasks, args.tasks, run_all=True, dry_run=False, health_only=True)
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
