#!/usr/bin/env python3
"""Find theorem stubs whose `variable` block declares the same name TWICE with a
different binder annotation or a different type.

Lean 4 treats a re-declaration of a name with a different annotation as a NEW
variable: `variable {D : Submodule ℂ H}` followed by `variable (D : Submodule ℂ H)`
gives a second binder, and the generated statement then constrains one `D` while
its conclusion is about the other.  That is exactly the §8 FockStatistics defect
(`bosonicFock_esa`, `essentiallySelfAdjointOn_bosonic_core_of_esa`,
`essentiallySelfAdjointOn_fermionic_core_of_esa`): the node is published, it can
never be proved, and no solution can match it.

An *identical* re-declaration is harmless (Lean keeps one variable), so the
naive "same name twice" grep over the corpus returns ~500 stubs of which almost
all are fine.  This script compares the annotation (`(...)`, `{...}`, `[...]`)
and the type text, and reports only the pairs that actually disagree.

Usage:
    python3 debug/find_dup_variable.py                # whole Theorems/
    python3 debug/find_dup_variable.py --only FockStatistics
    python3 debug/find_dup_variable.py --status       # add the ledger status

Exit 0 always (a report, not a gate).
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# `{a b : T}`, `(A : T)`, `[inst : C T]` inside one `variable` line (which may
# continue on the following 2-space-indented lines).
BINDER = re.compile(r"([\{\(\[])\s*([^{}()\[\]:]+?)\s*:\s*")
OPEN = {"{": "}", "(": ")", "[": "]"}


def blocks(text):
    """Yield (start_line, [(annotation, [names], type_text)]) for each
    contiguous `variable` block (a `variable` line plus its continuations)."""
    lines = text.split("\n")
    i = 0
    while i < len(lines):
        if not lines[i].startswith("variable "):
            i += 1
            continue
        start = i
        chunk = lines[i][len("variable "):]
        j = i + 1
        while j < len(lines) and (lines[j].startswith("  ") or
                                  lines[j].startswith("\t")) and lines[j].strip():
            chunk += "\n" + lines[j]
            j += 1
        yield start, parse(chunk)
        i = j


def parse(chunk):
    """Split a variable block into binders, respecting nesting of ({[."""
    out = []
    i = 0
    n = len(chunk)
    while i < n:
        m = BINDER.search(chunk, i)
        if not m:
            break
        op = m.group(1)
        names = m.group(2).split()
        depth = 1
        k = m.end()
        while k < n and depth:
            ch = chunk[k]
            if ch in "({[":
                depth += 1
            elif ch in ")}]":
                depth -= 1
                if depth == 0:
                    break
            k += 1
        type_text = " ".join(chunk[m.end():k].split())
        out.append((op, names, type_text))
        i = k + 1
    return out


def duplicates(path):
    """name -> list of (line, annotation, type) occurring in more than one
    *distinct* form."""
    text = open(path, encoding="utf-8").read()
    seen = {}
    for start, binders in blocks(text):
        for op, names, ty in binders:
            for nm in names:
                seen.setdefault(nm, []).append((start + 1, op, ty))
    bad = {}
    for nm, occ in seen.items():
        forms = {(op, ty) for _, op, ty in occ}
        if len(forms) > 1:
            bad[nm] = occ
    return bad


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--only", default=None)
    ap.add_argument("--status", action="store_true")
    a = ap.parse_args()

    led = {}
    if a.status:
        led = json.load(open(os.path.join(WS, "state", "pipeline.json"))).get(
            "items", {})

    d = os.path.join(WS, "Theorems")
    hits = []
    for fn in sorted(os.listdir(d)):
        if not fn.endswith(".lean"):
            continue
        slug = fn[4:-5]
        if a.only and a.only not in slug:
            continue
        bad = duplicates(os.path.join(d, fn))
        if bad:
            hits.append((slug, bad))

    print(f"{len(hits)} stub(s) declare a variable twice with a different "
          f"annotation or type")
    for slug, bad in hits:
        extra = ""
        if a.status:
            extra = (f"  [thm {(led.get('thm:' + slug) or {}).get('status')}, "
                     f"sol {(led.get('sol:' + slug) or {}).get('status')}]")
        print(f"\n  {slug}{extra}")
        for nm, occ in bad.items():
            forms = " | ".join(f"L{l} {op}…{OPEN[op]} : {ty}"
                               for l, op, ty in occ)
            print(f"    {nm}: {forms[:220]}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
