#!/usr/bin/env python3
"""Switch sols from `Thm_BookProof_HermiteCarleman_mem_cube` to the `_inc` twin.

Why: `Theorems.Thm_BookProof_HermiteCarleman_mem_cube` is Proved on the platform
but its environment fails to materialise server-side (the preamble imports
`Def_ChapterHermiteCarlemanEsa` beside `...Promoted`, which duplicate-declares
`BookProof.HermiteCarleman.rterm`). Every sol importing it fails with an empty
environment (`unknown namespace Finset`). The `_inc` twin restates it in a file
whose preamble imports only the Promoted bundle; it is Proved.

Word-replacement is careful to keep `mem_cube_inc` idempotent and not to touch
`mem_cube_split` / `mem_cube_face` style names.
"""
import re
import sys
from pathlib import Path

WS = Path(__file__).resolve().parent.parent
OLD_IMPORT = "import Theorems.Thm_BookProof_HermiteCarleman_mem_cube\n"
NEW_IMPORT = "import Theorems.Thm_BookProof_HermiteCarleman_mem_cube_inc\n"
NAME = re.compile(r"(?<![\w.])mem_cube(?![\w])")


def main() -> int:
    dry = "--apply" not in sys.argv
    touched = []
    for p in sorted((WS / "Solutions").glob("Sol_*.lean")):
        src = p.read_text()
        if OLD_IMPORT not in src:
            continue
        out = src.replace(OLD_IMPORT, NEW_IMPORT)
        body = out.split(NEW_IMPORT, 1)[1]
        body2 = NAME.sub("mem_cube_inc", body)
        out = out.split(NEW_IMPORT, 1)[0] + NEW_IMPORT + body2
        if out == src:
            continue
        touched.append((p.name, src.count("mem_cube"), NAME.findall(body2).__len__()))
        if not dry:
            p.write_text(out)
    for name, old, new in touched:
        print(f"{name}: mem_cube occurrences {old} -> {new} (inc)")
    print(f"{'would change' if dry else 'changed'} {len(touched)} file(s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
