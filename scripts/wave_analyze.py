#!/usr/bin/env python3
"""Analyze wave modules: join Stage-1 graph rows with Stage-2 sketch decl facts.

For each participating module print the declarations with kind, privacy,
instance flag, proof length (declEnd.line - valStart.line), and in-file
typeDeps.  Graph rows are joined to decl facts by containment: a row belongs
to the decl fact whose [declStart.line, declEnd.line] contains row.startLine
(Stage 2 spans `omit … in` / `include … in` wrappers; Stage 1 starts at the
declaration itself).
"""
import json
import sys

GRAPH = "/home/leo/Projects/timepiece/decl_graph.jsonl"
SKETCH_DIR = "/home/leo/prove2me_workspace/state/sketch"

WAVE = [
    "ChapterMassGap", "ChapterBRSTNilpotent", "ChapterGhostField",
    "ChapterNavierStokes", "ChapterYangMillsFieldStrength",
    "ChapterSirkFinitePrecision", "ChapterGaugeFixing",
]


def main():
    mods = sys.argv[1:] or WAVE
    rows_by_mod = {}
    with open(GRAPH) as f:
        for line in f:
            r = json.loads(line)
            rows_by_mod.setdefault(r["module"], []).append(r)
    for mod in mods:
        fullmod = f"BookProof.{mod}"
        decls = []
        try:
            with open(f"{SKETCH_DIR}/sketch_{mod}.jsonl") as f:
                for line in f:
                    r = json.loads(line)
                    if r["kind"] == "decl":
                        decls.append(r)
        except FileNotFoundError:
            print(f"!! no sketch for {mod}")
            continue
        grows = [g for g in rows_by_mod.get(fullmod, []) if g["startLine"] > 0]
        print(f"\n{'='*70}\nMODULE {fullmod}: {len(decls)} decl facts, "
              f"{len(grows)} graph rows with spans\n{'='*70}")
        # assign each graph row to the decl fact containing its startLine
        for d in sorted(decls, key=lambda x: x["declStart"]["line"]):
            dl = d["declStart"]["line"]
            de = d["declEnd"]["line"]
            vs = d["valStart"]
            rows = [g for g in grows if dl <= g["startLine"] <= de]
            # the real declaration row: skip compiler companions whose spans
            # sit inside a structure (field accessors share the structure span)
            main = [g for g in rows if not any("." in g["userName"].split(fullmod)[-1].lstrip(".") for g in rows)] if False else rows
            for g in rows:
                if not g["isInstance"] and (g["kind"] in ("theorem", "def") or g["isPrivate"]):
                    short = g["userName"].split(".")[-1]
                    if short != d["nameText"] and not g["isPrivate"]:
                        # private or structure-generated; print anyway with mark
                        mark = "  [comp/struct-generated?]"
                    else:
                        mark = ""
                    plen = (de - vs["line"]) if vs else 0
                    print(f"  {g['kind']:9s} priv={int(g['isPrivate'])} "
                          f"inst={int(g['isInstance'])} declL{dl}-{de} "
                          f"prooflen~{plen} {g['userName']}{mark}")
            if not rows:
                # a decl fact with no graph row: macro-made lemma or notation
                plen = (de - vs["line"]) if vs else 0
                print(f"  (no graph row) declL{dl}-{de} prooflen~{plen} {d['nameText']} "
                      f"valKind={d['valKind']}")


if __name__ == "__main__":
    main()
