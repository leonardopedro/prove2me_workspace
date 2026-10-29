#!/usr/bin/env python3
"""Diagnostic compile of ONE mirror module under an RSS watchdog.

Same compiler, same flags, same LEAN_PATH as `debug/regate_bundles.py` -- this
changes ONLY the outer guard, never what the compiler sees, so a PASS here is
comparable to a regate OK.  It writes NO gate verdict; it exists because a
ballooning `isDefEq` was reaching kernel-OOM (killing user terminals) before
lean could finish (2026-10-28, Def_ChapterFockWeightedSchurEsa).

Samples VmRSS of the lean process tree every 0.5 s into
state/scratch/watch_<name>.tsv; SIGKILLs the tree if total RSS exceeds --cap-gb
(default 11, i.e. leaves ~2 GiB of a 15 Gi box for the desktop/session), or on
--timeout (default 1800 s).  lean stdout/stderr -> state/scratch/watch_<name>.log

Usage:
  python3 debug/lean_watch.py Definitions/Def_ChapterFockWeightedSchurEsa
  python3 debug/lean_watch.py Definitions/Def_ChapterFoo --cap-gb 11 --timeout 1800
"""
import argparse
import os
import signal
import subprocess
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PROJ = os.environ.get("TIMEPIECE_PROJ", os.path.join(WS, "..", "timepiece331"))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))
PATH_BIN = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin"
SCRATCH = os.path.join(WS, "state", "scratch")


def lake(cmd):
    return subprocess.run(["lake", "env", "bash", "-c", cmd], cwd=PROJ,
                          capture_output=True, text=True).stdout.strip()


def tree_rss_kb(root_pid):
    """Total VmRSS (kB) of root_pid + all descendants via /proc."""
    total = 0
    try:
        out = subprocess.run(["ps", "-eo", "pid=,ppid=,"],
                             capture_output=True, text=True).stdout
    except OSError:
        return 0
    kids = {}
    for line in out.splitlines():
        p, pp = line.split()
        kids.setdefault(int(pp), []).append(int(p))
    stack, seen = [root_pid], set()
    while stack:
        pid = stack.pop()
        if pid in seen:
            continue
        seen.add(pid)
        try:
            with open(f"/proc/{pid}/status") as fh:
                for line in fh:
                    if line.startswith("VmRSS:"):
                        total += int(line.split()[1])
                        break
        except OSError:
            continue
        stack.extend(kids.get(pid, []))
    return total


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("module", help="path relative to the mirror, e.g. "
                                   "Definitions/Def_ChapterFoo")
    ap.add_argument("--cap-gb", type=float, default=11.0)
    ap.add_argument("--timeout", type=float,
                    default=float(os.environ.get("REGATE_TIMEOUT", "1800")))
    a = ap.parse_args()

    src = f"{MIRROR}/{a.module}.lean"
    if not os.path.exists(src):
        print(f"no source {src}"); return 2
    os.makedirs(SCRATCH, exist_ok=True)
    name = a.module.replace("/", "_")

    env = dict(os.environ, PATH=PATH_BIN + ":" + os.environ["PATH"])
    lean = lake("command -v lean")
    base = lake('printf %s "$LEAN_PATH"')
    out_olean = os.path.join(MIRROR, f"{a.module}.olean")

    cmd = [lean, "-DautoImplicit=false", "-o", out_olean, f"{a.module}.lean"]
    print(f"watch: {' '.join(cmd)}\n  cwd={MIRROR}\n"
          f"  cap={a.cap_gb} GiB timeout={a.timeout:.0f}s")
    t0 = time.time()
    proc = subprocess.Popen(cmd, cwd=MIRROR,
                            env=dict(env, LEAN_PATH=f"{MIRROR}:{base}"),
                            stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                            start_new_session=True)
    cap_kb = int(a.cap_gb * 1024 * 1024)
    tsv_path = os.path.join(SCRATCH, f"watch_{name}.tsv")
    log_path = os.path.join(SCRATCH, f"watch_{name}.log")
    verdict, peak = "?", 0
    with open(tsv_path, "w") as tsv:
        tsv.write("elapsed_s\trss_kb\tpids\n")
        while True:
            time.sleep(0.5)
            rss = tree_rss_kb(proc.pid)
            if rss > peak:
                peak = rss
            tsv.write(f"{time.time()-t0:.1f}\t{rss}\t{proc.pid}\n")
            tsv.flush()
            if rss > cap_kb:
                verdict = f"CAP (rss {rss/1024/1024:.2f} GiB > {a.cap_gb})"
                os.killpg(proc.pid, signal.SIGKILL)
                break
            if time.time() - t0 > a.timeout:
                verdict = f"TIMEOUT ({a.timeout:.0f}s)"
                os.killpg(proc.pid, signal.SIGKILL)
                break
            if proc.poll() is not None:
                break
    out, _ = proc.communicate()
    elapsed = time.time() - t0
    open(log_path, "wb").write(out or b"")
    if verdict == "?":
        verdict = "OK" if proc.returncode == 0 else f"FAIL rc={proc.returncode}"
    n_lines = len(out.decode(errors="replace").splitlines()) if out else 0
    print(f"\n{verdict}  elapsed={elapsed:.0f}s  peak_rss={peak/1024/1024:.2f} GiB"
          f"  lean output lines={n_lines}")
    first_err = next((l for l in (out or b"").decode(errors="replace").splitlines()
                      if "error" in l), "")
    if first_err:
        print(f"first error: {first_err[:300]}")
    print(f"rss timeline: {tsv_path}\nlean log:    {log_path}")
    return 0 if verdict == "OK" else 1


if __name__ == "__main__":
    sys.exit(main())
