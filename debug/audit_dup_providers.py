#!/usr/bin/env python3
"""Audit the published corpus for DUPLICATE PROVIDERS of one fully-qualified name.

WHY
---
`submit-definition` has no retract endpoint (PIPELINE_PLAN §2.13), so a published
definition bundle lives forever.  When such a bundle re-carries a name that
another published artifact already provides -- a chapter bundle, a leaf-gap
carrier (§2.59), or a *theorem node's* statement -- the harm is not that the name
disappears but that the two providers can never be imported into one file: Lean
answers `already been declared`.  That is exactly what the six `*Promoted`
bundles of Session 30 had to be checked for, one at a time, by hand.

This tool answers the same question for the WHOLE published set in one pass:

  providers = the 667 bundles in state/published_bundles/   (published text,
              refreshed by debug/cache_published_bundles.py)
            + every problem statement in pipeline/wave_upload.json (`thms`)

and then reports

  1. every fq name with >= 2 bundle providers            (bundle x bundle)
  2. every fq name with >= 1 bundle AND >= 1 theorem    (bundle x theorem)
  3. for each such name, every local file that imports BOTH provider modules
     -- the only class that actually breaks (imports are per-module, so a
     redundant bundle nobody imports with its twin is inert, PIPELINE_PLAN
     Session 30)

Each duplicated bundle is also tagged with what makes it dangerous or not:
`fanin` (files importing it), `carries_theorems` (its text declares
theorem/lemma, i.e. it is a leaf-gap/inline-theorem carrier rather than a plain
definition bundle) and `kind` (promoted/leaf-gap/plain, by name).

READ-ONLY.  Writes nothing but its report.

USAGE
    python3 debug/audit_dup_providers.py                 # summary to stdout
    python3 debug/audit_dup_providers.py --tsv state/scratch/dup_providers.tsv
    python3 debug/audit_dup_providers.py --bundle ChapterLeafGaps   # one bundle
"""
import argparse
import glob
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
PUB = os.path.join(WS, "state", "published_bundles")
WAVE = os.path.join(WS, "pipeline", "wave_upload.json")
LEDGER = os.path.join(WS, "state", "pipeline.json")

DECL = re.compile(
    r"^(?:@\[[^\]]*\]\s*)*(?:noncomputable\s+|protected\s+|private\s+|nonrec\s+|"
    r"scoped\s+|local\s+)*"
    r"(def|abbrev|theorem|lemma|structure|class|inductive|opaque|instance)\s+"
    r"([^\s:({⟨\[]+)")
ATTR_DECL = re.compile(
    r"^@\[[^\]]*\]\s*(?:noncomputable\s+)?"
    r"(def|abbrev|theorem|lemma|structure|class|inductive|opaque|instance)\s+"
    r"([^\s:({⟨\[]+)")
PROOFY = {"theorem", "lemma"}


def block_delta(line):
    """Net block-comment nesting introduced by a line (`/-` vs `-/`)."""
    d, i = 0, 0
    while True:
        a = line.find("/-", i)
        b = line.find("-/", i)
        if a == -1 and b == -1:
            return d
        if a != -1 and (b == -1 or a < b):
            d += 1
            i = a + 2
        else:
            d -= 1
            i = b + 2


