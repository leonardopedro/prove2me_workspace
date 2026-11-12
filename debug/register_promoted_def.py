#!/usr/bin/env python3
"""Add a `Definitions/Def_ChapterXPromoted.lean` bundle to the publish wave.

The def chunk only submits a bundle listed in `pipeline/wave_upload.json["defs"]`
(`do_wave_def`), so a §2.13 Promoted bundle is invisible to the pipeline until it
is registered here.  Entries copy the parent chapter's `source`/`tags` and take
the REAL namespace from the generated file -- not from the wave's own `namespace`
field, which is exactly what was wrong for the five skeleton chapters
(`BookProof.ChapterX`, so the generated bundle declared a namespace nothing
opens; that is the defect §Session 40 repairs).

Usage:
  python3 debug/register_promoted_def.py ChapterCarlemanTwoStep \\
      --title "Two-step Carleman criterion: definitions" --nl-file state/nl_x.txt
"""
import argparse
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
WAVE = os.path.join(WS, "pipeline", "wave_upload.json")


def namespace_of(path):
    for line in open(path, encoding="utf-8"):
        m = re.match(r"namespace\s+(\S+)", line.strip())
        if m:
            return m.group(1)
    raise SystemExit(f"{path}: no namespace")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("chapter", nargs="+")
    ap.add_argument("--title", required=True)
    ap.add_argument("--nl-file", required=True)
    a = ap.parse_args()
    nl = open(a.nl_file, encoding="utf-8").read().strip()

    wave = json.load(open(WAVE))
    defs = wave["defs"]
    added = []
    for chap in a.chapter:
        key = f"{chap}Promoted"
        path = os.path.join(WS, "Definitions", f"Def_{key}.lean")
        if not os.path.exists(path):
            sys.exit(f"missing bundle {os.path.relpath(path, WS)} -- run make_promoted_def.py first")
        parent = defs.get(chap, {})
        defs[key] = {
            "definition_name": key,
            "file": f"Definitions/Def_{key}.lean",
            "namespace": namespace_of(path),
            "nl": nl,
            "source": parent.get("source", ""),
            "tags": parent.get("tags", ["timepiece", "formalization", "definitions"]),
            "title": a.title if len(a.chapter) == 1 else f"{a.title} ({chap})",
        }
        added.append(key)
    json.dump(wave, open(WAVE, "w"), indent=1, ensure_ascii=False)
    print(f"registered {', '.join(added)} ({len(defs)} bundles in the wave)")


if __name__ == "__main__":
    main()
