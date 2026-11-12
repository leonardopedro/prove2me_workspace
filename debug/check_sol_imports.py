#!/usr/bin/env python3
"""Is every `import` of a stub/sol actually available on the platform?

A submission whose import block cannot be satisfied does not fail politely:
`mem_simplexF` came back with `line 8: unknown namespace BookProof.CarlemanSimplex`,
`line 13: unknown namespace Finset`, `line 14: … BookProof.HermiteCarleman` —
`Finset` is Mathlib, so the whole import block was dropped, not one module
rejected.  One bad `import Definitions.Def_ChapterXPromoted` is enough, and the
error text the platform returns points at the `open` lines instead, which reads
like a statement defect.

So check the imports BEFORE spending an attempt:

  * `import Definitions.Def_X`  -> `def:ChapterX` must be a PUBLISHED job;
  * `import Theorems.Thm_<slug>` -> that problem must be PUBLISHED (its
    statement node exists; a parked node exists only locally);
  * `import Mathlib` is free.

Usage:
  python3 debug/check_sol_imports.py BookProof_Foo_bar [--solutions|--theorems]
  python3 debug/check_sol_imports.py --from-file slugs.txt
Exit 0 when every import is available, 1 when one is not.
"""
import argparse
import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("slugs", nargs="*")
    ap.add_argument("--from-file", default=None)
    ap.add_argument("--solutions", action="store_true", default=True)
    ap.add_argument("--theorems", dest="solutions", action="store_false")
    a = ap.parse_args()
    slugs = list(a.slugs)
    if a.from_file:
        slugs += [l.strip() for l in open(a.from_file) if l.strip()]
    if not slugs:
        ap.error("no slugs")

    jobs = up.platform_jobs()
    pub_defs = {n for n, j in jobs.items()
                if j.get("kind") == "definition" and j.get("status") == "PUBLISHED"}
    pub_thms = {n for n, j in jobs.items()
                if j.get("kind") == "problem" and j.get("status") == "PUBLISHED"}
    bad_total = 0
    for s in slugs:
        d = "Solutions" if a.solutions else "Theorems"
        p = os.path.join(WS, d, "%s_%s.lean" % ("Sol" if a.solutions else "Thm", s))
        if not os.path.exists(p):
            print("NOSRC %s" % p)
            bad_total += 1
            continue
        text = open(p, encoding="utf-8").read()
        bad = []
        for m in re.finditer(r"(?m)^import (\S+)", text):
            mod = m.group(1)
            if mod == "Mathlib" or mod.startswith("Mathlib."):
                continue
            if mod.startswith("Definitions."):
                name = mod[len("Definitions."):]
                if name.startswith("Def_"):
                    name = name[4:]
                if name not in pub_defs and ("Chapter" + name) not in pub_defs:
                    bad.append(mod)
            elif mod.startswith("Theorems."):
                t = mod[len("Theorems."):]
                if t.startswith("Thm_"):
                    t = t[4:]
                # platform names are dotted; the job dict is keyed by name
                cand = [n for n in pub_thms if n.replace(".", "_") == t]
                if not cand:
                    bad.append(mod)
            else:
                bad.append(mod)
        if bad:
            bad_total += 1
            print("%-64s UNAVAILABLE: %s" % (s, ", ".join(bad)))
        else:
            print("%-64s ok (%d import(s) available)" % (s, len(text.split("import ")) - 1))
    return 1 if bad_total else 0


if __name__ == "__main__":
    sys.exit(main())
