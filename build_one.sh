#!/bin/bash
# Build a single def bundle using the correct LEAN_PATH for lean4.33.1
cd /media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace

LEAN="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean"
LEAN_PATH="$PWD/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/batteries/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/Qq/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/aesop/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/proofwidgets/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/importGraph/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/LeanSearchClient/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/packages/plausible/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean"
export LEAN_PATH

# Check if .olean already exists
# $1 is the module name like "Def_ChapterFoo.lean"
# We need to strip the .lean extension for the output file name
MODNAME="${1%.lean}"
OLFILE=".lake/build/lib/lean/Definitions/${MODNAME}"
if [ -f "${OLFILE}.olean" ]; then
    echo "SKIP (already built): $1"
    exit 0
fi

# Also check .ilean (compiled in previous session)
if [ -f "${OLFILE}.ilean" ]; then
    echo "SKIP (cached): $1"
    exit 0
fi

echo "BUILDING: $1"
timeout 180 "$LEAN" "$@" 2>&1
exit $?
