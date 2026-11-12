#!/usr/bin/env python3
"""Drop every `theorem`/`lemma` block from a Promoted def bundle.

WHY: `make_promoted_def.py`'s block splitter takes the first non-indented line of
a doc-comment block as the declaration head, and the module docstrings here carry
unindented prose ("`BookProof.…` proves …"), so a theorem that follows such a
docstring is never recognised as a theorem and survives the defs-only strip with
its full proof -- a proof whose body then cites node lemmas the bundle does not
carry (`Unknown identifier sum_simplex_split`, `sBd_mass_le`, …).  A bundle
submitted as a definition must also not re-declare a problem node (the platform
publishes the node as a declaration of the same name), so the strict answer is:
keep definitions only.

This tool is comment-aware (nested `/- -/`, `--` lines), which is exactly what
the splitter is not, and removes each theorem/lemma block together with the doc
comment and any `set_option … in` prefix attached to it.

Usage:
  python3 debug/strip_promoted_theorems.py ChapterHermiteCarlemanEsa ChapterCarlemanTwoStep …
"""
import re
import sys

WS = __file__.rsplit("/debug/", 1)[0]
TOP = re.compile(r"^(?:@\[|noncomputable\b|private\b|protected\b|namespace\b|end\b|open\b|"
                 r"variable\b|section\b|universe\b|attribute\b|set_option\b|scoped\b|"
                 r"local\b|def\b|abbrev\b|structure\b|class\b|instance\b|theorem\b|lemma\b|"
                 r"example\b|/--|/-!|--)")


def pop_comment(out):
    """Remove a block comment that ends on the last emitted line."""
    if not out or not out[-1].rstrip().endswith("-/"):
        return
    j, depth = len(out) - 1, 0
    while j >= 0:
        depth += out[j].count("-/") - out[j].count("/-")
        if depth <= 0 and ("/-" in out[j] or "/-!" in out[j]):
            del out[j:]
            return
        j -= 1


def strip(path):
    lines = open(path, encoding="utf-8").read().split("\n")
    out, dropped = [], []
    depth, i = 0, 0
    while i < len(lines):
        line = lines[i]
        top = depth == 0 and line[:1] not in (" ", "\t", "")
        if top and (line.startswith("theorem ") or line.startswith("lemma ")):
            dropped.append(line.split()[1])
            pop_comment(out)
            while out and (out[-1].startswith("set_option ") or out[-1].startswith("@[")):
                out.pop()
            i += 1
            body = 0
            while i < len(lines):
                nxt = lines[i]
                if body == 0 and nxt[:1] not in (" ", "\t", "") and TOP.match(nxt):
                    break
                body += nxt.count("/-") - nxt.count("-/")
                i += 1
            continue
        depth += line.count("/-") - line.count("-/")
        out.append(line)
        i += 1
    open(path, "w", encoding="utf-8").write("\n".join(out))
    print(f"{path.rsplit('/', 1)[-1]}: dropped {len(dropped)} ({', '.join(dropped[:6])}"
          f"{'…' if len(dropped) > 6 else ''})")
    return dropped


DECL_START = re.compile(r"^(?:@\[|noncomputable\b|private\b|protected\b|def\b|theorem\b|"
                        r"lemma\b|abbrev\b|structure\b|class\b|instance\b|example\b|"
                        r"namespace\b|end\b|variable\b|open\b|section\b|universe\b|"
                        r"attribute\b|set_option\b|scoped\b|local\b|/-|-)")


def cleanup_dangling_docs(path):
    """Delete `/-- … -/` blocks that no longer precede a declaration.

    Dropping a theorem leaves its docstring behind, and Lean reads a docstring as
    an annotation on the NEXT command: `unexpected token '/-!'; expected
    'lemma'` on whatever section header follows.  A docstring is dangling exactly
    when the next non-blank line is not the start of a declaration.
    """
    lines = open(path, encoding="utf-8").read().split("\n")
    out, i, removed = [], 0, 0
    while i < len(lines):
        if lines[i].startswith("/--"):
            j, depth = i, 0
            while j < len(lines):
                depth += lines[j].count("/-") - lines[j].count("-/")
                if depth <= 0:
                    break
                j += 1
            k = j + 1
            while k < len(lines) and lines[k].strip() == "":
                k += 1
            follower = DECL_START.match(lines[k]) if k < len(lines) else None
            # a comment (`/-`, `--`) is not a declaration: a docstring in front of
            # one is dangling, which is the `expected 'lemma'` error.
            if follower is None or lines[k].lstrip().startswith(("/-", "-")):
                removed += 1
                i = j + 1
                continue
        out.append(lines[i])
        i += 1
    open(path, "w", encoding="utf-8").write("\n".join(out))
    if removed:
        print(f"{path.rsplit('/', 1)[-1]}: removed {removed} dangling doc block(s)")


if __name__ == "__main__":
    for c in sys.argv[1:]:
        p = f"{WS}/Definitions/Def_{c}Promoted.lean"
        strip(p)
        cleanup_dangling_docs(p)
