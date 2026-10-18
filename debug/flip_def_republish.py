#!/usr/bin/env python3
"""Flip `def:<Chapter>` ledger items `done -> pending` for an additive republish.

§2.49 republish loop, step 3: after `check_def_local.py` is green and
`regate_bundles.py` merged an OK verdict into state/def_gate.json, the item is
flipped back to `pending` so the next def chunk submits it again -- the
platform's `submit-definition` updates the bundle in place, which is how a
stale/placeholder published copy gets replaced by the workspace text.

Safety contract (§2.59 additive-only):
  * only flips items whose def_gate verdict is `OK` with a stamp matching the
    current workspace file (the same freshness upload_pipeline.thm/def_gate
    check uses) -- a green gate is the compile evidence, the subset check
    (published decl names present in WS text) is the author's obligation;
  * records `flipped_at` + `prev_error` so an audit trail survives and a
    re-run does not flip twice;
  * refuses while an upload_pipeline process is alive (single-writer), and
    backs up state/pipeline.json.

Usage:
  python3 debug/flip_def_republish.py ChapterKatoRellichDeficiency [...]
  python3 debug/flip_def_republish.py --apply Chapter...
"""
import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
LED = os.path.join(WS, "state", "pipeline.json")
GATE = os.path.join(WS, "state", "def_gate.json")


def file_stamp(path):
    return hashlib.sha1(open(path, "rb").read()).hexdigest()[:16]


def pipeline_alive():
    out = subprocess.run(["pgrep", "-a", "-f", "upload_pipeline.py"],
                         capture_output=True, text=True).stdout
    for line in out.splitlines():
        _, _, cmd = line.partition(" ")
        if os.path.basename(cmd.strip().split(" ", 1)[0]).startswith("python"):
            return True
    return False


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapters", nargs="+")
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()

    led = json.load(open(LED))
    gate = json.load(open(GATE))
    flip, skip = [], []
    for ch in a.chapters:
        item = "def:" + ch
        rec = led["items"].get(item)
        src = os.path.join(WS, "Definitions", f"Def_{ch}.lean")
        if rec is None:
            skip.append((ch, "no ledger item"))
            continue
        if rec.get("status") != "done":
            skip.append((ch, f"status={rec.get('status')}"))
            continue
        g = gate.get(ch) or {}
        if g.get("status") != "OK":
            skip.append((ch, f"gate={str(g.get('status'))[:60]}"))
            continue
        if g.get("stamp") != file_stamp(src):
            skip.append((ch, "gate stamp stale vs workspace file"))
            continue
        flip.append(ch)

    for ch in flip:
        rec = led["items"]["def:" + ch]
        if a.apply:
            rec.setdefault("prev_error", rec.get("error"))
            rec["status"] = "pending"
            rec["flipped_at"] = time.strftime("%Y-%m-%d %H:%M:%S")
            rec["flip_reason"] = "additive republish (§2.49): gate OK, WS text"
        print("  flip def:" + ch)
    for ch, why in skip:
        print("  keep def:%s | %s" % (ch, why))

    if not a.apply:
        print("dry run -- nothing written (use --apply)")
        return 0
    if not flip:
        print("nothing to flip")
        return 0
    if pipeline_alive():
        print("refusing: an upload_pipeline process is alive (single-writer)")
        return 1
    shutil.copy(LED, LED + ".bak_repub")
    json.dump(led, open(LED + ".tmp", "w"), separators=(",", ":"))
    os.replace(LED + ".tmp", LED)
    print("flipped %d item(s); wrote %s (backup %s.bak_repub)"
          % (len(flip), LED, LED))
    return 0


if __name__ == "__main__":
    sys.exit(main())