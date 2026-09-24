#!/usr/bin/env python3
"""Debounced file watcher: rerun a check command when files under --root change.

Change-watch pattern adapted from the `typos` note vault
(../typos/notes-core/src/watch.rs, Apache-2.0): filter events by extension,
drain events inside a settle/debounce window, then fire the command ONCE per
settle (not once per event). Implemented with stdlib polling instead of
inotify, so it works anywhere without new dependencies.

Usage:
    # Re-run the timepiece import gate while editing the Book tree:
    python3 scripts/watch_check.py --root ../timepiece/Book -- \
        python3 ../timepiece/scripts/import_components.py BookProof --check

    # One-shot mode: fire at most once, then exit with the command's status:
    python3 scripts/watch_check.py --root . --max-fires 1 -- make check

Exit codes: the watched command's exit status for --max-fires runs;
130 on Ctrl+C; 2 on usage problems. A failing command does NOT stop the
watcher (it reports `[fail]` and keeps watching) unless --max-fires is set.
"""
from __future__ import annotations

import argparse
import os
import subprocess
import sys
import time

DEFAULT_EXTS = ("md", "lean", "py", "rs", "toml", "yaml", "yml", "sh", "json", "cdb")
EXCLUDE_DIRS = {".git", ".lake", ".lake_bk", "node_modules", "_out", "target",
                "__pycache__", ".venv", "state"}


def snapshot(roots: list[str], exts: set[str]) -> dict[str, float]:
    """mtime map for matching files under all roots (stable, cheap)."""
    out: dict[str, float] = {}
    for r in roots:
        if os.path.isfile(r):
            try:
                out[r] = os.path.getmtime(r)
            except OSError:
                pass
            continue
        for dirpath, dirnames, filenames in os.walk(r):
            dirnames[:] = [d for d in dirnames if d not in EXCLUDE_DIRS]
            for fn in filenames:
                ext = fn.rsplit(".", 1)[-1] if "." in fn else ""
                if exts and ext not in exts:
                    continue
                p = os.path.join(dirpath, fn)
                try:
                    out[p] = os.path.getmtime(p)
                except OSError:
                    pass
    return out


def changed(a: dict[str, float], b: dict[str, float]) -> list[str]:
    diffs = [p for p in b if p not in a or a[p] != b[p]]
    diffs += [p for p in a if p not in b]
    return sorted(diffs)


def run_command(cmd: list[str]) -> int:
    print(f"[watch] running: {' '.join(cmd)}", flush=True)
    t0 = time.monotonic()
    rc = subprocess.call(cmd)
    dt = time.monotonic() - t0
    tag = "ok" if rc == 0 else f"fail (exit {rc})"
    print(f"[watch] {tag} in {dt:.2f}s", flush=True)
    return rc


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        description="Debounced watch-and-rerun (pattern: typos watch.rs, Apache-2.0)")
    ap.add_argument("--root", action="append", required=True,
                    metavar="PATH", help="file or dir to watch (repeatable)")
    ap.add_argument("--ext", action="append", default=None, metavar="EXT",
                    help=f"watched extensions (repeatable; default: {', '.join(DEFAULT_EXTS)})")
    ap.add_argument("--interval", type=float, default=0.5,
                    help="poll interval in seconds (default 0.5)")
    ap.add_argument("--settle", type=float, default=0.2,
                    help="debounce window: changes must stop for this long "
                         "before firing (default 0.2, cf. typos 200ms)")
    ap.add_argument("--max-fires", type=int, default=0,
                    help="exit after N command runs (0 = watch forever)")
    ap.add_argument("command", nargs=argparse.REMAINDER,
                    help="command after -- (re-run on each settled change)")
    args = ap.parse_args(argv)

    cmd = args.command
    if cmd and cmd[0] == "--":
        cmd = cmd[1:]
    if not cmd:
        ap.error("no command given (put it after --)")
    missing = [r for r in args.root if not os.path.exists(r)]
    if missing:
        ap.error(f"--root not found: {', '.join(missing)}")

    exts = set(args.ext or DEFAULT_EXTS)
    print(f"[watch] roots={args.root} ext={sorted(exts)} "
          f"interval={args.interval}s settle={args.settle}s", flush=True)

    # Initial run, like typos' compile-before-watch.
    fires = 1
    last_rc = run_command(cmd)
    if args.max_fires and fires >= args.max_fires:
        return last_rc

    state = snapshot(args.root, exts)
    try:
        while True:
            time.sleep(args.interval)
            new = snapshot(args.root, exts)
            if changed(state, new) == []:
                state = new
                continue
            # Settle: hold off until no further change for --settle seconds.
            print("[watch] change detected, settling...", flush=True)
            deadline = time.monotonic() + args.settle
            pending = changed(state, new)
            while time.monotonic() < deadline:
                time.sleep(min(args.interval, 0.1))
                newest = snapshot(args.root, exts)
                if changed(new, newest):
                    new = newest
                    deadline = time.monotonic() + args.settle
                    pending = changed(state, new)
            state = new
            print(f"[watch] settled: {len(pending)} file(s) changed "
                  f"({pending[0]}{', …' if len(pending) > 1 else ''})", flush=True)
            last_rc = run_command(cmd)
            fires += 1
            if args.max_fires and fires >= args.max_fires:
                return last_rc
    except KeyboardInterrupt:
        print("\n[watch] stopped", flush=True)
        return 130


if __name__ == "__main__":
    raise SystemExit(main())
