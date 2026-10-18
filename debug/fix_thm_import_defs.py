#!/usr/bin/env python3
"""Add the missing `import Theorems.Thm_…` line to root-FAIL def bundles.

A def bundle in `Definitions/` is generated from ONE source chapter, but chapters
cite each other's *theorems*.  The generator emits `import Definitions.Def_X` for a
cited chapter, which resolves the `def`s that chapter defines and nothing else: a
cited **theorem** lives in `Theorems/Thm_BookProof_<Ch>_<decl>.lean`, so the bundle
fails elaboration with `Unknown identifier 'scoreSoftmax_sum_one'` even though the
import "looks" present.  This is the largest root-FAIL class (26 of 43 in the
2026-10-12 def gate) and it is a one-line repair, not a proof problem -- the stub
exists and its source theorem is in 25 of 26 cases already Proved on the platform.

Which stub, when the same bare name exists in several chapters: the bundle's own
`open BookProof.<Ch>` lines name the namespaces it is inside, so a stub whose
chapter is opened there is the one Lean would resolve.  Ties (and no match) are
reported `AMBIGUOUS` instead of guessed -- the mirror build is the oracle and a
wrong guess costs a whole gate pass.

Writes nothing when the import is already present or the target cannot be
disambiguated, and refuses to write a bundle whose text it did not just read
(the §2.41-9 lesson: a no-op rewrite re-arms a cached rejection).

Usage:
  python3 debug/fix_thm_import_defs.py [--classified tsv] [--dry-run]
  python3 debug/fix_thm_import_defs.py --apply
"""
import argparse
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

RE_IMPORT = re.compile(r"(?m)^import\s+(\S+)")


def stub_index():
    """{bare decl name -> [stub slug]} over Theorems/Thm_BookProof_*."""
    out = {}
    d = os.path.join(WS, "Theorems")
    for fn in sorted(os.listdir(d)):
        if not (fn.startswith("Thm_BookProof_") and fn.endswith(".lean")):
            continue
        slug = fn[len("Thm_"):-len(".lean")]
        rest = slug[len("BookProof_"):]
        ch, _, decl = rest.partition("_")
        out.setdefault(decl, []).append((ch, slug))
    return out


def opened_chapters(text):
    """Chapters named by a leading `open BookProof.<Ch> …` line."""
    chs = set()
    for m in re.finditer(r"(?m)^open\s+([^\n]*)$", text):
        for tok in m.group(1).split():
            if tok.startswith("BookProof."):
                chs.add(tok[len("BookProof."):])
    return chs


def place_import(text, module):
    """Insert `import <module>` keeping the import block sorted."""
    if f"import {module}" in text:
        return text, False
    lines = text.splitlines(keepends=True)
    idx = [i for i, l in enumerate(lines) if l.startswith("import ")]
    if not idx:
        return text, False                     # no header to extend
    # Mathlib convention in this repo: local imports first, Mathlib last.
    target = f"import {module}\n"
    pos = idx[-1]
    for i in idx:
        if lines[i] > target:
            pos = i
            break
    else:
        pos = idx[-1] + 1
    lines.insert(pos, target)
    return "".join(lines), True


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--classified", default="/tmp/rootfail_classified.tsv")
    ap.add_argument("--apply", action="store_true",
                    help="write the bundles (default: dry run)")
    ap.add_argument("--dry-run", action="store_true")
    a = ap.parse_args()
    apply_ = a.apply and not a.dry_run

    stubs = stub_index()
    rows = [l.rstrip("\n").split("\t")
            for l in open(a.classified, encoding="utf-8")]
    thm_rows = [r for r in rows if len(r) >= 5 and r[2] == "thm-stub"]
    print(f"thm-stub root FAILs: {len(thm_rows)}")

    results = []
    for chap, _line, _cls, ident, _note in thm_rows:
        base = ident.split(".")[-1]
        path = os.path.join(WS, "Definitions", f"Def_{chap}.lean")
        if not os.path.exists(path):
            results.append((chap, "NO-BUNDLE", ""))
            continue
        text = open(path, encoding="utf-8").read()
        cands = stubs.get(base, [])
        if not cands:
            results.append((chap, "NO-STUB", base))
            continue
        if len(cands) == 1:
            chosen = cands[0]
        else:
            opened = opened_chapters(text)
            hits = [c for c in cands if c[0] in opened]
            # A namespaced ident `BookProof.<Ch>.decl` is decisive on its own.
            ns = ident.rsplit(".", 1)[0]
            if ns.startswith("BookProof."):
                exact = ns[len("BookProof."):]
                hits = [c for c in cands if c[0] == exact] or hits
            if len(hits) == 1:
                chosen = hits[0]
            else:
                results.append((chap, "AMBIGUOUS",
                                base + " -> " + ",".join(c[0] for c in cands)))
                continue
        _ch, slug = chosen
        # The file is `Thm_<slug>.lean`, so the MODULE is `Theorems.Thm_<slug>`:
        # `slug` already has the `Thm_` prefix stripped by stub_index().
        new, changed = place_import(text, f"Theorems.Thm_{slug}")
        if not changed:
            results.append((chap, "ALREADY", slug))
            continue
        if apply_:
            open(path, "w", encoding="utf-8").write(new)
        results.append((chap, "ADDED" if apply_ else "WOULD-ADD", slug))

    w = max(len(c) for c, _, _ in results)
    for chap, st, note in results:
        print(f"{chap:<{w}}  {st:<11} {note}")
    n = sum(1 for _, s, _ in results if s in ("ADDED", "WOULD-ADD"))
    print(f"\n{n} bundle(s) {'written' if apply_ else 'would change'}; "
          f"{sum(1 for _, s, _ in results if s == 'AMBIGUOUS')} ambiguous need a human")
    return 0


if __name__ == "__main__":
    sys.exit(main())
