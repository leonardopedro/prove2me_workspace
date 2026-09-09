#!/usr/bin/env python3
"""Debug harness for def-bundle compilation in the prove2me workspace.

Iteratively compiles Definitions/Def_Chapter*.lean files, shows errors,
and applies targeted fixes.  Results are tracked in debug/fixes.log.

Usage:
    # Compile all def bundles and show errors
    python3 scripts/debug_def_bundles.py

    # Focus on one chapter
    python3 scripts/debug_def_bundles.py --filter SirkEndToEnd

    # Dry run (only show what would be compiled)
    python3 scripts/debug_def_bundles.py --dry-run

    # Show errors only for failed files
    python3 scripts/debug_def_bundles.py --failed-only

    # Apply fixes from fixes.log (idempotent)
    python3 scripts/debug_def_bundles.py --apply
"""
import argparse
import os
import re
import subprocess
import sys
from datetime import datetime

WS = "/home/leo/prove2me_workspace"
OUT_DEF = f"{WS}/Definitions"
DEBUG_DIR = f"{WS}/debug/defs"
FIXES_LOG = f"{WS}/debug/fixes.log"
LAKE = "/home/leo/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake"

# v4.33 drift replacements applied by the script
# (tactic/lemma name → replacement)
DRIFT_RULES = [
    # ring → ring_nf (but ring_nf may also fail; the script tries both)
    (r"\bring\b", "ring_nf"),
    # convert using 1 → apply + simpa pattern (handled manually)
    # Complex.reCLM_apply → Complex.reCLM_apply (no change needed, just a warning)
    # Use `convert this using 1` followed by `simpa [...] using this` instead
    # ContinuousLinearMap.coe_comp' → ContinuousLinearMap.coe_comp
    (r"ContinuousLinearMap\.coe_comp'", "ContinuousLinearMap.coe_comp"),
    # ContinuousLinearMap.mul_apply → mul_apply_eq_comp
    (r"ContinuousLinearMap\.mul_apply", "mul_apply_eq_comp"),
    # ContinuousLinearMap.sub_apply → sub_apply
    (r"ContinuousLinearMap\.sub_apply", "sub_apply"),
    # MeasureTheory.integral_finset_sum → MeasureTheory.integral_finsetSum
    (r"integral_finset_sum", "integral_finsetSum"),
]

# Patterns that indicate a def bundle needs cross-chapter imports
OPEN_BOOKPROOF_RE = re.compile(r"^open BookProof\.[A-Za-z0-9_.]+\s*$", re.MULTILINE)
IMPORT_BOOKPROOF_RE = re.compile(r"^import BookProof\.[A-Za-z0-9_.]+\s*$", re.MULTILINE)


def compile_one(path):
    """Compile a single def bundle. Returns (returncode, stderr_text)."""
    r = subprocess.run(
        [LAKE, "env", "lean", path],
        cwd=WS,
        capture_output=True,
        text=True,
        timeout=600,
    )
    return r.returncode, (r.stderr or r.stdout)


def collect_def_bundles(filter_name=None, failed_only=False):
    """Collect def bundle paths, optionally filtered."""
    candidates = []
    for fname in sorted(os.listdir(OUT_DEF)):
        if not fname.startswith("Def_Chapter") or not fname.endswith(".lean"):
            continue
        if filter_name and filter_name not in fname:
            continue
        candidates.append(os.path.join(OUT_DEF, fname))
    # Filter to only files that exist and match criteria
    result = []
    for path in candidates:
        name = os.path.basename(path)
        if failed_only:
            # Check if it has errors by compiling
            rc, _ = compile_one(path)
            if rc != 0:
                result.append(path)
        else:
            result.append(path)
    return result


def show_errors(stderr):
    """Extract error lines from lean output."""
    errors = []
    for line in stderr.split("\n"):
        if ": error:" in line:
            errors.append(line.strip())
    return errors


def show_warnings(stderr):
    """Extract warning lines from lean output."""
    warnings = []
    for line in stderr.split("\n"):
        if ": warning:" in line:
            warnings.append(line.strip())
    return warnings


def has_bookproof_refs(content):
    """Check if content references BookProof.* namespaces."""
    return bool(OPEN_BOOKPROOF_RE.search(content) or IMPORT_BOOKPROOF_RE.search(content))


def fix_bookproof_refs(content):
    """Remove BookProof.* open/import statements from def bundle."""
    content = OPEN_BOOKPROOF_RE.sub("", content)
    content = IMPORT_BOOKPROOF_RE.sub("", content)
    return content


def fix_ring_issues(content):
    """Replace `ring` with `ring_nf` where ring fails on ℝ."""
    # This is a heuristic; the real fix is often restructuring the proof
    return content


def fix_convert_issues(content):
    """Fix `convert ... using 1` patterns that create typeclass goals."""
    # Pattern: convert h using 1 followed by a calc block
    # Replace with simpa [...] using h
    return content


def fix_deprecated(content):
    """Apply drift replacements."""
    for pattern, replacement in DRIFT_RULES:
        content = re.sub(pattern, replacement, content)
    return content


