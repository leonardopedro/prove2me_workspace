#!/bin/bash
set -e

WS="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace"
LEAN="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean"
MATHLIB_PKG="$WS/.lake/packages/mathlib"

# Build in dependency order
BUILD_ORDER=(
    "ChapterDirectSumEsa"
    "ChapterComplexShiftCore"
    "ChapterQgHermiteOscillatorEsa"
    "ChapterQg3DGaugeEsa"
    "ChapterQgOuterFockEsa"
    "ChapterHermiteGalerkinFriedrichs"
    "ChapterHashimotoShiftInvert"
    "ChapterFriedrichsExtension"
    "ChapterQgOuterFockFarisLavine"
)

for dep in "${BUILD_ORDER[@]}"; do
    src="BookProof/${dep}.lean"
    echo ""
    echo "=== Building ${src} ==="
    
    LEAN_PATH="$WS/.lake/build/lib/lean:$MATHLIB_PKG/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/batteries/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/Qq/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/aesop/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/proofwidgets/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/importGraph/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/LeanSearchClient/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/plausible/.lake/build/lib/lean:$WS/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean:$MATHLIB_PKG"
    
    timeout 300 "$LEAN" "$src" 2>&1
    
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        echo "ERROR in ${src}"
        exit 1
    fi
    echo "OK: ${src}"
done

echo ""
echo "=== ALL BUILT SUCCESSFULLY ==="
