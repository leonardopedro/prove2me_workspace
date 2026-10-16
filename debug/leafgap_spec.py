#!/usr/bin/env python3
"""Compute the leaf-gap spec: identifiers referenced by red sols that no published
mirror bundle provides, grouped per source chapter (flat file preferred)."""
import re, os, glob, collections, sys
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from build_leafgap_bundle import full_names, DECL

mir_full, mir_bare = set(), set()
STAGED = ("Def_ChapterLeafGaps.lean", "Def_ChapterNsKoopman.lean",
          "Def_ChapterNsNonlinearFarisLavine.lean")   # our own staged bundles
for f in glob.glob("/tmp/published_mirror/Definitions/*.lean"):
    if any(f.endswith(s) for s in STAGED):
        continue
    for full in full_names(f):
        mir_full.add(full); mir_bare.add(full.split(".")[-1])

src = collections.defaultdict(set)
for f in glob.glob("../timepiece331/BookProof/**/*.lean", recursive=True):
    try:
        for full in full_names(f):
            src[full.split(".")[-1]].add((full, f))
    except Exception:
        pass

reds = [l.strip() for l in open("/tmp/red_sol.txt") if l.strip()]
missing = collections.defaultdict(set)
for slug in reds:
    p = f"Solutions/Sol_{slug}.lean"
    try:
        txt = open(p, encoding="utf-8").read()
    except OSError:
        continue
    idents = set(re.findall(r"[A-Za-z_][A-Za-z_0-9ₙ]*", txt))
    for ident in idents:
        # NB: no bare-name shortcut here — another chapter declaring the same
        # bare name does not make it reachable (namespace-qualified check only).
        if len(ident) < 4:
            continue
        cands = src.get(ident)
        if not cands:
            continue
        if any(full in mir_full for full, _ in cands):
            continue
        if re.search(r"(?:def|theorem|lemma|structure|abbrev|instance)\s+[A-Za-z_.ₙ]*\b" + re.escape(ident) + r"\b", txt):
            continue
        for full, f in cands:
            missing[f].add(ident)

bybase = collections.defaultdict(dict)
for f, names in missing.items():
    parts = f.replace("../timepiece331/", "").split("/")
    chap = parts[-1].replace(".lean", "") if len(parts) == 2 else parts[1]
    bybase[chap][parts[-1]] = (f, names)

spec = []
for chap, files in sorted(bybase.items()):
    flat = [k for k in files if k == chap + ".lean"]
    chosen = flat if flat else sorted(files)
    merged = set()
    for k in chosen:
        merged |= files[k][1]
    if merged:
        spec.append(f"{files[chosen[0]][0].replace('../timepiece331/', '')}:{','.join(sorted(merged))}")
open("/tmp/leafgap_spec.txt", "w").write("\n".join(spec) + "\n")
print(f"{len(spec)} chapters in spec, {sum(len(l.split(':')[1].split(',')) for l in spec)} names")
for l in spec:
    print(" ", l.split(":")[0], len(l.split(":")[1].split(",")))
