#!/usr/bin/env python3
"""Drop theorem/solution nodes whose own chapter's Def bundle already declares the name.

`classify` can emit the same declaration twice for one chapter: once inside
`Definitions/Def_<Chapter>.lean`, and once as a theorem node. The stub for that
node imports its own chapter's bundle, so the name is already in scope and the
platform refuses it:

    formal statement does not compile: line 16:
    `BookProof.ChapterH1.phi_zero_apply` has already been declared

The name is fixed by the source, so the node cannot be renamed, and the bundle
cannot shed the declaration without breaking the chapter body. The node is
therefore unpublishable. This removes those nodes from the plan (and parks the
state records) instead of letting each pass spend an attempt on them.

`wave_generate.py` no longer creates them -- it skips a node whose declaration
is in `defmat | embedded` -- but 185 were already emitted before that fix, so
this prunes them retroactively. Re-run `wave_generate.py` for the affected
chapters afterwards to delete the orphaned `Theorems/Thm_*.lean` files.

    python3 debug/prune_def_owned_nodes.py [--dry-run]
"""
import argparse
import glob
import json
import os
import re

WS = os.environ.get("PROVE2ME_WS") or os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE = os.path.join(WS, "state", "pipeline.json")
WAVE = os.path.join(WS, "pipeline", "wave_upload.json")

DECL = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+)?"
    r"(?:def|theorem|lemma|abbrev|instance|structure)\s+([A-Za-z_]\w*)")
THEOREM = re.compile(r"(?m)^theorem\s+([\w.]+)")


def def_provided():
    """Fully-qualified names declared by any local Def bundle, namespace-aware."""
    out = {}
    for f in glob.glob(os.path.join(WS, "Definitions", "Def_Chapter*.lean")):
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
                out.setdefault(d.group(1), set()).add(".".join(ns + [d.group(1)]))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry-run", action="store_true")
    args = ap.parse_args()

    wave = json.load(open(WAVE, encoding="utf-8"))
    st = json.load(open(STATE, encoding="utf-8"))
    items = st.setdefault("items", {})
    provided = def_provided()

    drop = []
    for f in glob.glob(os.path.join(WS, "Theorems", "Thm_*.lean")):
        m = THEOREM.search(open(f, encoding="utf-8", errors="ignore").read())
        if not m:
            continue
        full = m.group(1)
        if full in provided.get(full.split(".")[-1], ()):
            drop.append((os.path.basename(f)[4:-5], full))

    for slug, name in drop[:5]:
        print(f"  drop {slug[:56]:58} ({name.split('.')[-1]})")
    print(f"{len(drop)} node(s) re-declare a name a Def bundle provides")

    if args.dry_run or not drop:
        return 0

    for slug, name in drop:
        wave["thms"].pop(slug, None)
        items.pop(f"thm:{slug}", None)
        items.pop(f"sol:{slug}", None)
    wave["sol_order"] = [s for s in wave["sol_order"] if s not in {d[0] for d in drop}]
    json.dump(wave, open(WAVE, "w"), indent=1)
    json.dump(st, open(STATE, "w"), indent=1)
    print(f"pruned {len(drop)} node(s); thms now {len(wave['thms'])}, "
          f"sol_order {len(wave['sol_order'])}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())