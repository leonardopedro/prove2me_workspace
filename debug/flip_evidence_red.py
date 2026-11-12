#!/usr/bin/env python3
"""Flip hidden-red sols whose fix is EVIDENCED but locally unverifiable.

Two candidate sources, both filtered by the §2.46 safety rules of
resubmit_ok_red (not already-Proved, not already-flipped this session, not
parked, ledger status == done, has a local file):

  1. offline `ok` (the clean set resubmit_ok_red itself would pick);
  2. EVIDENCE set: the platform's latest error was a miss-ident/namespace, the
     Thm module that provides it is PUBLISHED (thm done + theorem_id), and the
     sol file already carries `import Theorems.<mod>`.  Such a sol fails offline
     only with `object file ... does not exist` for that PUBLISHED module -- a
     mirror divergence (§2.36 mirror-artifact: the submission guard ignores it),
     not a proof defect.  The platform, which serves the module, is the real
     verifier for these.

Single-writer: run ONLY when no upload_pipeline process is alive.  Dry run by
default; --apply writes the ledger (with a backup).

Usage: python3 debug/flip_evidence_red.py [--apply]
"""
import argparse
import json
import os
import shutil
import sys
import time

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()
    os.chdir(WS)

    red = json.load(open("state/red_latest.json"))
    chk = json.load(open("state/offline_pending_check.json"))
    off = (chk.get("sol") or {}).get("items", {})
    st = json.load(open("state/pipeline.json"))
    items = st["items"]

    proved = set()
    if os.path.exists("/tmp/red_theorem_proved.txt"):
        proved = {l.strip() for l in open("/tmp/red_theorem_proved.txt") if l.strip()}

    # evidence set (module-blocked but published-thm + import present)
    evid = set()
    if os.path.exists("state/scratch/red_evidence.txt"):
        evid = {l.strip() for l in open("state/scratch/red_evidence.txt") if l.strip()}
    # clean offline-ok set from resubmit_ok_red's own candidate file
    clean = set()
    if os.path.exists("/tmp/resubmit_ok_red.txt"):
        clean = {l.strip() for l in open("/tmp/resubmit_ok_red.txt") if l.strip()}

    cand = sorted(evid | clean)
    keep, skip = [], []
    for n in cand:
        rec = items.get(f"sol:{n}")
        if not rec:
            skip.append((n, "not in ledger")); continue
        if n in proved:
            skip.append((n, "already Proved")); continue
        if rec.get("flipped_at"):
            skip.append((n, "already flipped")); continue
        if rec.get("status") == "parked" or (rec.get("attempts") or 0) >= 3 and rec.get("status") == "failed":
            skip.append((n, f"parked status={rec.get('status')}")); continue
        if rec.get("status") != "done":
            skip.append((n, f"status={rec.get('status')}")); continue
        if not os.path.exists(f"Solutions/Sol_{n}.lean"):
            skip.append((n, "no file")); continue
        keep.append(n)

    from collections import Counter
    print(f"evidence={len(evid)} clean={len(clean)} union={len(cand)} -> flip {len(keep)}")
    for w, k in Counter(r for _, r in skip).most_common():
        print(f"  skip x{k}: {w}")

    if not a.apply:
        print("\n(dry run; rerun with --apply to flip)")
        return 0
    if os.system("pgrep -f '[u]pload_pipeline.py' >/dev/null") == 0:
        print("ABORT: an upload_pipeline process is alive (single-writer)")
        return 2
    shutil.copy2("state/pipeline.json", "state/pipeline.json.bak.flipred")
    for n in keep:
        rec = items[f"sol:{n}"]
        rec["prev_status"] = "done"
        rec["status"] = "pending"
        rec["attempts"] = 0
        rec["flipped_at"] = time.strftime("%Y-%m-%d %H:%M:%S")
        rec["flip_reason"] = "evidence-red resubmit (published thm + import present)"
        for f in ("error", "job_id", "job_src", "submission_id", "submission_src"):
            rec.pop(f, None)
    tmp = "state/pipeline.json.tmp"
    with open(tmp, "w") as fh:
        json.dump(st, fh, indent=1)
    os.replace(tmp, "state/pipeline.json")
    with open("/tmp/flip_evidence_applied.txt", "w") as fh:
        fh.write("\n".join(keep) + "\n")
    print(f"flipped {len(keep)} sol(s) done -> pending; backup state/pipeline.json.bak.flipred")
    return 0


if __name__ == "__main__":
    sys.exit(main())
