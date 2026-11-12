#!/usr/bin/env python3
"""Fill `:= by sorry` placeholders in `Definitions/Def_<chap>Promoted.lean`.

WHY: `make_promoted_def.py` copies the WORKSPACE body of a chapter, and the
workspace body stubs a handful of theorem facts with `sorry` (those facts are
problem nodes whose proofs live in Solutions/).  A def bundle may not carry
`sorry` -- upload_pipeline's `stub_sanity` defers it (`def stub contains
`sorry``, rule 3), and the platform rejects it -- so every placeholder has to be
replaced by the real proof before the bundle can be submitted.

The proofs are taken verbatim from the timepiece sources
(`../timepiece331/BookProof/Chapter<X>.lean` and its `Part*.lean` split), which
are sorry-free.  Declarations are matched by Lean name; the whole block
(statement + proof) is replaced, so a statement that the workspace copy had also
stubbed is repaired at the same time.

Usage:
  python3 debug/fill_promoted_proofs.py ChapterCarlemanSimplex ChapterCarlemanTwoStep
"""
import os
import re
import sys

WS = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TP = os.environ.get("TIMEPIECE_SRC", os.path.join(WS, "..", "timepiece331", "BookProof"))

DECL = re.compile(r"(?:@\[[^\]]*\]\s*)?(?:noncomputable\s+)?(?:private\s+)?(?:protected\s+)?"
                  r"(?:theorem|lemma|def|abbrev|structure|class|instance)\s+"
                  r"([A-Za-z_][A-Za-z0-9_.']*)")


def blocks(lines):
    """Split into blocks starting at each top-level declaration (col 0)."""
    starts = [i for i, l in enumerate(lines)
              if l[:1] not in (" ", "\t", "") and DECL.match(l)]
    out = {}
    for i, a in enumerate(starts):
        b = starts[i + 1] if i + 1 < len(starts) else len(lines)
        name = DECL.match(lines[a]).group(1).split(".")[-1]
        text = "\n".join(lines[a:b]).rstrip("\n")
        out.setdefault(name, text)
    return out


def timepiece_proofs(chap):
    base = chap if chap.startswith("Chapter") else "Chapter" + chap
    paths = []
    single = os.path.join(TP, base + ".lean")
    if os.path.exists(single):
        paths.append(single)
    split = os.path.join(TP, base)
    if os.path.isdir(split):
        paths += sorted(os.path.join(split, f) for f in os.listdir(split) if f.endswith(".lean"))
    proofs = {}
    for p in paths:
        proofs.update(blocks(open(p, encoding="utf-8").read().split("\n")))
    return proofs


def fill(chap):
    dst = os.path.join(WS, "Definitions", f"Def_{chap}Promoted.lean")
    lines = open(dst, encoding="utf-8").read().split("\n")
    proofs = timepiece_proofs(chap)
    starts = [i for i, l in enumerate(lines)
              if l[:1] not in (" ", "\t", "") and DECL.match(l)]

    def decl_at(i):
        """Innermost declaration whose block contains line i."""
        cand = [a for a in starts if a <= i]
        return cand[-1] if cand else None

    filled, missing = [], []
    # work from the bottom so earlier replacements keep their line numbers
    sorry_lines = sorted((i for i, l in enumerate(lines) if re.search(r":= by sorry\s*$", l)),
                         reverse=True)
    for i in sorry_lines:
        a = decl_at(i)
        if a is None:
            continue
        b = next((s for s in starts if s > a), len(lines))
        name = DECL.match(lines[a]).group(1).split(".")[-1]
        text = proofs.get(name)
        if not text or "sorry" in text:
            missing.append(name)
            continue
        lines[a:b] = text.split("\n") + [""]
        filled.append(name)
    open(dst, "w", encoding="utf-8").write("\n".join(lines))
    print(f"{chap}: filled {len(filled)} ({', '.join(sorted(filled)) or 'none'})"
          f"; still missing {', '.join(sorted(missing)) or 'none'}")
    return 0 if not missing else 1


if __name__ == "__main__":
    rc = 0
    for c in sys.argv[1:]:
        rc |= fill(c)
    sys.exit(rc)
