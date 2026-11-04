#!/usr/bin/env python3
"""Give a def bundle the published theorem modules that declare the names it cites.

The served `Def_` catalogue is largely *hollow*: `state/published_bundles/Def_Chapter
FockWeightedSchurEsa.lean` is the 9-line "Generated def bundle for …" stub, while the
workspace bundle is 867 lines.  So a bundle that cites `gaussInt_neg`,
`dGamma_fqPoly_essentiallySelfAdjointOn_core` or `degW_ge_one` compiles locally (the
candidate mirror still holds an older `.olean` that declares them) and fails on the
platform with `Unknown identifier`.  Those statements do exist — as published
`Theorems/Thm_BookProof_*_<name>.lean` modules — the bundle just never imported them.

This tool answers exactly that question, without compiling and therefore without
being fooled by a stale `.olean`:

  names_used(bundle) ∩ declared_in_corpus − declared_locally − declared_in_served

Every survivor that has a published `Thm_` module becomes an import; the rest are
reported as real gaps (they need content, not an import).

Usage:
    python3 debug/add_thm_provider_imports.py ChapterDegSchrodingerCore --apply
    python3 debug/add_thm_provider_imports.py ChapterFoo ChapterBar          # report
"""
import argparse
import glob
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MIRROR = os.environ.get("CANDIDATE_MIRROR", os.path.join(WS, "state", "mirror"))


def decls(path):
    try:
        txt = open(path, encoding="utf-8", errors="ignore").read()
    except OSError:
        return set()
    return set(re.findall(
        r"(?m)^(?:@\[[^\]]*\]\s*)?(?:theorem|def|abbrev|lemma|structure|inductive)\s+"
        r"([A-Za-z_][\w.']*)", txt))


# Ordinary English words that happen to collide with a corpus declaration name; a
# bundle's prose would otherwise "use" them.
STOP = {"for", "given", "diagonalizes", "then", "hence", "since", "where", "and",
        "the", "with", "its", "into", "onto", "iff", "not", "all", "any", "one"}


def served_decls():
    out = set()
    for p in glob.glob(os.path.join(MIRROR, "Definitions", "*.lean")):
        out |= decls(p)
    return out


def corpus_decls():
    out = set()
    for pat in ("Definitions/*.lean", "BookProof/*.lean", "BookProof/**/*.lean"):
        for p in glob.glob(os.path.join(WS, pat), recursive=True):
            out |= decls(p)
    return out


def published_thm_modules():
    """declaration name (and its last component) -> Thm module that declares it.

    Both spellings matter: a bundle writes `QgHermiteFriedrichs.inner_pgLp_pgLp`
    while the stub declares `BookProof.QgHermiteFriedrichs.inner_pgLp_pgLp`, so a
    short-name-only map misses every namespaced lemma.
    """
    try:
        items = json.load(open(os.path.join(WS, "state", "pipeline.json")))["items"]
    except (OSError, ValueError):
        return {}
    pub = {k[4:] for k, v in items.items()
           if k.startswith("thm:") and v.get("status") == "done"}
    out = {}
    for p in glob.glob(os.path.join(WS, "Theorems", "Thm_BookProof_*.lean")):
        mod = os.path.basename(p)[:-5]
        if mod[4:] not in pub:
            continue
        m = re.search(r"(?m)^theorem\s+([A-Za-z_][\w.']*)",
                      open(p, encoding="utf-8", errors="ignore").read())
        if m:
            full = m.group(1)
            out.setdefault(full.split(".")[-1], mod)
            out.setdefault(full, mod)
            # `QgHermiteFriedrichs.x` is how the consumer spells `BookProof.
            # QgHermiteFriedrichs.x`.
            parts = full.split(".")
            for i in range(1, len(parts) - 1):
                out.setdefault(".".join(parts[i:]), mod)
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapters", nargs="+")
    ap.add_argument("--apply", action="store_true")
    a = ap.parse_args()

    served = served_decls()
    corpus = corpus_decls()
    providers = published_thm_modules()
    rc = 0
    for ch in a.chapters:
        path = os.path.join(WS, "Definitions", f"Def_{ch}.lean")
        if not os.path.exists(path):
            print(f"{ch}: no bundle at {path}")
            rc = 1
            continue
        txt = open(path, encoding="utf-8").read()
        local = decls(path)
        imported = {m.replace("Theorems.", "")
                    for m in re.findall(r"^import (Theorems\.\S+)", txt, re.M)}
        used = set(re.findall(r"[A-Za-z_][A-Za-z0-9_.']*", txt))
        need, gap = [], []
        for n in sorted((used & corpus) - local - served):
            if n in STOP:
                continue
            mod = providers.get(n)
            if mod and mod not in imported:
                need.append((n, mod))
            elif not mod:
                gap.append(n)
        print(f"{ch}: {len(need)} import(s) to add, {len(gap)} real gap(s)")
        for n, mod in need:
            print(f"   + {mod}   ({n})")
        for n in gap:
            print(f"   ! no published provider: {n}")
        rc = rc or bool(gap)
        if not a.apply or not need:
            continue
        block = "".join(f"import Theorems.{mod}\n\n" for _, mod in need)
        txt = block + txt
        with open(path, "w", encoding="utf-8") as fh:
            fh.write(txt)
        print(f"   wrote {len(need)} import(s) into {os.path.basename(path)}")
    return 1 if rc else 0


if __name__ == "__main__":
    sys.exit(main())