def decls_of(path):
    """[(fq_name, kind)] declared by a Lean file, namespace-aware.

    `section` is tracked so a bare `end` pops the section, not the namespace;
    block comments are skipped because prose docstrings start with col-0 words
    that the decl regex would otherwise read as declarations.
    """
    out, stack, in_block = [], [], 0
    pending_attr = None
    with open(path, encoding="utf-8", errors="ignore") as fh:
        for line in fh:
            bd = block_delta(line)
            if in_block > 0:
                in_block += bd
                continue
            if bd > 0:
                in_block = bd
                continue
            if line.startswith("namespace "):
                parts = line.split()
                if len(parts) >= 2:
                    stack.append(("ns", parts[1]))
                continue
            if line.startswith("end"):
                parts = line.split()
                if len(parts) >= 2 and "." in parts[1]:
                    target = parts[1]
                    while stack:
                        kind, name = stack[-1]
                        if kind == "sec":
                            stack.pop()
                            continue
                        got = ".".join(n for k, n in stack if k == "ns")
                        if got == target or name == target.split(".")[-1]:
                            break
                        stack.pop()
                    if stack:
                        stack.pop()
                elif stack:
                    stack.pop()
                continue
            tok = line.split()
            if tok and (tok[0] == "section" or
                        (tok[0] == "noncomputable" and len(tok) > 1 and tok[1] == "section")):
                stack.append(("sec", line.split("section", 1)[1].strip()))
                continue
            if line.startswith("@["):
                pending_attr = line
                m = ATTR_DECL.match(line)
            else:
                m = DECL.match(line)
                pending_attr = None if m else pending_attr
            if not m:
                continue
            kind, name = m.group(1), m.group(2)
            if kind == "instance" and name.startswith(":"):
                continue          # anonymous instance: no usable name
            ns = ".".join(n for k, n in stack if k == "ns")
            fq = name if (not ns or name.startswith(ns + ".")) else ns + "." + name
            out.append((fq, kind))
    return out


def published_bundles():
    """bundle name -> (decl list, path)."""
    out = {}
    for f in sorted(glob.glob(os.path.join(PUB, "Def_*.lean"))):
        bundle = os.path.basename(f)[len("Def_"):-len(".lean")]
        out[bundle] = (decls_of(f), f)
    return out


def theorem_names():
    """slug -> (fq name, ledger status) from the wave catalogue."""
    wave = json.load(open(WAVE, encoding="utf-8"))
    led = json.load(open(LEDGER, encoding="utf-8")).get("items", {})
    out = {}
    for slug, rec in wave.get("thms", {}).items():
        name = rec.get("name") or ""
        if not name:
            continue
        st = (led.get(f"thm:{slug}") or {}).get("status")
        out[slug] = (name, st)
    return out


def importers():
    """module -> set of local files importing it (Definitions/Theorems/Solutions)."""
    idx = {}
    files = []
    for d in ("Definitions", "Theorems", "Solutions"):
        files += glob.glob(os.path.join(WS, d, "*.lean"))
    for f in files:
        try:
            txt = open(f, encoding="utf-8", errors="ignore").read()
        except OSError:
            continue
        for mod in re.findall(r"^import\s+(\S+)", txt, re.M):
            idx.setdefault(mod, set()).add(f)
    return idx


