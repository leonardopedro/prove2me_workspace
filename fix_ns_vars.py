#!/usr/bin/env python3
"""Fix generator variable-dropping bug for NavierStokesFlow thm files.

Adds missing namespace-level variable declarations to thm files that the
generator dropped when extracting theorem statements.

Variables in Def_ChapterNavierStokesFlow.lean:
- {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]  (section FieldWithDerivatives)
- {n : ℕ} (L : LagrangianNS n)  (namespace LagrangianNS)
- {n : ℕ} (d : NSTruncation n)  (main namespace, after LagrangianNS)
- {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]  (section Deficiency)

Usage:
  python3 fix_ns_vars.py --dry-run
  python3 fix_ns_vars.py
"""
import argparse
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
WS = HERE
DEFS = os.path.join(WS, "Definitions")
THMS = os.path.join(WS, "Theorems")

# Variables to add, keyed by identifier name
# Each entry: (variable_line, import_if_missing)
VARIABLES = {
    'd': 'variable {n : ℕ} (d : NSTruncation n)',
    'F': 'variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]',
    'L': 'variable {n : ℕ} (L : LagrangianNS n)',
    'n': 'variable {n : ℕ}',
    'E': 'variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]',
}

IMPORT_MAP = {
    'NSTruncation': 'import Definitions.Def_ChapterNavierStokesFlow',
}


def get_file_variables(filepath):
    """Parse variable declarations from a def bundle file."""
    variables = {}
    with open(filepath) as f:
        content = f.read()
    # Match: variable {n : ℕ} (d : NSTruncation n)
    # Match: variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
    var_pattern = re.compile(r'^variable\s+(.+)$', re.MULTILINE)
    for m in var_pattern.finditer(content):
        line = m.group(1).strip()
        # Check if it declares something useful
        if 'NSTruncation' in line or 'LagrangianNS' in line or \
           (line.startswith('{F') and 'InnerProductSpace' in line):
            variables[line.split('(')[0].strip().lstrip('{').rstrip('}')] = line
    return variables


def find_missing_variables(thm_content, available_vars):
    """Find variable references in theorem body that aren't declared."""
    missing = []
    # Check for identifiers used as types/terms in the theorem signature
    # Look for patterns like (X : d → ...) or {d : NSTruncation n}
    sig_pattern = re.compile(r'\([^)]*\b(d|F|L|n|E)\b[^)]*\)')
    for m in sig_pattern.finditer(thm_content):
        ident = m.group(1)
        if ident in available_vars and ident not in available_vars:
            pass  # Already declared
        elif ident in available_vars:
            if ident not in [v.split('(')[0].strip().lstrip('{').rstrip('}') for v in available_vars.values()]:
                missing.append(ident)
    return missing


def add_variables_to_file(filepath, variables_to_add):
    """Add variable declarations to a thm file."""
    with open(filepath) as f:
        content = f.read()
    
    # Find the position after imports and opens, before the theorem
    # Look for the last "open" or "noncomputable section" before the theorem
    insert_pos = len(content)
    # Find the first theorem/def/lemma
    for pattern in [r'^theorem\s', r'^def\s', r'^lemma\s', r'^noncomputable\s+def\s']:
        m = re.search(pattern, content, re.MULTILINE)
        if m:
            insert_pos = m.start()
            break
    
    # Build the variable block
    var_block = '\n'.join(f'variable {v}' for v in variables_to_add)
    
    # Insert
    new_content = content[:insert_pos] + var_block + '\n\n' + content[insert_pos:]
    
    with open(filepath, 'w') as f:
        f.write(new_content)
    return True


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--dry-run', action='store_true')
    args = parser.parse_args()
    
    def_bundle = os.path.join(DEFS, 'Def_ChapterNavierStokesFlow.lean')
    if not os.path.exists(def_bundle):
        print(f"ERROR: {def_bundle} not found")
        sys.exit(1)
    
    # Get variables from def bundle
    def_vars = get_file_variables(def_bundle)
    print(f"Variables in def bundle: {list(def_vars.keys())}")
    
    # Find thm files for NavierStokesFlow
    ns_thms = [f for f in os.listdir(THMS) if 'NavierStokesFlow' in f and f.startswith('Thm_')]
    print(f"NavierStokesFlow thm files: {len(ns_thms)}")
    
    # Check each thm file for missing variables
    fixed = 0
    for thm_file in sorted(ns_thms):
        filepath = os.path.join(THMS, thm_file)
        with open(filepath) as f:
            content = f.read()
        
        # Find all variable references in the file (parenthesized identifiers in signatures)
        # Look for patterns like (d : ...) or (F : ...) or (L : ...) or {n : ℕ} or {E : Type*}
        declared = set()
        for m in re.finditer(r'[({]\s*(\w+)\s*:', content):
            declared.add(m.group(1))
        
        # Also check for existing variable declarations
        for m in re.finditer(r'^variable\s+', content, re.MULTILINE):
            declared.add('variable')  # mark that variables exist
        
        needed = []
        for ident in ['d', 'F', 'L', 'n', 'E']:
            if ident in declared:
                continue
            # Check if this identifier appears in the file as a type reference
            if re.search(rf'\b{ident}\b', content):
                needed.append(ident)
        
        if needed:
            print(f"  {thm_file}: needs {needed}")
            fixed += 1
            if not args.dry_run:
                add_variables_to_file(filepath, [VARIABLES[n] for n in needed])
    
    print(f"\nFixed {fixed} files")
    if args.dry_run:
        print("DRY RUN - no changes made")


if __name__ == '__main__':
    main()
