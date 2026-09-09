#!/usr/bin/env python3
"""Make def bundles self-contained by inlining definitions from transitive
dependencies.

For each def bundle, this script:
1. Reads the source chapter to get the full text
2. Strips `import BookProof.*` and `open BookProof.*` statements
3. For each remaining qualified name (e.g., `BookProof.FarisLavine.foo`), extracts
   the definition from the source chapter
4. Inserts the extracted definitions before the namespace

Usage:
    # Make a single def bundle self-contained
    python3 scripts/make_self_contained.py --defs SirkEndToEnd

    # Make all current-wave def bundles self-contained
    python3 scripts/make_self_contained.py --wave

    # Dry run
    python3 scripts/make_self_contained.py --wave --dry-run

    # List available def bundles
    python3 scripts/make_self_contained.py --list
"""
import argparse
import json
import os
import re
import sys

WS = "/home/leo/prove2me_workspace"
PROJ = "/home/leo/Projects/timepiece"
OUT_DEF = f"{WS}/Definitions"
PIPE = f"{WS}/pipeline"

# Current wave defs from wave_upload.json
WAVE_DEFS = json.load(open(f"{PIPE}/wave_upload.json"))["defs"]

# All defs (including transitive deps) that the generator knows about
ALL_DEFS = json.load(open(f"{PIPE}/wave_upload.json"))["defs"]


def get_def_names():
    """Get list of all def bundle names."""
    return list(ALL_DEFS.keys())


def src_path(leaf):
    return f"{PROJ}/BookProof/{leaf}.lean"


def def_path(leaf):
    return f"{OUT_DEF}/Def_{leaf}.lean"


def read_src(leaf):
    with open(src_path(leaf), encoding="utf-8") as f:
        return f.read()


def read_def(leaf):
    path = def_path(leaf)
    if os.path.exists(path):
        with open(path, encoding="utf-8") as f:
            return f.read()
    return None


# ---------------------------------------------------------------------------
# Step 1: Strip BookProof imports/opens from def bundle
# ---------------------------------------------------------------------------

def strip_bookproof_refs(text):
    """Remove `import BookProof.*` and `open BookProof.*` lines."""
    text = re.sub(r"^import BookProof\.[^\n]*\n", "", text, flags=re.M)
    text = re.sub(r"^open BookProof\.[^\n]*\n", "", text, flags=re.M)
    return text


# ---------------------------------------------------------------------------
# Step 2: Find qualified names that need resolution
# ---------------------------------------------------------------------------

def find_qualified_names(text):
    """Find all `BookProof.X.Y` qualified names used in the text."""
    # Match BookProof.Namespace.identifier patterns
    pattern = re.compile(r"BookProof\.([A-Za-z0-9_]+)\.([A-Za-z0-9_]+)")
    names = {}
    for m in pattern.finditer(text):
        ns = m.group(1)
        name = m.group(2)
        if ns not in names:
            names[ns] = set()
        names[ns].add(name)
    return names


# ---------------------------------------------------------------------------
# Step 3: Extract definitions from source chapters
# ---------------------------------------------------------------------------

def extract_definitions(leaf, namespaces):
    """Extract needed definitions from source chapter.

    For each namespace, find the corresponding source chapter and extract
    the definitions of the requested names.
    """
    extracted = {}
    for ns, names in namespaces.items():
        # Map namespace to source leaf
        # BookProof.ChapterH4 -> ChapterH4
        # BookProof.HashimotoShiftInvert -> HashimotoShiftInvert (but this is a chapter?)
        # etc.
        
        # Try direct mapping: BookProof.X -> ChapterX
        if ns.startswith("Chapter"):
            src_leaf = ns  # BookProof.ChapterH4 -> ChapterH4
        else:
            # BookProof.FarisLavine -> FarisLavine
            src_leaf = ns
        
        # Check if source exists
        src_file = src_path(src_leaf)
        if not os.path.exists(src_file):
            print(f"  WARNING: source {src_file} not found")
            continue
        
        src = read_src(src_leaf)
        
        # Find the namespace in the source
        # The source has `namespace BookProof.FarisLavine` or `namespace BookProof.ChapterH4`
        ns_pattern = f"namespace BookProof\.{re.escape(ns)}"
        ns_match = re.search(ns_pattern, src)
        if not ns_match:
            # Try without BookProof. prefix
            ns_pattern = f"namespace {re.escape(ns)}"
            ns_match = re.search(ns_pattern, src)
        
        if not ns_match:
            print(f"  WARNING: namespace BookProof.{ns} not found in {src_file}")
            continue
        
        ns_start = ns_match.start()
        
        # Find the definitions of the requested names within this namespace
        defs_text = []
        for name in sorted(names):
            # Pattern: def name ... or theorem name ... or lemma name ...
            # We need to find the declaration start and end
            pattern = re.compile(
                rf"(?:^\s*(?:def|theorem|lemma|abbrev|noncomputable\s+(?:def|theorem|lemma))\s+{re.escape(name)}\b)",
                re.MULTILINE
            )
            m = pattern.search(src, ns_start)
            if not m:
                # Try matching without word boundary
                pattern = re.compile(
                    rf"(?:^\s*(?:def|theorem|lemma|abbrev|noncomputable\s+(?:def|theorem|lemma))\s+{re.escape(name)})",
                    re.MULTILINE
                )
                m = pattern.search(src, ns_start)
            
            if not m:
                print(f"  WARNING: definition '{name}' not found in namespace BookProof.{ns}")
                continue
            
            # Find the end of the declaration (next 'end BookProof...' or 'end' at column 0)
            # This is approximate — we need to find the matching 'end'
            decl_start = m.start()
            
            # Walk forward to find 'end BookProof.{ns}' or just 'end' at column 0
            depth = 0
            in_decl = False
            for i in range(decl_start, len(src)):
                if src[i] == '\n':
                    # Check if this line starts with 'end' at column 0
                    line_start = src.rfind('\n', 0, i) + 1
                    line = src[line_start:i].strip()
                    if line == 'end' or line.startswith('end '):
                        if depth == 0:
                            decl_end = i
                            break
                        elif line.startswith('end '):
                            depth -= 1
                    # Track nested 'section'/'namespace'/'end' pairs?
                    # For simplicity, just find 'end BookProof.{ns}'
                    if line.startswith(f'end BookProof.{ns}'):
                        depth -= 1
                        if depth == 0:
                            decl_end = i + len(line)
                            break
                # Track nested sections/namespaces
                if src[i] == '\n':
                    stripped = src[src.rfind('\n', 0, i)+1:i].strip()
                    if stripped.startswith('section ') or stripped.startswith('namespace ') or stripped.startswith('noncomputable section'):
                        depth += 1
                    elif stripped.startswith('end '):
                        depth -= 1
            else:
                decl_end = len(src)
            
            def_text = src[decl_start:decl_end].strip()
            defs_text.append(def_text)
        
        if defs_text:
            extracted[ns] = '\n\n'.join(defs_text)
    
    return extracted


