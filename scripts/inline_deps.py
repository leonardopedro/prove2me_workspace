#!/usr/bin/env python3
"""Produce a self-contained def bundle by inlining all transitive dependencies.

For a given source chapter, this script:
1. Reads the source file
2. Finds all `import BookProof.ChapterX` statements
3. Recursively processes those chapters
4. Strips all `import BookProof.*` and `open BookProof.*` statements
5. Outputs a single file with everything inlined

Usage:
    python3 scripts/inline_deps.py ChapterSirkPerSystem
    python3 scripts/inline_deps.py --dry-run ChapterSirkPerSystem
    python3 scripts/inline_deps.py --output /tmp/full.lean ChapterSirkPerSystem
"""
import argparse
import json
import os
import re
import sys

PROJ = "/home/leo/Projects/timepiece"
OUT_DEF = f"/home/leo/prove2me_workspace/Definitions"

# Cache of already-inlined files to avoid duplication
_inlined = {}


def src_path(leaf):
    return f"{PROJ}/BookProof/{leaf}.lean"


def read_src(leaf):
    path = src_path(leaf)
    if not os.path.exists(path):
        raise FileNotFoundError(f"Source {path} not found")
    with open(path, encoding="utf-8") as f:
        return f.read()


def find_imports(text):
    """Find all `import BookProof.ChapterX` statements."""
    return re.findall(r'^import BookProof\.Chapter([A-Za-z0-9]+)(?:\.lean)?\s*$', text, re.MULTILINE)


def find_opens(text):
    """Find all `open BookProof.X` statements."""
    return re.findall(r'^open BookProof\.([A-Za-z0-9_]+)\s*$', text, re.MULTILINE)


def inline_chapter(leaf, visited=None):
    """Recursively inline all dependencies of a chapter.

    Returns (content, set_of_inlined_leafs).
    """
    if visited is None:
        visited = set()
    
    if leaf in visited:
        return None, visited  # Already inlined
    visited.add(leaf)
    
    if leaf in _inlined:
        return _inlined[leaf], visited
    
    print(f"  Inlining {leaf} (deps: {find_imports(read_src(leaf))})")
    
    src = read_src(leaf)
    
    # Find recursive dependencies
    deps = find_imports(src)
    
    # Process dependencies first
    parts = []
    for dep in deps:
        dep_leaf = f"Chapter{dep}"
        dep_content, visited = inline_chapter(dep_leaf, visited)
        if dep_content:
            parts.append(dep_content)
            parts.append("")
    
    # Strip all imports and opens
    src = re.sub(r'^import BookProof\.[^\n]*\n', '', src, flags=re.M)
    src = re.sub(r'^import [^\n]*\n', 'import Mathlib\n', src, flags=re.M)
    src = re.sub(r'^open BookProof\.[^\n]*\n', '', src, flags=re.M)
    
    # Also strip any remaining `import Mathlib` duplicates (keep only one)
    src = re.sub(r'^import Mathlib\n(import Mathlib\n)*', 'import Mathlib\n', src, flags=re.M)
    
    parts.append(src)
    
    result = "\n".join(parts)
    _inlined[leaf] = result
    
    return result, visited


def main():
    parser = argparse.ArgumentParser(description="Inline transitive deps into def bundle")
    parser.add_argument("chapter", help="Source chapter to inline")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be inlined")
    parser.add_argument("--output", type=str, help="Output file (default: Definitions/Def_Chapter<chapter>.lean)")
    args = parser.parse_args()
    
    leaf = args.chapter
    if not leaf.startswith("Chapter"):
        leaf = f"Chapter{leaf}"
    
    print(f"Inlining dependencies for {leaf}...")
    print()
    
    content, visited = inline_chapter(leaf)
    
    if content is None:
        print(f"Already inlined {leaf}")
        sys.exit(0)
    
    if args.dry_run:
        print(f"\nWould inline: {', '.join(sorted(visited))}")
        print(f"Output size: {len(content)} chars")
        sys.exit(0)
    
    # Determine output path
    if args.output:
        out_path = args.output
    else:
        out_path = f"{OUT_DEF}/Def_{leaf}.lean"
    
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(content)
    
    print(f"\nWritten {len(content)} chars to {out_path}")
    print(f"Inlined chapters: {', '.join(sorted(visited))}")


if __name__ == "__main__":
    main()
