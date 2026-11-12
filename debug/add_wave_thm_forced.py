#!/usr/bin/env python3
"""Append explicitly named theorem stubs to the wave spec, bypassing the
"embedded duplicate" filter of `debug/extend_wave_stubs.py`.

Why the bypass is needed: that filter reads the WORKSPACE `Def_Chapter*` bundles,
but the platform holds the PUBLISHED revision, and the two drift (PIPELINE_PLAN
§8.2).  `Def_ChapterCarlemanTwoStep` here declares `mem_faceK` / `mem_innK` /
`sum_shiftK` as local theorems, while the published bundle does not, so
`find_existing` sees no node, the server-side name is free, and the statement
can still be published as its own node — which is what the sol items queued for
them need.  The filter skips them; this tool is the named override.

Metadata is built exactly as `extend_wave_stubs.py` builds it (docstring slice
out of the source chapter, line anchor, chapter tags).  Append-only: existing
entries are never rewritten.

Usage:
  python3 debug/add_wave_thm_forced.py [--dry-run] slug [slug ...]
"""
import json
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = os.path.dirname(HERE)
sys.path.insert(0, HERE)

from extend_wave_stubs import (CANON, REPO, SPEC, clamp_title, chapter_tags,
                               prose, source_docstring)

sys.path.insert(0, os.path.join(WS, "pipeline"))
from upload_pipeline import published_defs  # noqa: E402


def main(argv):
    dry = "--dry-run" in argv
    slugs = [a for a in argv if not a.startswith("--")]
    if not slugs:
        print(__doc__)
        return 2
    spec = json.load(open(SPEC, encoding="utf-8"))
    pub = published_defs()
    added = []
    for slug in slugs:
        if slug in spec["thms"]:
            # A node can be in `thms` yet absent from ORDER: the drain walks
            # `sol_order`, so an unlisted slug is never visited.
            if slug in spec["sol_order"]:
                print(f"{slug}: already in the wave spec, skipped")
            else:
                spec["sol_order"].append(slug)
                print(f"{slug}: already a thm entry, appended to sol_order")
                added.append((slug, spec["thms"][slug]))
            continue
        path = os.path.join(WS, "Theorems", f"Thm_{slug}.lean")
        if not os.path.exists(path):
            print(f"{slug}: MISSING {path}")
            continue
        txt = open(path, encoding="utf-8", errors="replace").read()
        decl = [l for l in txt.splitlines() if l.startswith("theorem ")]
        name = decl[0].split()[1] if decl else slug
        leaf = "Chapter" + slug.split("_")[1]
        stem = leaf[len("Chapter"):]
        if leaf not in pub:
            print(f"{slug}: chapter bundle {leaf} is not published, skipped")
            continue
        short = name.split(".")[-1]
        doc, l0, l1 = source_docstring(stem, short)
        paras = prose(doc)
        if paras:
            title, body = paras[0], "\n\n".join(paras)
        else:
            title = (f"The Lean 4 theorem `{short}` in the `{leaf}` chapter of "
                     f"the timepiece formalization")
            body = title + "."
        anchor = f"#L{l0}-L{l1}" if l0 and l1 else ""
        nl = (f"{body}\n\n\n\n**Formalization Note.** Lean 4 identifier: `{name}` "
              f"(module `BookProof.{stem}`), line-linked source: "
              f"`{leaf}.lean` lines {l0}–{l1}." if l0 and l1 else body)
        if len(nl) > 4000:
            nl = nl[:4000].rstrip() + "\n\n..."
        added.append((slug, {
            "name": name,
            "chapter": leaf,
            "file": f"{CANON}/Theorems/Thm_{slug}.lean",
            "title": clamp_title(title),
            "nl": nl,
            "source": f"{REPO}/BookProof/{leaf}.lean{anchor}",
            "tags": chapter_tags(spec, leaf),
        }))
    if not added:
        print("nothing to add")
        return 0
    print(f"adding {len(added)} thm entr{'y' if len(added) == 1 else 'ies'} "
          f"+ {len(added)} sol_order slugs")
    for s, m in added:
        print(f"  {s}\n      name : {m['name']}\n      title: {m['title'][:110]}")
    if dry:
        print("[dry run] spec not written")
        return 0
    for s, m in added:
        if s in spec["thms"] and s in spec["sol_order"]:
            continue
        spec["thms"][s] = m
        if s not in spec["sol_order"]:
            spec["sol_order"].append(s)
    with open(SPEC, "w", encoding="utf-8") as f:
        json.dump(spec, f, indent=1)
    print(f"wrote {SPEC}: {len(spec['defs'])} defs, {len(spec['thms'])} thms, "
          f"{len(spec['sol_order'])} sol_order")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