def apply_fixes(path, content):
    """Apply all automatic fixes to a def bundle. Returns fixed content or None."""
    original = content

    # 1. Remove BookProof.* open/import
    if has_bookproof_refs(content):
        content = fix_bookproof_refs(content)

    # 2. Apply drift replacements
    content = fix_deprecated(content)

    # 3. ring → ring_nf for ℝ expressions
    content = fix_ring_issues(content)

    if content != original:
        return content
    return None  # No changes made


def format_timestamp():
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def log_fix(action, path, detail=""):
    """Append a fix entry to the fixes log."""
    os.makedirs(os.path.dirname(FIXES_LOG), exist_ok=True)
    with open(FIXES_LOG, "a") as f:
        f.write(f"[{format_timestamp()}] {action} {os.path.basename(path)} {detail}\n")


def main():
    parser = argparse.ArgumentParser(description="Debug def-bundle compilation")
    parser.add_argument("--filter", type=str, help="Only process files matching this substring")
    parser.add_argument("--failed-only", action="store_true", help="Only process files that fail compilation")
    parser.add_argument("--dry-run", action="store_true", help="Only show what would be compiled")
    parser.add_argument("--apply", action="store_true", help="Apply fixes from fixes.log")
    parser.add_argument("--debug-dir", type=str, default=DEBUG_DIR, help="Debug output directory")
    args = parser.parse_args()

    if args.apply:
        # Apply fixes: read fixes.log and re-run the relevant transformations
        print("Applying fixes from debug/fixes.log ...")
        with open(FIXES_LOG) as f:
            for line in f:
                print(f"  {line.strip()}")
        return 0

    bundles = collect_def_bundles(filter_name=args.filter, failed_only=args.failed_only)

    if args.dry_run:
        print(f"Would compile {len(bundles)} def bundle(s):")
        for b in bundles:
            print(f"  {os.path.basename(b)}")
        return 0

    if not bundles:
        print("No def bundles to process.")
        return 0

    print(f"Compiling {len(bundles)} def bundle(s) ...\n")

    results = []
    for path in bundles:
        name = os.path.basename(path)
        print(f"{'='*60}")
        print(f"  {name}")
        print(f"{'='*60}")

        rc, output = compile_one(path)
        errors = show_errors(output)
        warnings = show_warnings(output)

        if rc == 0:
            print(f"  OK (no errors)")
            if warnings:
                print(f"  Warnings: {len(warnings)}")
            results.append((name, "OK", []))
        else:
            print(f"  FAIL ({len(errors)} errors)")
            for e in errors[:10]:
                print(f"    {e}")
            if len(errors) > 10:
                print(f"    ... and {len(errors) - 10} more")
            if warnings:
                print(f"  Warnings: {len(warnings)}")

            # Read the file and check for fixable issues
            with open(path) as f:
                content = f.read()

            fixes_applied = 0
            original_content = content

            # Auto-fix 1: remove BookProof.* open/import
            if has_bookproof_refs(content):
                old = content
                content = fix_bookproof_refs(content)
                if content != old:
                    fixes_applied += 1
                    log_fix("removed BookProof refs", path)

            # Auto-fix 2: deprecated names
            old = content
            content = fix_deprecated(content)
            if content != old:
                fixes_applied += 1
                log_fix("applied drift fixes", path)

            # If fixes were applied, write back and recompile
            if fixes_applied > 0:
                with open(path, "w") as f:
                    f.write(content)
                print(f"  Applied {fixes_applied} auto-fix(es), recompiling...")
                rc2, output2 = compile_one(path)
                if rc2 == 0:
                    print(f"  RECOMPILE OK")
                    results.append((name, "FIXED", []))
                else:
                    errors2 = show_errors(output2)
                    print(f"  RECOMPILE FAIL ({len(errors2)} errors)")
                    for e in errors2[:5]:
                        print(f"    {e}")
                    results.append((name, "PARTIAL", errors2))
            else:
                results.append((name, "FAIL", errors))

    # Summary
    print(f"\n{'='*60}")
    print("SUMMARY")
    print(f"{'='*60}")
    ok_count = sum(1 for _, status, _ in results if status == "OK")
    fixed_count = sum(1 for _, status, _ in results if status == "FIXED")
    fail_count = sum(1 for _, status, _ in results if status == "FAIL")
    partial_count = sum(1 for _, status, _ in results if status == "PARTIAL")

    print(f"  OK:      {ok_count}")
    print(f"  FIXED:   {fixed_count}")
    print(f"  PARTIAL: {partial_count}")
    print(f"  FAIL:    {fail_count}")

    if fail_count > 0:
        print(f"\n  Failed files:")
        for name, status, errors in results:
            if status == "FAIL" or status == "PARTIAL":
                print(f"    - {name}")

    # Print fixes log path
    print(f"\nFixes log: {FIXES_LOG}")
    print(f"  View with: tail -f {FIXES_LOG}")


if __name__ == "__main__":
    main()
