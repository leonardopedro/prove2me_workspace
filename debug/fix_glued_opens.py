#!/usr/bin/env python3
"""Delete the glued `open X.X...X` lines a previous repair wave introduced.

PIPELINE_PLAN §2.29-3 added `open <ns>` lines to sols whose provider name was
unresolved; a string-concat bug in that pass emitted the namespace repeated
with `.BookProof.` glued between copies (`open BookProof.ChapterA3.
BookProof.ChapterA3`).  Lean rejects those with `unknown namespace`, so the
whole file fails regardless of its proof.

Safety: a malformed line is deleted only when the file already opens its base
namespace (`open BookProof.ChapterA3`) on another line -- so deleting cannot
remove the only provider open.  Files where that does not hold are reported
and left untouched.
"""
import os
import re
import shutil
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
GLUED = re.compile(r"^open\s+(\S*\.BookProof\.\S*)\s*$")


def parts_of(ns):
    """Split a glued `A.BookProof.B.BookProof.C` into [A, B, C], restoring the
    `BookProof.` prefix the gluing consumed from the later copies."""
    bits = ns.split(".BookProof.")
    out = [bits[0]] + ["BookProof." + b for b in bits[1:]]
    return [b for b in out if b]


def base_of(ns):
    return parts_of(ns)[0]


def main():
    apply = "--apply" in sys.argv
    fixed, skipped = [], []
    for fn in sorted(os.listdir(f"{WS}/Solutions")):
        if not (fn.startswith("Sol_") and fn.endswith(".lean")):
            continue
        path = f"{WS}/Solutions/{fn}"
        lines = open(path, encoding="utf-8").read().splitlines(keepends=True)
        bad = []
        for i, l in enumerate(lines):
            m = GLUED.match(l.strip())
            if m and ".BookProof." in m.group(1):
                bad.append((i, base_of(m.group(1))))
        if not bad:
            continue
        opens = [l.strip() for l in lines if l.strip().startswith("open ")]
        kill = {}
        for i, base in bad:
            cur = lines[i].strip()
            parts = parts_of(GLUED.match(cur).group(1))
            others = [o for o in opens if o != cur]
            need = [p for p in parts
                    if not any(re.search(rf"(?:^open | ){re.escape(p)}(?: |$)", o)
                               for o in others)]
            if not need:
                kill[i] = []            # every part already opened elsewhere
            else:
                kill[i] = need          # keep only the parts not yet opened
            splice = need
        if kill and apply:
            bak = path + ".bak_fix24"
            if not os.path.exists(bak):
                shutil.copy2(path, bak)
            out = []
            for i, l in enumerate(lines):
                if i not in kill:
                    out.append(l)
                elif kill[i]:
                    out.extend(f"open {p}\n" for p in kill[i])
                # i in kill with [] -> delete the line entirely
            open(path, "w", encoding="utf-8").write("".join(out))
        if kill:
            fixed.append((fn, len(kill)))
    print(f"files with glued opens fixed: {len(fixed)} "
          f"({sum(k for _, k in fixed)} lines)" if apply else
          f"files with glued opens: {len(fixed)} ({sum(k for _, k in fixed)} lines)")
    for fn, k in fixed[:10]:
        print("  ", fn, k)
    if skipped:
        print("skipped (base open not otherwise present):")
        for fn, l in skipped:
            print("  ", fn, l)
    return 0


if __name__ == "__main__":
    sys.exit(main())
