#!/usr/bin/env python3
"""Iterate `make_promoted_def.py --defs-only` until the bundle compiles clean.

The Promoted bundle carries the chapter's declarations minus the ones that are
also problem nodes (those must stay theorems or the two routes collide, see the
docstring of `make_promoted_def.py`).  That leaves one failure mode: a kept
lemma's body citing an excluded node (`sub_add_singleK`, `sum_simplex_split`, …),
which fails with `Unknown identifier`.  Re-carrying exactly those nodes is the
minimal repair, so this driver compiles, reads the unknown names back, and adds
each one that is a node of this chapter to the carry set.  Converges because
every pass only grows the carry set and the set is finite; the nodes it ends up
carrying are reported so the ledger can park them (their proofs now live in the
bundle).

Usage:
  python3 debug/promote_def_closure.py ChapterCarlemanTwoStep [--dep ChapterCarlemanTwoStep]
"""
import argparse
import re
import subprocess
import sys

import make_promoted_def as mpd

HERE = mpd.WS + "/debug"
COMPILE = f"{HERE}/_compile_defs.sh"


def compile_bundle(chap):
    r = subprocess.run(["bash", COMPILE, f"Def_{chap}Promoted"],
                       cwd=mpd.WS, capture_output=True, text=True, timeout=2400)
    return r.returncode == 0, r.stdout + r.stderr


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapter", nargs="+")
    ap.add_argument("--dep", action="append", default=[])
    ap.add_argument("--drop", action="append", default=[])
    ap.add_argument("--max-passes", type=int, default=6)
    a = ap.parse_args()

    rc = 0
    for chap in a.chapter:
        carry, deps, drops = set(), set(a.dep), set(a.drop)
        for p in range(1, a.max_passes + 1):
            mpd.build(chap, deps, drops, False, carry)
            ok, out = compile_bundle(chap)
            if ok:
                print(f"OK   {chap}: compiles after {p} pass(es); carried nodes: "
                      f"{', '.join(sorted(carry)) or 'none'}")
                break
            names = set(re.findall(r"Unknown identifier `([A-Za-z_][A-Za-z0-9_.']*)`", out))
            nodes = mpd.node_names(chap)
            add = {n.split(".")[-1] for n in names if n.split(".")[-1] in nodes} - carry
            if not add:
                print(f"FAIL {chap}: no chapter node among the unknowns {sorted(names)[:6]}")
                print("\n".join(out.strip().split("\n")[-6:]))
                rc = 1
                break
            print(f"pass {p} {chap}: carrying {', '.join(sorted(add))}")
            carry |= add
        else:
            print(f"FAIL {chap}: did not converge")
            rc = 1
    return rc


if __name__ == "__main__":
    sys.path.insert(0, HERE)
    sys.exit(main())
