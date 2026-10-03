#!/usr/bin/env python3
"""Stage-2 sketch extraction for ALL BookProof chapters, in parallel.

Resumable: skips chapters whose sketch_<leaf>.jsonl already exists (and is
non-empty).  Writes per-file stderr to state/sketch/log/<leaf>.err and appends
one status line per chapter to state/sketch/log/progress.tsv.

Usage:  python3 scripts/run_sketch_all.py [NPROC]
"""
import json
import os
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor

WS = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace"
PROJ = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331"
SKETCH = f"{WS}/state/sketch"
LOG = f"{SKETCH}/log"
TIERS = json.load(open(f"{WS}/state/chapter_tiers.json"))

NPROC = int(sys.argv[1]) if len(sys.argv) > 1 else 6

os.makedirs(LOG, exist_ok=True)
def _fresh(leaf):
    """A cache counts as done only if it is NEWER than its source.

    The old test was "file exists and is non-empty", which silently accepted
    caches older than the chapter they describe. 361 of 777 were stale, and a
    stale cache carries byte offsets that no longer index the source at all --
    `BlockText.slice` then returns '' and the generated stub is a bare
    `:= by sorry`, or a declaration spliced onto the wrong text. That is the
    root cause of every empty/mangled stub I have been fixing one at a time,
    and it is invisible from any single file.
    """
    f = os.path.join(SKETCH, f"sketch_{leaf}.jsonl")
    src = f"{PROJ}/BookProof/{leaf}.lean"
    if not (os.path.exists(f) and os.path.getsize(f) > 0 and os.path.exists(src)):
        return False
    return os.path.getmtime(f) >= os.path.getmtime(src)


done = set(
    f[len("sketch_"):-len(".jsonl")]
    for f in os.listdir(SKETCH)
    if f.startswith("sketch_") and f.endswith(".jsonl") and _fresh(f[len("sketch_"):-len(".jsonl")])
)

jobs = []
for tier, lst in TIERS.items():
    for f in lst:
        leaf = f[:-5]
        if leaf in done:
            continue
        jobs.append((leaf, f))

print(f"total jobs: {len(jobs)} (already done: {len(done)})", flush=True)

env = dict(os.environ)
env["PATH"] = "/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:" + env.get("PATH", "")


def run(job):
    leaf, f = job
    out = f"{SKETCH}/sketch_{leaf}.jsonl"
    err = f"{LOG}/{leaf}.err"
    try:
        r = subprocess.run(
            ["lake", "env", "lean", "--run", "extract_sketch_info.lean", f"BookProof/{f}",
             "-DmaxHeartbeats=0", "-DmaxSynthPendingDepth=10", "-DrelaxedAutoImplicit=false"],
            cwd=PROJ, env=env, capture_output=True, text=True, timeout=900,
        )
        with open(out, "w") as fh:
            fh.write(r.stdout)
        with open(err, "w") as fh:
            fh.write(r.stderr)
        n = r.stdout.count("\n")
        ok = (r.returncode == 0) and (n > 0)
        with open(f"{LOG}/progress.tsv", "a") as fh:
            fh.write(f"{leaf}\t{ok}\t{r.returncode}\t{n}\n")
        return leaf, ok, r.returncode, n
    except subprocess.TimeoutExpired:
        with open(f"{LOG}/progress.tsv", "a") as fh:
            fh.write(f"{leaf}\tTIMEOUT\t-1\t-1\n")
        return leaf, False, -1, 0
    except Exception as e:  # noqa: BLE001
        with open(f"{LOG}/progress.tsv", "a") as fh:
            fh.write(f"{leaf}\tEXC\t-1\t{e}\n")
        return leaf, False, -1, 0


with ThreadPoolExecutor(max_workers=NPROC) as ex:
    results = list(ex.map(run, jobs))

ok = sum(1 for _, o, _, _ in results if o)
print(f"done {ok}/{len(jobs)} (ok), {len(jobs) - ok} failed", flush=True)