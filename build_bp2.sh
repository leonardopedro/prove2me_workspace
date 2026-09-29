#!/bin/bash
# Build BookProof modules in dependency order
set -e

WS="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace"
LEAN="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean"
MATHLIB_PKG="$WS/.lake/packages/mathlib"
BUILD_DIR="$WS/.lake/build/lib/lean"

# Ensure output directory exists
mkdir -p "$BUILD_DIR/BookProof"

export LEAN_PATH="$BUILD_DIR:$MATHLIB_PKG/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/batteries/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/Qq/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/aesop/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/proofwidgets/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/importGraph/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/LeanSearchClient/.lake/build/lib/lean:$MATHLIB_PKG/.lake/packages/plausible/.lake/build/lib/lean:$LEAN_DIR"

# Modules that are already built
BUILT=("ChapterHermiteFunctions")

build_module() {
    local mod="$1"
    local src="BookProof/${mod}.lean"
    
    # Skip if already built
    for b in "${BUILT[@]}"; do
        if [ "$mod" = "$b" ]; then
            return 0
        fi
    done
    
    echo ""
    echo "=== Building ${src} ==="
    
    # Build all dependencies first
    local deps
    deps=$(grep "^import BookProof\." "$src" 2>/dev/null | sed 's/^import BookProof\.//' | while read imp; do
        # Find the module file
        for f in BookProof/*.lean; do
            base=$(basename "$f" .lean)
            if [ "$base" = "$imp" ] || [ "$base" = "Chapter${imp}" ] || [ "${imp#Chapter}" = "$base" ]; then
                echo "$base"
                break
            fi
        done
    done)
    
    for dep in $deps; do
        build_module "$dep"
    done
    
    timeout 300 "$LEAN" "$src" > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        echo "OK: ${src}"
        BUILT+=("$mod")
    else
        echo "ERROR in ${src}"
        "$LEAN" "$src" 2>&1 | tail -20
        return 1
    fi
}

# Build target and its dependencies
build_module "ChapterQgOuterFockFarisLavine"

echo ""
echo "=== ALL BUILT ==="
