#!/usr/bin/env python3
"""Park theorem nodes whose Lean name is already provided by a Def bundle.

`classify` can put the same declaration in two layers: once inside a chapter's
`Definitions/Def_<Chapter>.lean` bundle, and once as a theorem node of another
chapter that shares its namespace. `ChapterComplexShiftCore` and
`ChapterHashimotoShiftInvert` both live in `namespace BookProof.HashimotoShiftInvert`,
so `closed_of_selfAdjointCriterion` exists in a Def bundle AND gets a
`Theorems/Thm_...` stub. Submitting that stub is refused:

    formal statement does not compile: line 14:
    `BookProof.HashimotoShiftInvert.closed_of_selfAdjointCriterion` has already been declared

There is no local fix: the Lean name is fixed by the source, the Def bundle is
already PUBLISHED and cannot be edited, and re-publishing it under a new name
would break every consumer. So the node is permanently unpublishable as a
problem. Park it with a reason instead of letting each pass spend one of its 5
attempts on a guaranteed rejection.

    python3 debug/park_name_clashes.py [--undo]
"""
import argparse
import json
import os
import re
import glob

WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE = os.path.join(WS, "state", "pipeline.json")
WAVE = os.path.join(WS, "pipeline", "wave_upload.json")
MARK = "parked_name_clash"


def def_provided_names():
    """Fully-qualified names declared by any Def bundle, namespace-aware."""
    out = {}
    pat = re.compile(
        r"^\s*(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+)?"
        r"(?:def|abbrev|instance|structure|theorem|lemma)\s+([A-Za-z_]\w*)")
    # Scan BOTH the local tree and the PUBLISHED bundle cache. The platform
    # compiles a stub against what is actually published, and several chapters
    # were published from older generator versions whose bundles carry more
    # declarations than the local file does -- so a clash invisible locally is a
    # guaranteed server-side `has already been declared`.
    files = glob.glob(os.path.join(WS, "Definitions", "Def_Chapter*.lean"))
    files += glob.glob(os.path.join(WS, "state", "published_bundles", "Def_*.lean"))
    seen_files = set()
    for f in files:
        if f in seen_files:
            continue
        seen_files.add(f)
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
            d = pat.match(ln)
            if d:
                out.setdefault(d.group(1), set()).add(".".join(ns + [d.group(1)]))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--undo", action="store_true",
                    help="release parked nodes back to pending")
    args = ap.parse_args()

    wave = json.load(open(WAVE, encoding="utf-8"))
    st = json.load(open(STATE, encoding="utf-8"))
    items = st.setdefault("items", {})

    if args.undo:
        n = 0
        for it, rec in list(items.items()):
            if isinstance(rec, dict) and rec.get("note") == MARK:
                items[it] = {"status": "pending", "attempts": 0}
                n += 1
        json.dump(st, open(STATE, "w"), indent=1)
        print(f"released {n} parked node(s)")
        return 0

    provided = def_provided_names()
    hits = []
    for slug, rec in wave["thms"].items():
        name = rec.get("name") or ""
        short = name.split(".")[-1]
        if short and name in provided.get(short, ()):
            hits.append((slug, name))

    for slug, name in hits:
        items[f"thm:{slug}"] = {
            "status": "parked",
            "note": MARK,
            "platform_name": name,
            "reason": "a Def bundle already declares this name, so the stub is "
                      "rejected with 'has already been declared'",
        }
        items[f"sol:{slug}"] = {
            "status": "parked",
            "note": MARK,
            "reason": "its problem is unpublishable",
        }

    json.dump(st, open(STATE, "w"), indent=1)
    print(f"parked {len(hits)} theorem node(s) whose name a Def bundle provides")
    for slug, name in hits[:5]:
        print(f"  {name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())