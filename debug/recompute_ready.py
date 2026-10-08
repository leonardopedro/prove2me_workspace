#!/usr/bin/env python3
"""Recompute ready lists for the bounded guarded drain (PIPELINE_PLAN §2.15).

SOL ready = own thm:<slug> done
          ∧ fresh-ok sol verdict (offline json newer than the sol file)
          ∧ every import Theorems.Thm_M sibling (spelling-aware: _prime <-> ')
            has thm done  -- sibling SOL done NOT required: a solution compiles
            against its own statement, so an imported sibling only has to be
            PUBLISHED (API-verified; the submission guard checks exactly this
            in unpublished_sibling_imports).  Requiring the sibling's sol too
            held 437 sols hostage for nothing.
          ∧ every import Definitions.Def_M has def:<slug> done
THM ready = fresh-ok thm verdict
          ∧ every import Definitions.Def_M done
          ∧ every Theorems.Thm_M sibling has thm done AND sol done
            (a STATEMENT needs the sibling Proved: `Imported platform theorems
            must be Proved at submission time`)

Writes the union as `--only <slug>` lines to /tmp/drain2_args.txt plus
diagnostic lists /tmp/ready_thms.txt, /tmp/ready_sols.txt, and a reason
breakdown of what blocks the rest.
"""
import json
import os
import re
from collections import Counter

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OFF = os.path.join(WS, "state", "offline_pending_check.json")
STATE = os.path.join(WS, "state", "pipeline.json")

IMPORT_THM = re.compile(r"^import\s+Theorems\.Thm_(\S+)", re.M)
IMPORT_DEF = re.compile(r"^import\s+Definitions\.Def_(\S+)", re.M)


def thm_spellings(mod: str):
    """Candidate state slugs for an imported Theorems.Thm_<mod> module."""
    cands = [mod]
    if mod.endswith("_prime"):
        cands.append(mod[:-6] + "'")
    if "'" in mod:
        cands.append(mod.replace("'", "_prime"))
    if "_prime" in mod:
        cands.append(mod.replace("_prime", "'"))
    return cands


def def_slugs(mod: str):
    return [mod[4:]] if mod.startswith("Def_") else [mod]


def main():
    st = json.load(open(STATE))
    items = st["items"] if "items" in st else st
    off = json.load(open(OFF))
    off_mtime = os.path.getmtime(OFF)
    off_items = {k: off.get(k, {}).get("items", {}) for k in ("thm", "sol")}

    def status(kind, slug):
        v = items.get(f"{kind}:{slug}")
        return v.get("status") if isinstance(v, dict) else None

    def done(kind, slug):
        return status(kind, slug) == "done"

    def fresh_ok(kind, slug):
        verdict = off_items[kind].get(slug)
        if not (isinstance(verdict, str) and verdict.startswith("ok")):
            return False
        if kind == "thm":
            path = os.path.join(WS, "Theorems", f"Thm_{slug}.lean")
        else:
            path = os.path.join(WS, "Solutions", f"Sol_{slug}.lean")
        try:
            return os.path.getmtime(path) <= off_mtime
        except OSError:
            return False

    def imports_of(kind, slug):
        if kind == "thm":
            path = os.path.join(WS, "Theorems", f"Thm_{slug}.lean")
        else:
            path = os.path.join(WS, "Solutions", f"Sol_{slug}.lean")
        try:
            text = open(path, encoding="utf-8").read()
        except OSError:
            return None
        thms = IMPORT_THM.findall(text)
        defs = IMPORT_DEF.findall(text)
        return thms, defs

    def siblings_ok(thm_mods, need_sol=True):
        """thm modules all published?  need_sol (THM layer only) additionally
        requires the sibling's solution landed -- i.e. the sibling problem is
        Proved on the platform, which a STATEMENT needs and a SOLUTION does
        not (it is compiled against its own statement)."""
        for m in thm_mods:
            if not any(done("thm", s) for s in thm_spellings(m)):
                return False
            if need_sol and not any(done("sol", s) for s in thm_spellings(m)):
                return False
        return True

    def defs_ok(def_mods):
        for m in def_mods:
            if not any(done("def", s) for s in def_slugs(m)):
                return False
        return True

    ready_thms, ready_sols = [], []
    block_thm = Counter()
    block_sol = Counter()

    # THM layer
    for slug, v in items.items():
        if not slug.startswith("thm:"):
            continue
        s = slug[4:]
        if not isinstance(v, dict) or v.get("status") != "pending":
            continue
        im = imports_of("thm", s)
        if im is None:
            block_thm["no file"] += 1
            continue
        if not fresh_ok("thm", s):
            block_thm["not fresh-ok"] += 1
            continue
        if not defs_ok(im[1]):
            block_thm["def import not done"] += 1
            continue
        if not siblings_ok(im[0]):
            block_thm["sibling not done"] += 1
            continue
        ready_thms.append(s)

    # SOL layer
    for slug, v in items.items():
        if not slug.startswith("sol:"):
            continue
        s = slug[4:]
        if not isinstance(v, dict) or v.get("status") != "pending":
            continue
        if not done("thm", s):
            block_sol["own thm not done"] += 1
            continue
        if not fresh_ok("sol", s):
            block_sol["not fresh-ok"] += 1
            continue
        im = imports_of("sol", s)
        if im is None:
            block_sol["no file"] += 1
            continue
        if not defs_ok(im[1]):
            block_sol["def import not done"] += 1
            continue
        if not siblings_ok(im[0], need_sol=False):
            block_sol["sibling not done"] += 1
            continue
        ready_sols.append(s)

    union = sorted(set(ready_thms) | set(ready_sols))
    with open("/tmp/drain2_args.txt", "w", encoding="utf-8") as f:
        for s in union:
            f.write(f"--only {s}\n")
    with open("/tmp/ready_thms.txt", "w", encoding="utf-8") as f:
        f.write("\n".join(sorted(ready_thms)) + ("\n" if ready_thms else ""))
    with open("/tmp/ready_sols.txt", "w", encoding="utf-8") as f:
        f.write("\n".join(sorted(ready_sols)) + ("\n" if ready_sols else ""))

    print(f"sol_ready={len(ready_sols)} thm_ready={len(ready_thms)}")
    print(f"union: {len(union)}")
    print("thm blocked by:", dict(block_thm.most_common()))
    print("sol blocked by:", dict(block_sol.most_common()))


if __name__ == "__main__":
    main()
