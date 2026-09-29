#!/bin/bash
LEAN="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean"
MATHLIB_PKG="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib"
WS="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace"
BUILD_DIR="$WS/.lake/build/lib/lean"
LEAN_DIR="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean"

# Build in dependency order
BUILD_ORDER=(
    "ChapterHermiteProductCore"
    "ChapterHermiteProductBasis"
    "ChapterHermiteFunctions"
    "ChapterQgHermiteFriedrichs"
    "ChapterQgHermiteOscillatorEsa"
    "ChapterComplexShiftCore"
    "ChapterHermiteGalerkinFriedrichs"
    "ChapterHashimotoShiftInvert"
    "ChapterFriedrichsExtension"
    "ChapterQg3DGaugeEsa"
    "ChapterQgOuterFockEsa"
    "ChapterQgOuterFockFarisLavine"
)

for mod in "${BUILD_ORDER[@]}"; do
    src="BookProof/${mod}.lean"
    echo ""
    echo "=== Building ${src} ==="
    
    LEAN_PATH="$BUILD_DIR:$MATHLIB_PKG/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/batteries/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/Qq/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/aesop/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/proofwidgets/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/importGraph/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/LeanSearchClient/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/plausible/.lake/build/lib/lean:$LEAN_DIR:$MATHLIB_PKG"
    
    timeout 600 "$LEAN" "$src" 2>&1 | tail -5
    
    if [ ${PIPESTATUS[0]} -ne 0 ]; then
        echo "FAILED: ${src}"
        exit 1
    fi
    echo "OK: ${src}"
done

echo ""
echo "=== ALL BUILT ==="
