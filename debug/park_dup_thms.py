#!/usr/bin/env python3
"""Resolve thm items that pass submission_guard but are refused by blocked_by.

The chunk's fill loop calls `blocked_by` AFTER the guard, so three terminal
verdicts never reach `apply_guard`'s park path (§2.52):

  target already published on the platform (NAME)
      the node EXISTS -> find it and mark the item `done`+reuse with its
      theorem_id; waiting on it forever (what the chunk does today) only
      stalls the sol behind it.
  target name already declared by published def bundle X
      the statement can never compile server-side ("already declared").
      Try find_existing first -- if the platform holds the node anyway,
      done+reuse beats park; otherwise PARK the thm and, with no node to be
      submitted against, its sol too (both would be re-discovered and
      skipped every round otherwise).
  statement relies on ambient variable `v`
      a real statement repair -- reported, never parked.

Scope: an explicit name list (default /tmp/uploadable_thm.txt) -- the items
that just passed the guard, i.e. exactly the set the chunk skips silently.

Single-writer: refuses to write while an upload_pipeline process is alive.
Usage: python3 debug/park_dup_thms.py [--apply] [--input FILE]
"""
import argparse
import json
import os
import re
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
os.chdir(WS)
sys.path.insert(0, os.path.join(WS, "pipeline"))

import upload_pipeline as up  # noqa: E402


def formal_of(slug):
    """(name, formal) split exactly the way do_wave_thm splits it."""
    path = f"{WS}/Theorems/Thm_{slug}.lean"
    try:
        txt = open(path, encoding="utf-8").read()
    except OSError:
        return None, None
    m = re.search(r"(?m)^theorem\s+([A-Za-z0-9_. '-]+?)\s*(?![A-Za-z0-9_'.!?])", txt)
    # Fall back to the wave spec's dotted name when the file's declaration
    # cannot be matched by slug.
    meta = up.WAVE_THMS.get(slug) or {}
    name = meta.get("name")
    if not m:
        return name, None
    start = m.start()
    formal = txt[start:].strip()
    if name is None:
        name = m.group(1).strip()
    if not formal.rstrip().endswith(":= by sorry"):
        return name, None
    return name, formal


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--input", default="/tmp/uploadable_thm.txt")
    ap.add_argument("--apply", action="store_true", help="write the ledger; default is dry")
    a = ap.parse_args()

    names = [l.strip() for l in open(a.input) if l.strip()]
    st = up.load_state()
    items = st["items"]
    published = up.published_defs()

    reuse, parked, repairs, unresolved = [], [], [], []
    for slug in names:
        item = f"thm:{slug}"
        rec = items.get(item) or {}
        if rec.get("status") not in (None, "pending"):
            continue
        reason = up.blocked_by(item, published)
        if not reason:
            continue
        name, formal = formal_of(slug)
        found = None
        if reason.startswith(("target already published", "target name already declared")):
            if name and formal:
                try:
                    found = up.find_existing(name, formal)
                except Exception as e:      # API hiccup: do not park on a guess
                    print(f"  {slug}: find_existing error {e} -- left pending")
                    found = None
        if reason.startswith("target already published"):
            if found:
                tid, tname, tstatus = found
                items[item] = {"status": "done", "theorem_id": tid, "reused": True,
                               "reused_status": tstatus, "synced_from": "blocked_by"}
                reuse.append((slug, tstatus, tid))
            else:
                # blocked_by saw the name among PUBLISHED problems but the
                # search cannot pair it with our statement -- pairing must not
                # be guessed; leave it for a human/next round.
                unresolved.append((slug, reason))
        elif reason.startswith("target name already declared"):
            if found:
                tid, tname, tstatus = found
                items[item] = {"status": "done", "theorem_id": tid, "reused": True,
                               "reused_status": tstatus, "synced_from": "blocked_by"}
                reuse.append((slug, tstatus, tid))
            else:
                err = f"duplicate declaration: {reason[:240]}"
                items[item] = {"status": "parked", "error": err}
                parked.append(slug)
                sol = items.get(f"sol:{slug}")
                if sol and sol.get("status") == "pending":
                    sol["status"] = "parked"
                    sol["error"] = ("no platform node: own statement is dup-declared "
                                    f"by {reason.rsplit(' ', 1)[-1]}"[:300])
                    parked.append(f"sol:{slug}")
        else:
            repairs.append((slug, reason))

    print(f"reuse->done: {len(reuse)}   parked: {len(parked)}   "
          f"repair needed: {len(repairs)}   unresolved: {len(unresolved)}")
    for slug, stt, tid in reuse:
        print(f"  DONE  {slug} ({stt}) {tid}")
    for p in parked:
        print(f"  PARK  {p}")
    for slug, r in repairs:
        print(f"  FIX   {slug}: {r}")
    for slug, r in unresolved:
        print(f"  ???   {slug}: {r}")

    if a.apply and (reuse or parked):
        if os.system("pgrep -f '[u]pload_pipeline.py' >/dev/null") == 0:
            print("ABORT: an upload_pipeline process is alive (single-writer rule)")
            return 2
        tmp = "state/pipeline.json.tmp"
        with open(tmp, "w") as fh:
            json.dump(st, fh, indent=1)
        os.replace(tmp, "state/pipeline.json")
        print(f"ledger written: {len(reuse)} done, {len(parked)} parked")
    return 0


if __name__ == "__main__":
    sys.exit(main())
