#!/usr/bin/env python3
"""Compile ONE sol against the mirror and print the FULL error output.

check_sol_local.py truncates each error to 150 chars on one line, which hides
the unsolved goal. This runs the identical invocation (same LEAN_PATH, same
temp-dir-in-Solutions trick) but dumps stdout+stderr unmodified so the whole
goal state, all hypotheses, and every follow-on error are visible.

Usage:
  python3 debug/show_sol_error.py BookProof_BrstLeakage_norm_leakageIter
  python3 debug/show_sol_error.py BookProof_X --tail 40
"""
import os
import shutil
import subprocess
import sys
import tempfile

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(ROOT, "..", "timepiece331"))
MIRROR = os.environ.get("DEF_MIRROR", "/tmp/published_mirror")


def _lake_env(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def main(argv):
    args = [a for a in argv if not a.startswith("--")]
    tail = 200
    for i, a in enumerate(argv):
        if a == "--tail" and i + 1 < len(argv):
            tail = int(argv[i + 1])
    if not args:
        raise SystemExit(__doc__)
    base = _lake_env('printf %s "$LEAN_PATH"')
    lean = _lake_env("command -v lean")
    env = dict(os.environ, LEAN_PATH=f"{MIRROR}:{base}")
    rc_all = 0
    with tempfile.TemporaryDirectory() as d:
        for i, a in enumerate(args):
            name = a[4:] if a.startswith("Sol_") else a
            path = f"{ROOT}/Solutions/Sol_{name}.lean"
            if not os.path.exists(path):
                print(f"=== {name}: MISSING STUB {path}")
                rc_all = 1
                continue
            out = os.path.join(d, f"S{i}.lean")
            shutil.copy(path, out)
            r = subprocess.run([lean, out], env=env, capture_output=True, text=True)
            print(f"=== {name} (exit {r.returncode}) ===")
            body = (r.stdout + r.stderr).strip()
            lines = body.splitlines()
            for ln in lines[-tail:]:
                print("  " + ln.replace(os.path.dirname(d) + "/", ""))
            if r.returncode != 0:
                rc_all = 1
    return rc_all


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