def make_self_contained(leaf, def_text, dry_run=False):
    """Make a single def bundle self-contained."""
    print(f"\n{'='*60}")
    print(f"  {leaf}")
    print(f"{'='*60}")
    
    # Step 1: Strip BookProof refs
    stripped = strip_bookproof_refs(def_text)
    
    # Step 2: Find qualified names
    qnames = find_qualified_names(stripped)
    if not qnames:
        print(f"  No BookProof.* references found — already self-contained")
        return stripped
    
    print(f"  References to resolve:")
    for ns, names in sorted(qnames.items()):
        print(f"    BookProof.{ns}.{', '.join(sorted(names)[:5])}")
        if len(names) > 5:
            print(f"      ... and {len(names) - 5} more")
    
    # Step 3: Extract definitions
    print(f"  Extracting from source...")
    extracted = extract_definitions(leaf, qnames)
    
    if not extracted:
        print(f"  WARNING: no definitions could be extracted")
        return stripped
    
    print(f"  Extracted definitions:")
    for ns, text in extracted.items():
        lines = text.count('\n') + 1
        print(f"    BookProof.{ns}: {lines} lines")
    
    # Step 4: Build self-contained version
    # Insert extracted definitions before the first declaration in the namespace
    lines = stripped.split('\n')
    
    # Find the first line after 'namespace BookProof.X'
    insert_idx = None
    for i, line in enumerate(lines):
        if line.strip().startswith('namespace BookProof.'):
            insert_idx = i + 1
            break
        if line.strip() == 'namespace BookProof.ChapterSirkDiffusiveDecay':
            insert_idx = i + 1
            break
    
    if insert_idx is None:
        print(f"  WARNING: could not find insertion point")
        return stripped
    
    # Build the preamble with extracted definitions
    preamble = []
    for ns, text in extracted.items():
        preamble.append(f"/-! ## Cross-chapter definitions from `BookProof.{ns}` -/")
        preamble.append(text)
        preamble.append("")
    
    result = '\n'.join(lines[:insert_idx]) + '\n' + '\n'.join(preamble) + '\n'.join(lines[insert_idx:])
    
    if dry_run:
        print(f"\n  DRY RUN — would write {len(result)} chars")
        return result
    
    # Write back
    out_path = def_path(leaf)
    with open(out_path, 'w', encoding="utf-8") as f:
        f.write(result)
    print(f"  Written to {out_path}")
    
    return result


def main():
    parser = argparse.ArgumentParser(description="Make def bundles self-contained")
    parser.add_argument("--defs", nargs="+", help="Specific def bundles to process")
    parser.add_argument("--wave", action="store_true", help="Process all current-wave defs")
    parser.add_argument("--dry-run", action="store_true", help="Show what would be done")
    parser.add_argument("--list", action="store_true", help="List available def bundles")
    args = parser.parse_args()
    
    if args.list:
        print("Available def bundles:")
        for name in get_def_names():
            print(f"  {name}")
        return 0
    
    # Determine which defs to process
    if args.defs:
        targets = args.defs
    elif args.wave:
        # Get current wave defs from wave_upload.json
        targets = list(WAVE_DEFS.keys())
    else:
        parser.print_help()
        return 1
    
    for leaf in targets:
        def_text = read_def(leaf)
        if def_text is None:
            print(f"\nSKIP {leaf}: file not found")
            continue
        
        result = make_self_contained(leaf, def_text, dry_run=args.dry_run)
        
        if args.dry_run:
            print(f"  Would write: {len(result)} chars")
    
    print(f"\nDone.")


if __name__ == "__main__":
    main()