def kind_of(bundle, carries_theorems):
    if bundle.endswith("Promoted"):
        return "promoted"
    if bundle.endswith("LeafGaps") or "LeafGap" in bundle:
        return "leaf-gap"
    if carries_theorems:
        return "carrier"          # a chapter bundle that also carries proofs
    return "plain"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--tsv", help="write the full duplicate list here")
    ap.add_argument("--bundle", help="restrict the report to one bundle")
    ap.add_argument("--max-show", type=int, default=25)
    args = ap.parse_args()

    bundles = published_bundles()
    thms = theorem_names()

    # fq name -> providers
    by_bundle = {}
    proofy = {}
    for bundle, (decls, path) in bundles.items():
        proofy[bundle] = any(k in PROOFY for _fq, k in decls)
        for fq, _kind in decls:
            by_bundle.setdefault(fq, set()).add(bundle)
    by_thm = {}
    for slug, (name, _st) in thms.items():
        by_thm.setdefault(name, set()).add(slug)

    dup_bb = {fq: bs for fq, bs in by_bundle.items() if len(bs) > 1}
    dup_bt = {fq: bs for fq, bs in by_bundle.items() if fq in by_thm}

    imp = importers()

    def module(bundle):
        return f"Definitions.Def_{bundle}"

    def thm_module(slug_name):
        return "Thm_" + re.sub(r"[^A-Za-z0-9_]", "_", slug_name)

    rows = []
    for fq in sorted(set(dup_bb) | set(dup_bt)):
        bs = sorted(by_bundle[fq])
        ss = sorted(by_thm.get(fq, ()))
        if args.bundle and args.bundle not in bs:
            continue
        # consumers that import two providers of this name at once
        conflicts = []
        mods = [module(b) for b in bs]
        for s in ss:
            mods.append("Theorems." + thm_module(fq))
        for i in range(len(mods)):
            for j in range(i + 1, len(mods)):
                both = imp.get(mods[i], set()) & imp.get(mods[j], set())
                for f in sorted(both):
                    conflicts.append((os.path.relpath(f, WS), mods[i], mods[j]))
        rows.append(dict(
            name=fq, bundles=bs, theorems=ss, conflicts=conflicts,
            carries="/".join(b for b in bs if proofy[b])))

    print(f"published bundles           : {len(bundles)}")
    print(f"problem statements          : {len(thms)}")
    print(f"fq names declared by >=2 bundles : {len(dup_bb)}")
    print(f"fq names declared by bundle+thm  : {len(dup_bt)}")
    print(f"names with an import conflict    : "
          f"{sum(1 for r in rows if r['conflicts'])}")

    # aggregate per bundle: how many of its names are duplicated, and fan-in
    per = {}
    for r in rows:
        if len(r["bundles"]) > 1:
            for b in r["bundles"]:
                per.setdefault(b, {})["bb"] = per.get(b, {}).get("bb", 0) + 1
        if r["theorems"]:
            for b in r["bundles"]:
                per.setdefault(b, {})["bt"] = per.get(b, {}).get("bt", 0) + 1
        if r["conflicts"]:
            for b in r["bundles"]:
                per.setdefault(b, {})["cf"] = per.get(b, {}).get("cf", 0) + 1
    print("\n-- bundles with duplicated providers --")
    print(f"{'bundle':52s} {'kind':9s} {'bb':>4s} {'bt':>5s} {'conf':>4s} "
          f"{'fanin':>5s} {'#decls':>6s}")
    for b in sorted(per, key=lambda x: (-per[x].get("cf", 0),
                                        -per[x].get("bt", 0),
                                        -(len(imp.get(module(x), ()))))):
        p = per[b]
        n = len(bundles[b][0])
        print(f"{b:52s} {kind_of(b, proofy[b]):9s} {p.get('bb', 0):4d} "
              f"{p.get('bt', 0):5d} {p.get('cf', 0):4d} "
              f"{len(imp.get(module(b), ())):5d} {n:6d}")

    if rows:
        print("\n-- sample duplicate names --")
        for r in rows[:args.max_show]:
            tag = "CONFLICT " if r["conflicts"] else ""
            print(f"  {tag}{r['name']}")
            print(f"      bundles: {', '.join(r['bundles'])}")
            if r["theorems"]:
                print(f"      theorem: {', '.join(r['theorems'][:3])}")
            for f, a, c in r["conflicts"][:5]:
                print(f"      clash in {f}: imports {a} + {c}")

    if args.tsv:
        os.makedirs(os.path.dirname(args.tsv), exist_ok=True)
        with open(args.tsv, "w", encoding="utf-8") as fh:
            fh.write("name\tbundles\ttheorems\tconflict_files\tproof_carrying\n")
            for r in rows:
                fh.write("\t".join([
                    r["name"], ",".join(r["bundles"]), ",".join(r["theorems"]),
                    ",".join(f for f, _a, _c in r["conflicts"]),
                    r["carries"]]) + "\n")
        print(f"\nwrote {args.tsv} ({len(rows)} row(s))")
    return 0


if __name__ == "__main__":
    sys.exit(main())
