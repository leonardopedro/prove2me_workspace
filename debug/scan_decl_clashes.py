#!/usr/bin/env python3
"""Find two published definition bundles that declare the same constant.

The platform inlines a definition job's whole import closure and, if that
inlined set does not resolve, silently compiles the text alone (`unknown
namespace MvPolynomial` for a header that mentions nothing).  A cross-module
duplicate declaration is one way an otherwise fine pair of bundles makes the
union unbuildable, and it is invisible module-by-module.

This tracks namespace scope (`namespace A.B` / `end` / `section` / `end`) and
reports any fully-qualified name declared twice across the given closure.

Usage:
  python3 debug/scan_decl_clashes.py ChapterSmComparisonEsa ChapterQg3DGaugeFarisLavine
  python3 debug/scan_decl_clashes.py --closure ChapterSmComparisonEsa
"""
import argparse
import re
import sys

sys.path.insert(0, "pipeline")
import upload_pipeline as up  # noqa: E402

DECL = re.compile(
    r"^\s*(?:@\[[^\]]*\]\s*)*"
    r"(?:protected\s+|private\s+|nonrec\s+|partially\s+)?"
    r"(?:theorem|lemma|def|abbrev|instance|structure|class|inductive|opaque|axiom)"
    r"\s+([^\s({:«]+)", re.M)
NS = re.compile(r"^\s*namespace\s+(\S+)\s*$", re.M)
OPEN_SCOPE = re.compile(r"^\s*(?:noncomputable\s+)?(section|namespace\b.*)\s*$", re.M)
END = re.compile(r"^\s*end\b(.*)$", re.M)


def served():
    out = {}
    for j in up._paged("publish-jobs", {"kind": "definition"}):
        if j.get("status") != "PUBLISHED":
            continue
        n = j.get("theorem_name")
        prev = out.get(n)
        if prev is None or (j.get("created_at") or "") > (prev[0] or ""):
            out[n] = (j.get("created_at"), j.get("definitions") or "")
    return out


def closure(pub, roots):
    seen, stack = set(), list(roots)
    while stack:
        n = stack.pop()
        if n in seen or n not in pub:
            continue
        seen.add(n)
        for x in re.findall(r"(?m)^import\s+Definitions\.Def_(\S+)", pub[n][1]):
            stack.append(x)
    return seen


def declarations(text):
    """(fully_qualified_name, lineno) for every top-level declaration."""
    scope = []          # stack of namespace segments / '' for section
    out = []
    lines = text.splitlines()
    for i, line in enumerate(lines, 1):
        m = NS.match(line)
        if m:
            scope.extend(m.group(1).split("."))
            continue
        if re.match(r"^\s*noncomputable\s+section\s*$", line) or re.match(r"^\s*section\s*$", line):
            scope.append("")
            continue
        if END.match(line):
            nm = END.match(line).group(1).strip()
            if scope:
                if nm:
                    parts = nm.split(".")
                    for _ in parts:
                        if scope:
                            scope.pop()
                else:
                    scope.pop()
            continue
        m = DECL.match(line)
        if m:
            name = m.group(1)
            if name.startswith("_") or "." in name and name.split(".")[0] in ("List", "Nat"):
                pass
            full = ".".join([s for s in scope if s] + [name])
            out.append((full, i))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("modules", nargs="+")
    ap.add_argument("--closure", action="store_true",
                    help="expand each argument to its import closure")
    a = ap.parse_args()
    pub = served()
    roots = set(a.modules)
    mods = set()
    for r in roots:
        mods |= closure(pub, [r]) if a.closure else {r}
    owner = {}
    clashes = 0
    for m in sorted(mods):
        if m not in pub:
            print(f"!! {m}: not published")
            continue
        for full, ln in declarations(pub[m][1]):
            prev = owner.get(full)
            if prev and prev[0] != m:
                clashes += 1
                print(f"CLASH {full}\n   {prev[0]}:{prev[1]}  vs  {m}:{ln}")
            else:
                owner[full] = (m, ln)
    print(f"{len(mods)} module(s), {len(owner)} declaration(s), {clashes} clash(es)")


if __name__ == "__main__":
    main()
