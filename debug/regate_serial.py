#!/usr/bin/env python3
"""Re-gate def bundles ONE AT A TIME, pausing a running mirror build around each
compile.

The candidate-mirror rebuild (`debug/build_candidate_mirror.py`) holds ~5 GB
while it compiles, so a second `lean` alongside it is what trips the OOM killer
on this 15 GB machine.  Rather than block the rebuild for the whole batch, this
stops its process group (`SIGSTOP`), runs one compile, and resumes it
(`SIGCONT`) -- the rebuild loses wall-clock time only.

It also stages the bundle's CURRENT workspace source into the mirror first: the
mirror's copies were staged when the rebuild started, so a bundle edited since
then would otherwise be re-verified against stale text.

Results accumulate in `state/regate_actual.json`, so a batch can be split across
invocations; modules already measured are skipped.

Usage:
  python3 debug/regate_serial.py ChapterFoo ChapterBar ...
  python3 debug/regate_serial.py --targets-file /tmp/list.txt
"""
import argparse
import json
import os
import re
import shutil
import signal
import subprocess
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
OUT = os.path.join(WS, "state", "regate_actual.json")


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def rebuild_pid():
    r = subprocess.run(["pgrep", "-f", "build_candidate_mirror.py"],
                       capture_output=True, text=True).stdout.split()
    return int(r[0]) if r else None


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapters", nargs="*")
    ap.add_argument("--targets-file", default=None)
    a = ap.parse_args()
    mods = list(a.chapters)
    if a.targets_file:
        mods += [l.strip() for l in open(a.targets_file) if l.strip()]
    mods = [m for m in dict.fromkeys(mods) if m]
    if not mods:
        print("no targets")
        return 2

    base = lake('printf %s "$LEAN_PATH"')
    lean = lake("command -v lean")
    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"],
               LEAN_PATH=f"{MIRROR}:{base}")
    done = {}
    if os.path.exists(OUT):
        try:
            done = json.load(open(OUT))
        except ValueError:
            done = {}

    pid = rebuild_pid()
    for m in mods:
        if m in done:
            print(f"{m:45s} {done[m][:90]}  (cached)")
            continue
        src = f"{WS}/Definitions/Def_{m}.lean"
        dst = f"{MIRROR}/Definitions/Def_{m}.lean"
        if not os.path.exists(src):
            done[m] = "NOSRC"
            print(f"{m:45s} NOSRC")
            continue
        shutil.copy(src, dst)
        t0 = time.time()
        if pid:
            os.killpg(pid, signal.SIGSTOP)
        try:
            r = subprocess.run(
                [lean, "-DautoImplicit=false", "-o", f"Definitions/Def_{m}.olean",
                 f"Definitions/Def_{m}.lean"],
                cwd=MIRROR, env=env, capture_output=True, text=True, timeout=1500)
            out = r.stdout + r.stderr
            if r.returncode == 0:
                status = "OK"
            else:
                err = next((l for l in out.splitlines() if "error" in l), "")
                status = "FAIL " + err.strip()[:200]
                open(f"{WS}/state/logs/regate/D_Def_{m}.log", "w").write(out)
        except subprocess.TimeoutExpired:
            status = "TIMEOUT"
        finally:
            if pid:
                os.killpg(pid, signal.SIGCONT)
        done[m] = status
        json.dump(done, open(OUT, "w"), indent=1)
        print(f"{m:45s} {status[:90]}  [{time.time() - t0:.0f}s]", flush=True)
    print(f"measured {len(mods)} requested, {len(done)} total in {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
