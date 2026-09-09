#!/usr/bin/env python3
"""Generate def bundle + theorem stubs for a single BookProof chapter.

Usage:
  python3 scripts/gen_chapter.py ChapterSirkWhitening
  python3 scripts/gen_chapter.py ChapterSirkWhitening --force
"""
import sys
import os
import re

WS = "/home/leo/prove2me_workspace"
PROJ = "/home/leo/Projects/timepiece"
OUT_DEF = f"{WS}/Definitions"
OUT_THM = f"{WS}/Theorems"
OUT_SOL = f"{WS}/Solutions"


def extract_defs(leaf):
    """Extract def/structure/class/abbrev/instance decls from source."""
    path = f"{PROJ}/BookProof/{leaf}.lean"
    with open(path, encoding="utf-8") as f:
        lines = f.readlines()

    defs = []
    i = 0
    while i < len(lines):
        line = lines[i]
        # Match: def, abbrev, instance, structure, class, noncomputable def
        m = re.match(r"^((?:noncomputable\s+)?)(def|abbrev|instance|structure|class)\s+([A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*)\s*(\(|:)", line)
        if m:
            kind = m.group(2)
            name = m.group(3)
            # Skip if inside a where clause or after :=
            # Check next non-empty line for := (meaning it's a def with body, skip)
            j = i + 1
            while j < len(lines) and lines[j].strip() == "":
                j += 1
            if j < len(lines) and (" :=" in lines[j] or " where" in lines[j]):
                # This is a def with a body — skip (def-embedded theorems go in thm files)
                i += 1
                continue
            defs.append((kind, name, i + 1))
        i += 1
    return defs, lines


def extract_upstream_defs(leaf):
    """Extract BookProof.ChapterX imports and convert to Definitions.Def_ChapterX."""
    path = f"{PROJ}/BookProof/{leaf}.lean"
    imports = []
    with open(path, encoding="utf-8") as f:
        for line in f:
            m = re.match(r"^import BookProof\.Chapter([A-Z][A-Za-z0-9]*)", line)
            if m:
                name = m.group(1)
                imports.append(f"import Definitions.Def_Chapter{name}")
    return imports


def build_def_bundle(leaf, defs, lines):
    """Build a def bundle file content."""
    upstream = extract_upstream_defs(leaf)
    parts = ["import Mathlib"] + upstream + [
        "",
        f"/-!",
        f"# Chapter {leaf}",
        f"",
        f"Generated def bundle for {leaf}. See BookProof/{leaf}.lean for full context.",
        f"-/",
        "",
        "noncomputable section",
        "",
        f"namespace BookProof.Chapter{leaf.removeprefix('Chapter')}",
        "",
    ]

    for kind, name, lineno in defs:
        parts.append(f"{kind} {name}")
        parts.append("")

    parts.extend([
        "",
        f"end BookProof.Chapter{leaf.removeprefix('Chapter')}",
    ])
    return "\n".join(parts)


def extract_theorems(leaf, lines):
    """Extract theorem/lemma statements from source."""
    pattern = re.compile(
        r"^((?:protected\s+|private\s+|noncomputable\s+|partial\s+)*?)"
        r"(theorem|lemma)\s+([A-Za-z_][A-Za-z0-9_\.]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*)\s*(\(.*?\)|:.*?)(?:\s*:=|\s*where)"
    )
    theorems = []
    for i, line in enumerate(lines, 1):
        m = pattern.match(line)
        if m:
            theorems.append((i, m.group(2), m.group(3), m.group(4).strip()))
    return theorems


def build_thm_file(leaf, theorem_name, sig, lineno, lines):
    """Build a theorem stub file."""
    module_name = f"BookProof.{leaf.removeprefix('Chapter')}"
    # Extract just the variable/parameter part of the signature
    sig_body = sig
    # If signature has : type, extract the type part
    if ":" in sig_body and not sig_body.strip().startswith("("):
        # Split at the first colon not inside parens
        depth = 0
        for ci, ch in enumerate(sig_body):
            if ch == '(':
                depth += 1
            elif ch == ')':
                depth -= 1
            elif ch == ':' and depth == 0:
                sig_body = sig_body[ci+1:].strip()
                break

    content = f"""import Mathlib
import Definitions.Def_{leaf}

open BookProof.Chapter{leaf.removeprefix('Chapter')}




open Matrix
open scoped ComplexConjugate


variable {{{sig_body}}}


theorem {theorem_name} := by sorry
"""
    return content


def main():
    if len(sys.argv) < 2:
        print("Usage: python3 gen_chapter.py <ChapterName>")
        sys.exit(1)

    leaf = sys.argv[1]
    force = "--force" in sys.argv

    # Check if def bundle already exists
    def_path = f"{OUT_DEF}/Def_{leaf}.lean"
    if not force and os.path.exists(def_path):
        print(f"Def bundle already exists: {def_path}")
        print("Use --force to overwrite")
        sys.exit(0)

    print(f"Processing {leaf}...")

    defs, lines = extract_defs(leaf)
    print(f"  Found {len(defs)} defs")

    # Build and write def bundle
    bundle = build_def_bundle(leaf, defs, lines)
    with open(def_path, "w", encoding="utf-8") as f:
        f.write(bundle)
    print(f"  -> {def_path}")

    # Extract theorems
    theorems = extract_theorems(leaf, lines)
    print(f"  Found {len(theorems)} theorems")

    # Build and write theorem stubs
    for lineno, kind, name, sig in theorems:
        slug = name.replace(".", "_")
        thm_content = build_thm_file(leaf, name, sig, lineno, lines)
        thm_path = f"{OUT_THM}/Thm_{slug}.lean"
        with open(thm_path, "w", encoding="utf-8") as f:
            f.write(thm_content)
        print(f"  -> {thm_path}")

    print(f"Done: {leaf}")


if __name__ == "__main__":
    main()
