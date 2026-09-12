#!/usr/bin/env python3
"""Additive wave extender: append a def bundle to pipeline/wave_upload.json.

Same spirit as debug/extend_wave.py (waves 1/2/3): build the metadata from the
bundle's own module docstring and its source chapter, and never clobber an
existing entry.  Used when a def bundle is missing from the wave but blocks a
dependent publication (see debug/def_closure.py).

Usage: python3 debug/add_wave_def.py ChapterQgHermiteFriedrichs [tag ...]
       python3 debug/add_wave_def.py --reset ChapterQgHermiteFriedrichs [tag ...]

The title comes from the docstring's markdown heading (a prose sentence makes a
poor 200-char `definition_title`); --reset rewrites an existing entry's metadata
and is the only way an existing entry is ever touched.
"""
import json
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(WS, "pipeline"))
import upload_pipeline as up  # noqa: E402

REPO = "https://github.com/leonardopedro/timepiece/blob/61595bc"
SPEC = os.path.join(WS, "pipeline", "wave_upload.json")
DEFAULT_TAGS = ["timepiece", "faris-lavine", "spectral-theory"]


def main():
    argv = sys.argv[1:]
    reset = "--reset" in argv
    argv = [a for a in argv if a != "--reset"]
    if not argv:
        print(__doc__)
        return 2
    chapter = argv[0]
    extra_tags = argv[1:]

    spec = json.load(open(SPEC, encoding="utf-8"))
    if chapter in spec["defs"] and not reset:
        print(f"{chapter}: already in the wave spec (deps-first position "
              f"{up.WAVE_DEF_ORDER.index(chapter) + 1}/{len(up.WAVE_DEF_ORDER)}); "
              "pass --reset to rewrite its metadata")
        return 0

    path = os.path.join(WS, "Definitions", f"Def_{chapter}.lean")
    if not os.path.exists(path):
        print(f"{chapter}: MISSING local bundle at {path}")
        return 1

    txt = open(path, encoding="utf-8").read()
    leaf = chapter[len("Chapter"):]
    ns_m = re.search(r"(?m)^namespace\s+(\S+)", txt)
    doc_m = re.search(r"/-!(.*?)-/", txt, re.S)
    blocks = [re.sub(r"\s+", " ", b).strip() for b in (doc_m.group(1) if doc_m else "").split("\n\n")]
    # The docstring opens with a markdown heading (`# ...`, possibly over two
    # paragraphs); that heading is the title, the prose below it is the NL.
    heading = [b for b in blocks if b.startswith("#")]
    paras = [b for b in blocks if b and not b.startswith("#")]
    title = " ".join(h.lstrip("# ").strip() for h in heading).strip()
    if not title:
        title = paras[0] if paras else f"Formal definitions for {chapter}"
        paras = paras[1:]
    lead = (f"Formal definitions for the timepiece Lean 4 formalization (module "
            f"`BookProof.{leaf}`, source chapter `BookProof/Chapter{leaf}.lean`): {title}")
    nl = lead + ("\n\n" + "\n\n".join(paras) if paras else "")
    if len(nl) > 4000:
        nl = nl[:4000].rstrip() + "\n\n..."

    spec["defs"][chapter] = {
        "definition_name": chapter,
        "namespace": ns_m.group(1) if ns_m else f"BookProof.{leaf}",
        "file": f"/home/leo/prove2me_workspace/Definitions/Def_{chapter}.lean",
        "title": title[:200],
        "nl": nl,
        "source": f"{REPO}/BookProof/Chapter{leaf}.lean",
        "tags": ["timepiece"] + (extra_tags or DEFAULT_TAGS) if "timepiece" not in (extra_tags or []) else extra_tags,
    }
    with open(SPEC, "w", encoding="utf-8") as f:
        json.dump(spec, f, indent=1)
    print(f"{chapter}: added to the wave spec "
          f"({len(spec['defs'])} defs, {len(spec['thms'])} thms)")
    print(f"  namespace: {spec['defs'][chapter]['namespace']}")
    print(f"  title    : {spec['defs'][chapter]['title']}")
    print(f"  tags     : {spec['defs'][chapter]['tags']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
