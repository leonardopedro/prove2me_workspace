#!/usr/bin/env python3
"""Write `state/thm_gate.json` from an already-built candidate mirror.

`build_candidate_mirror.py` now writes the thm gate as it goes, but that pass
recompiles ~1,000 modules.  The mirror it leaves behind already contains the
evidence: a stub compiled iff `/tmp/def_candidate/Theorems/<mod>.olean` exists.
Reading that gives the same verdict for the cost of a directory listing.

Stamping follows the def-gate contract (`sha1` of the workspace file), so a stub
edited after the mirror was built is NOT gate-OK and the pipeline defers instead
of submitting blind.

Statuses mirror `build_candidate_mirror`'s vocabulary: `OK`, `NOSRC` (no workspace
stub), `NOTBUILT` (compiled by neither tool -- the stub was never in the build's
dependency closure, so its imports are unverified and it must not be submitted).

Usage:
  python3 debug/thm_gate_from_mirror.py [--mirror /tmp/def_candidate]

Statuses mirror `build_candidate_mirror`'s vocabulary, plus one crucial third
state:

  OK        compiled in the mirror -> submit
  FAIL      the build ATTEMPTED it and the compiler rejected it -> defer.  This
            is positive evidence, and the only thing worth blocking on.
  UNKNOWN   never in the build's dependency closure.  The mirror staged the
            def bundles' 333-stub closure, not all 10,119 stubs, so absence
            proves nothing -- marking those NOTBUILT and deferring would block
            9,826 stubs to save the 15 attempts that actually failed.  That is
            the absence-as-evidence trap `upload_pipeline.published_defs()`
            avoids by raising; here the correct answer is "no evidence, behave
            as before".

Stamping follows the def-gate contract (`sha1` of the workspace file), so a stub
edited after the mirror was built is NOT gate-OK and the pipeline defers instead
of submitting blind.
"""
import argparse
import hashlib
import json
import os
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--mirror", default=os.environ.get("CANDIDATE_MIRROR",
                                                      "/tmp/def_candidate"))
    ap.add_argument("--report", default="/tmp/def_gate_20261012.tsv",
                    help="build report whose `FAIL Definitions/...` rows name the "
                         "stubs the compiler actually rejected")
    a = ap.parse_args()
    thm_dir = f"{a.mirror}/Theorems"
    if not os.path.isdir(thm_dir):
        print(f"no mirror at {thm_dir} -- run debug/build_candidate_mirror.py")
        return 2

    built = {f[len("Thm_"):-len(".olean")]
             for f in os.listdir(thm_dir) if f.endswith(".olean")}
    ws = {f[len("Thm_"):-len(".lean")]
          for f in os.listdir(f"{WS}/Theorems")
          if f.startswith("Thm_") and f.endswith(".lean")}

    # Stubs the build ATTEMPTED and the compiler rejected.  `build_candidate_mirror`
    # writes one log per failed module under `<report>.logs/`; its name is the
    # module id, which is the evidence we want.  A stub with no `.olean` AND no
    # log was never attempted -> UNKNOWN, not FAIL.
    attempted_bad = set()
    logdir = a.report + ".logs"
    if os.path.isdir(logdir):
        for f in os.listdir(logdir):
            if f.endswith(".log"):
                attempted_bad.add(f[:-len(".log")])

    gate, counts = {}, {"OK": 0, "FAIL": 0, "UNKNOWN": 0, "NOSRC": 0}
    for slug in sorted(ws | built):
        p = f"{WS}/Theorems/Thm_{slug}.lean"
        if not os.path.exists(p):
            status, stamp = "NOSRC", None
        elif slug in built:
            status = "OK"
        elif f"Thm_{slug}" in attempted_bad:
            status = "FAIL"
        else:
            status = "UNKNOWN"
        stamp = None if not os.path.exists(p) else hashlib.sha1(
            open(p, "rb").read()).hexdigest()[:16]
        counts[status] += 1
        gate[slug] = {"status": status, "stamp": stamp}
    gate["_meta"] = {"generated": time.strftime("%Y-%m-%dT%H:%M:%S"),
                     "mirror": a.mirror, "stubs": len(gate) - 1,
                     "source": "existing mirror oleans (no recompilation)"}

    path = f"{WS}/state/thm_gate.json"
    json.dump(gate, open(path, "w"), indent=1)
    print(f"thm gate written: {path}")
    print(f"  OK       {counts['OK']:5d}  (compiled in the mirror -> submit)")
    print(f"  FAIL     {counts['FAIL']:5d}  (build attempted it and the compiler "
          f"said no -> defer)")
    print(f"  UNKNOWN  {counts['UNKNOWN']:5d}  (never in the build closure -> "
          f"no evidence, submit as before)")
    print(f"  NOSRC    {counts['NOSRC']:5d}  (no workspace stub)")
    if os.path.isdir(logdir):
        print(f"  failure evidence: {logdir} ({len(attempted_bad)} log(s))")
    else:
        print(f"  WARNING: no {logdir}, so FAIL was never populated and every "
              f"non-built stub is UNKNOWN")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
