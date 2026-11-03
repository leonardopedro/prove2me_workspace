#!/usr/bin/env python3
"""Register the two orphan Carleman thm items in `pipeline/wave_upload.json`.

`thm:BookProof_CarlemanUnboundedHop_{kernelOp_symmetric,ladderRec_of_deficiency}`
have ledger items and generated stubs + sols, but no `thms` entry and no
`sol_order` row.  The wave path resolves every item through `WAVE_THMS[slug]`,
so without an entry the drain can never pick them up -- the same orphan shape
`geoHop_essentiallySelfAdjoint` had before Session 30 registered it.

The entry is built exactly like the neighbour `geoHop_essentiallySelfAdjoint`
(title = backticked name + the stub's own signature, nl = the standard
"Prove the following Lean 4 theorem" text), and the `sol_order` rows go after
the last Carleman row so every dependency listed by the sols is already ahead.

Usage: python3 debug/register_orphan_thms.py [--write]
"""
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WAVE = f"{WS}/pipeline/wave_upload.json"
CHAPTER = "ChapterCarlemanUnboundedHop"
SLUGS = [
    "BookProof_CarlemanUnboundedHop_kernelOp_symmetric",
    "BookProof_CarlemanUnboundedHop_ladderRec_of_deficiency",
]
ANCHOR = "BookProof_CarlemanUnboundedHop_geoHop_stone_flow"


def entry_for(slug):
    thr = f"{WS}/Theorems/Thm_{slug}.lean"
    txt = open(thr, encoding="utf-8").read()
    m = re.search(r"(?m)^theorem\s+(\S+)", txt)
    if not m:
        raise SystemExit(f"no theorem declaration in {thr}")
    name = m.group(1)
    end = txt.find(":= by sorry", m.start())
    if end < 0:
        raise SystemExit(f"no `:= by sorry` in {thr}")
    decl = txt[m.start():end].rstrip()
    sig = decl[len("theorem "):].strip()
    sig = sig[len(name):].rstrip() if sig.startswith(name) else sig
    title = f"`{name}`{sig}"
    nl = (f"Prove the following Lean 4 theorem from `{CHAPTER}`.\n\n{title}\n\n"
          f"Formalization note: Lean 4 identifier `{name}`.")
    return {
        "name": name,
        "chapter": CHAPTER,
        "file": f"Theorems/Thm_{slug}.lean",
        "sol": f"Solutions/Sol_{slug}.lean",
        "ns": ".".join(name.split(".")[:-1]),
        "plen": decl.count("\n") + 1,
        "title": title,
        "nl": nl,
        "source": "",
        "tags": ["timepiece", "theorems"],
    }


def main():
    write = "--write" in sys.argv
    w = json.loads(open(WAVE, encoding="utf-8").read())
    thms, order = w["thms"], w["sol_order"]
    added = []
    for slug in SLUGS:
        if slug in thms:
            print(f"  already registered: {slug}")
            continue
        e = entry_for(slug)
        thms[slug] = e
        added.append(slug)
        print(f"  + thms[{slug}]  name={e['name']}  plen={e['plen']}")
    if not added:
        print("nothing to add")
        return 0
    i = order.index(ANCHOR)
    for k, slug in enumerate(added):
        if slug in order:
            order.remove(slug)
        order.insert(i + 1 + k, slug)
        print(f"  + sol_order[{i + 1 + k}] = {slug}")
    print(f"thms: {len(thms)}  sol_order: {len(order)}")
    if not write:
        print("dry run -- use --write")
        return 0
    with open(WAVE, "w", encoding="utf-8") as fh:
        fh.write(json.dumps(w, indent=1, ensure_ascii=False))
    print(f"wrote {WAVE}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
