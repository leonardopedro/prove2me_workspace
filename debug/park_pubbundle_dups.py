#!/usr/bin/env python3
"""Park thm/sol items that a PUBLISHED def bundle already declares.

`debug/park_name_clashes.py` parks every wave thm whose name any Def bundle
provides, scanning the local tree AND the published cache alike.  That is
correct only for the published half: a name a *published* bundle declares can
never be published as a problem (the server compile is a guaranteed
`has already been declared`), while a name only the LOCAL tree declares is
submittable today -- the published bundle is what the server compiles against,
and most of those local-only clashes sit on ledger `done` records that must not
be touched either.

This script therefore parks exactly one class:

    wave thm item, ledger status pending/absent,
    name declared by a bundle in state/published_bundles/
      -> thm  parked  (reason: which bundle declares the name)
      -> sol  parked  (only when its thm is parked here or already parked,
                       and only when the sol is not already terminal)

Before parking, the platform's own publish-job catalogue is consulted once:
a clashing name that nevertheless has a PUBLISHED problem node is flipped to
`done` + reuse instead (`done` beats `parked` -- sync_state's own rule).
Measured 2026-10-23: 275 pending thms clash with a published bundle and 0 of
them have a published node, so the reuse branch is defensive, not load-bearing.

Terminal records (`done`/`failed`/`parked`) are never rewritten, in either
layer: `done` is evidence the platform accepted the item already, and the
3,855 local-only clashes are overwhelmingly in that state.

Single-writer: refuses to write while an upload_pipeline process is alive.
Backup: state/pipeline.json.bak_pubdup before every write.

Usage:
  python3 debug/park_pubbundle_dups.py            # dry run
  python3 debug/park_pubbundle_dups.py --apply
  python3 debug/park_pubbundle_dups.py --undo     # release this marker only
"""
import argparse
import glob
import json
import os
import re
import subprocess
import sys
import time

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
os.chdir(WS)
sys.path.insert(0, os.path.join(WS, "pipeline"))

import upload_pipeline as up  # noqa: E402

MARK = "parked_pubbundle_dup"
DECL = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+)?"
    r"(?:def|abbrev|instance|structure|theorem|lemma)\s+([A-Za-z_]\w*)")


def scan_decls(files):
    """(short name -> set of fully-qualified names) plus fq -> owning file stem."""
    prov, owner = {}, {}
    for f in files:
        stem = os.path.basename(f)
        if stem.startswith("Def_"):
            stem = stem[4:]
        if stem.endswith(".lean"):
            stem = stem[:-5]
        ns = []
        for ln in open(f, encoding="utf-8", errors="ignore"):
            m = re.match(r"^namespace\s+([\w.]+)", ln)
            if m:
                ns.append(m.group(1))
                continue
            if re.match(r"^end\s", ln):
                if ns:
                    ns.pop()
                continue
            d = DECL.match(ln)
            if d:
                fq = ".".join(ns + [d.group(1)])
                prov.setdefault(d.group(1), set()).add(fq)
                owner[fq] = stem
    return prov, owner


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--apply", action="store_true", help="write the ledger")
    ap.add_argument("--undo", action="store_true",
                    help="release items parked by this marker")
    a = ap.parse_args()

    state_path = os.path.join(WS, "state", "pipeline.json")
    st = json.load(open(state_path, encoding="utf-8"))
    items = st.setdefault("items", {})

    if a.undo:
        n = 0
        for it, rec in list(items.items()):
            if isinstance(rec, dict) and rec.get("note") == MARK:
                items[it] = {"status": "pending", "attempts": 0}
                n += 1
        if n:
            json.dump(st, open(state_path, "w"), indent=1)
        print(f"released {n} item(s) parked by {MARK}")
        return 0

    pub_prov, pub_owner = scan_decls(
        glob.glob(os.path.join(WS, "state", "published_bundles", "Def_*.lean")))

    wave = json.load(open(os.path.join(WS, "pipeline", "wave_upload.json"),
                          encoding="utf-8"))
    clashes = []  # (slug, fq name, published bundle)
    for slug, rec in wave["thms"].items():
        name = rec.get("name") or ""
        short = name.split(".")[-1]
        if short and name in pub_prov.get(short, ()):
            clashes.append((slug, name, pub_owner.get(name, "?")))

    def pending(item):
        return (items.get(item) or {}).get("status") in (None, "pending")

    targets = [(s, n, b) for s, n, b in clashes if pending(f"thm:{s}")]
    if not targets:
        print("no pending thm clashes with a published bundle -- nothing to do")
        return 0

    # One catalogue read for the whole pass (defensive done+reuse branch).
    names = {n for _, n, _ in targets}
    published_nodes = {}
    try:
        for j in up._paged("publish-jobs", {"kind": "problem"}):
            nm = j.get("theorem_name") or ""
            if nm in names and j.get("status") == "PUBLISHED":
                prev = published_nodes.get(nm)
                if prev is None or (j.get("updated_at") or "") > \
                        (prev.get("updated_at") or ""):
                    published_nodes[nm] = j
    except Exception as e:  # API hiccup: park nothing on a guess
        print(f"ABORT: publish-job catalogue unreadable ({e}); nothing written")
        return 2

    reuse, parked, parked_sols = [], [], []
    for slug, name, bundle in sorted(targets):
        node = published_nodes.get(name)
        if node:
            items[f"thm:{slug}"] = {
                "status": "done", "theorem_id": node.get("theorem_id"),
                "reused": True, "reused_status": "PUBLISHED",
                "synced_from": "pubbundle-dup"}
            reuse.append((slug, name))
            continue
        items[f"thm:{slug}"] = {
            "status": "parked", "note": MARK, "platform_name": name,
            "declared_by": bundle,
            "reason": f"published def bundle Def_{bundle} already declares "
                      f"{name}, so the stub is a guaranteed "
                      f"'has already been declared'"}
        parked.append((slug, name, bundle))
        sol_status = (items.get(f"sol:{slug}") or {}).get("status")
        if sol_status in (None, "pending"):
            items[f"sol:{slug}"] = {
                "status": "parked", "note": MARK,
                "reason": f"its problem is unpublishable: Def_{bundle} "
                          f"(published) already declares {name}"}
            parked_sols.append(slug)

    print(f"clashes vs published bundles: {len(clashes)} total, "
          f"{len(targets)} with a pending thm")
    print(f"  reuse->done: {len(reuse)}   park thm: {len(parked)}   "
          f"park sol: {len(parked_sols)}")
    for s, n in reuse[:10]:
        print(f"  DONE  {n} ({s})")
    for s, n, b in parked[:15]:
        print(f"  PARK  thm:{s}  <- Def_{b}")
    if len(parked) > 15:
        print(f"  ... and {len(parked) - 15} more")

    if not a.apply:
        print("dry run -- nothing written (use --apply)")
        return 0
    if not (reuse or parked):
        return 0
    if os.system("pgrep -f '[u]pload_pipeline.py' >/dev/null") == 0:
        print("ABORT: an upload_pipeline process is alive (single-writer rule)")
        return 2
    import shutil
    shutil.copy(state_path, state_path + ".bak_pubdup")
    tmp = state_path + ".tmp"
    with open(tmp, "w") as fh:
        json.dump(st, fh, indent=1)
    os.replace(tmp, state_path)
    print(f"ledger written at {time.strftime('%H:%M:%S')}: "
          f"{len(reuse)} done, {len(parked)} thm + {len(parked_sols)} sol parked "
          f"(backup state/pipeline.json.bak_pubdup)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
