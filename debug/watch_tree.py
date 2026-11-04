#!/usr/bin/env python3
"""Run ANY command under a tree-wide RSS watchdog.

Same motivation as `lean_watch.py` (kernel OOM kills user terminals on this
15 G box, 2026-10-28/29), but generic: wraps e.g. `debug/regate_bundles.py`
so a ballooning lean compile gets SIGKILLed at --cap-gb BEFORE the kernel
intervenes.  If the wrapped command is killed, it dies before writing
`state/def_gate.json`, so NO verdict is recorded -- gate integrity preserved.

Samples every 0.5 s into state/scratch/<name>.tsv:
  elapsed_s  total_rss_kb  lean_module   (module being compiled, if any)
On cap breach / timeout: SIGKILL the whole process group.

`--metric pss` charges each page once (proportional set size,
/proc/<pid>/smaps_rollup).  Summed VmRSS counts the shared mathlib environment once PER PROCESS,
so a watchdog over any multi-job compile trips on pages that exist once: the
2026-11-03 regate of 881 thm stubs at --jobs 4 read 11.9 GiB while the box had
6 GiB in use, and every chunk was killed 5 s in having compiled nothing.  Use
pss for parallel compiles; rss stays the default because a single ballooning
compile is what the cap was written for.

Usage:
  python3 debug/watch_tree.py --name r27 --cap-gb 11 -- <command...>
  python3 debug/watch_tree.py --metric pss --name r29 --cap-gb 9 --jobs... --
"""
import argparse
import os
import signal
import subprocess
import sys
import time

SCRATCH = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
                       "state", "scratch")


def proc_tree(root_pid, metric="rss"):
    """Return [(pid, mem_kb)] of root_pid + descendants.

    metric="rss"  -> VmRSS (/proc/<pid>/status)
    metric="pss"  -> Pss (/proc/<pid>/smaps_rollup), shared pages charged once
    """
    out = subprocess.run(["ps", "-eo", "pid=,ppid=,"],
                         capture_output=True, text=True).stdout
    kids = {}
    for line in out.splitlines():
        p, pp = line.split()
        kids.setdefault(int(pp), []).append(int(p))
    res, stack, seen = [], [root_pid], set()
    while stack:
        pid = stack.pop()
        if pid in seen:
            continue
        seen.add(pid)
        try:
            if metric == "pss":
                rss = 0
                with open(f"/proc/{pid}/smaps_rollup") as fh:
                    for line in fh:
                        if line.startswith("Pss:"):
                            rss = int(line.split()[1]); break
            else:
                with open(f"/proc/{pid}/status") as fh:
                    rss = 0
                    for line in fh:
                        if line.startswith("VmRSS:"):
                            rss = int(line.split()[1]); break
            res.append((pid, rss))
        except OSError:
            continue
        stack.extend(kids.get(pid, []))
    return res


def lean_module_of(pids):
    """If one of the pids is a lean compile, return its -o target module."""
    for pid, _ in pids:
        try:
            with open(f"/proc/{pid}/cmdline", "rb") as fh:
                parts = fh.read().decode(errors="replace").split("\0")
        except OSError:
            continue
        if parts and parts[0].endswith("/lean") and "-o" in parts:
            i = parts.index("-o")
            if i + 1 < len(parts):
                return parts[i + 1]
    return ""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--name", required=True)
    ap.add_argument("--cap-gb", type=float, default=11.0)
    ap.add_argument("--metric", choices=["rss", "pss"], default="rss",
                    help="rss (VmRSS sum: over-counts shared pages across "
                         "parallel compiles) or pss (each page charged once)")
    ap.add_argument("--timeout", type=float, default=14400.0)
    ap.add_argument("cmd", nargs=argparse.REMAINDER)
    a = ap.parse_args()
    if a.cmd and a.cmd[0] == "--":
        a.cmd = a.cmd[1:]
    if not a.cmd:
        print("no command"); return 2

    os.makedirs(SCRATCH, exist_ok=True)
    tsv_path = os.path.join(SCRATCH, f"watch_{a.name}.tsv")
    log_path = os.path.join(SCRATCH, f"watch_{a.name}.log")
    cap_kb = int(a.cap_gb * 1024 * 1024)
    t0 = time.time()
    proc = subprocess.Popen(a.cmd, stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT, start_new_session=True)
    verdict, peak = "?", 0
    with open(tsv_path, "w") as tsv:
        tsv.write(f"elapsed_s\ttotal_{a.metric}_kb\tlean_module\n")
        while True:
            time.sleep(0.5)
            pids = proc_tree(proc.pid, a.metric)
            rss = sum(r for _, r in pids)
            peak = max(peak, rss)
            tsv.write(f"{time.time()-t0:.1f}\t{rss}\t{lean_module_of(pids)}\n")
            tsv.flush()
            if rss > cap_kb:
                verdict = f"CAP ({rss/1024/1024:.2f} GiB > {a.cap_gb})"
                os.killpg(proc.pid, signal.SIGKILL); break
            if time.time() - t0 > a.timeout:
                verdict = f"TIMEOUT ({a.timeout:.0f}s)"
                os.killpg(proc.pid, signal.SIGKILL); break
            if proc.poll() is not None:
                break
    out, _ = proc.communicate()
    open(log_path, "wb").write(out or b"")
    elapsed = time.time() - t0
    print(f"{verdict if verdict != '?' else 'rc='+str(proc.returncode)}  "
          f"elapsed={elapsed:.0f}s  peak_tree_{a.metric}={peak/1024/1024:.2f} GiB")
    if verdict.startswith("CAP"):
        # report which module was compiling at the moment of the kill.  Strip
        # only the newline: `.strip()` eats the trailing tab of a line whose
        # module field is empty (watchdog over a non-lean command), and the
        # "module compiling at kill" report then died on IndexError instead of
        # telling us what the cap was for (measured 2026-11-03).
        last = (open(tsv_path).read().rstrip("\n").splitlines()[-1]
                .split("\t") + ["", ""])[:3]
        print(f"module compiling at kill: {last[2] or '(none/lean startup)'}")
    print(f"timeline: {tsv_path}\noutput:   {log_path}")
    return 0 if verdict == "?" else 1


if __name__ == "__main__":
    sys.exit(main())
