#!/usr/bin/env python3
"""Classify the root-FAIL def bundles from a def-gate report.

`state/def_gate.json` / the `--report` TSV mark a bundle FAIL only when none of
its dependencies failed first, so these 43 are the *sources* of the whole
`BLOCKED by` cascade (384 bundles).  Each FAIL line names one missing identifier;
the question this answers is which repair class it belongs to:

  thm-stub   a `Theorems/Thm_BookProof_<Chapter>_<decl>.lean` stub exists locally
             -> the bundle references a THEOREM of another chapter.  A def bundle
             may import a Thm stub (the pipeline already depends on that), so the
             repair is one `import` line.
  def-bundle the identifier is a `def` in another `Definitions/Def_*.lean`
             -> the `import Definitions.Def_X` line is missing or mistyped.
  source-only the identifier exists in ../timepiece331 but no stub was emitted
             -> generator gap, not an import fix.
  absent     nowhere at all -> the identifier is genuinely unknown (a real
             defect in the bundle's own text).

Usage:
  python3 debug/classify_rootfail_defs.py [report.tsv]
"""
import os
import re
import subprocess
import sys
import collections

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TP = os.path.join(os.path.dirname(WS), "timepiece331")

RE_FAIL = re.compile(r"^FAIL Definitions/Def_(\S+?)\.lean:(\d+):\d+: error"
                     r"(?:\(lean\.unknownIdentifier\))?: (.*)$")
RE_IDENT = re.compile(r"Unknown identifier [`']([^`']+)")
RE_NS = re.compile(r"unknown namespace [`']([^`']+)")
RE_TOKEN = re.compile(r"unexpected token|unexpected identifier")


def index_decls(root, exts=(".lean",)):
    """{decl name -> [files]} over `def|lemma|theorem|abbrev|structure` lines."""
    out = collections.defaultdict(list)
    pat = re.compile(r"(?:^|\n)\s*(?:@\[.*?\]\s*)?"
                     r"(?:protected\s+|private\s+|noncomputable\s+)*"
                     r"(?:def|abbrev|lemma|theorem|structure|class)\s+([A-Za-z_][\w'!.]*)")
    for dirpath, _dirs, files in os.walk(root):
        for fn in files:
            if not fn.endswith(exts):
                continue
            p = os.path.join(dirpath, fn)
            try:
                txt = open(p, encoding="utf-8").read()
            except OSError:
                continue
            for m in pat.finditer(txt):
                out[m.group(1)].append(p)
    return out


def main():
    report = sys.argv[1] if len(sys.argv) > 1 else "/tmp/def_gate_20261012.tsv"
    rows = []
    for line in open(report, encoding="utf-8"):
        m = RE_FAIL.match(line.rstrip("\n"))
        if m:
            rows.append((m.group(1), int(m.group(2)), m.group(3)))
    print(f"root FAIL bundles: {len(rows)}")

    thm_stub = {}
    for fn in os.listdir(os.path.join(WS, "Theorems")):
        if not fn.startswith("Thm_BookProof_") or not fn.endswith(".lean"):
            continue
        slug = fn[len("Thm_"):-len(".lean")]
        # Thm_BookProof_<Chapter>_<decl...> -> (Chapter, decl)
        rest = slug[len("BookProof_"):]
        ch, _, decl = rest.partition("_")
        thm_stub.setdefault(decl, []).append((ch, slug))

    def_bundles = collections.defaultdict(list)
    pat = re.compile(r"(?:^|\n)\s*(?:noncomputable\s+)*"
                     r"(?:def|abbrev|structure|class)\s+([A-Za-z_][\w'!.]*)")
    for fn in os.listdir(os.path.join(WS, "Definitions")):
        if not (fn.startswith("Def_") and fn.endswith(".lean")):
            continue
        try:
            txt = open(os.path.join(WS, "Definitions", fn), encoding="utf-8").read()
        except OSError:
            continue
        for m in pat.finditer(txt):
            def_bundles[m.group(1)].append(fn[len("Def_"):-len(".lean")])

    src = {}
    if os.path.isdir(TP):
        src = index_decls(os.path.join(TP, "BookProof"))

    census = collections.Counter()
    out = []
    for chap, line, msg in rows:
        mi = RE_IDENT.search(msg)
        mns = RE_NS.search(msg)
        if mi or mns:
            ident = (mi or mns).group(1)
            base = ident.split(".")[-1]
            if base in thm_stub:
                cls = "thm-stub"
                note = ",".join(c for c, _ in thm_stub[base][:3])
            elif base in def_bundles:
                cls = "def-bundle"
                note = ",".join(def_bundles[base][:3])
            elif base in src:
                cls = "source-only"
                note = os.path.relpath(src[base][0], TP)
            else:
                cls = "absent"
                note = ""
            census[cls] += 1
            out.append((chap, line, cls, ident, note))
        elif RE_TOKEN.search(msg):
            census["syntax"] += 1
            out.append((chap, line, "syntax", "", msg[:60]))
        else:
            census["other"] += 1
            out.append((chap, line, "other", "", msg[:60]))

    with open("/tmp/rootfail_classified.tsv", "w", encoding="utf-8") as fh:
        for chap, line, cls, ident, note in out:
            fh.write(f"{chap}\t{line}\t{cls}\t{ident}\t{note}\n")

    w = max(len(o[0]) for o in out)
    for chap, line, cls, ident, note in out:
        print(f"{chap:<{w}}  {cls:<12} L{line:<5} {ident[:44]:<44} {note[:40]}")
    print("\ncensus:", dict(census.most_common()))
    print("written to /tmp/rootfail_classified.tsv")
    return 0


if __name__ == "__main__":
    sys.exit(main())
