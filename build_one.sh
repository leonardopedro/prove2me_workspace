#!/bin/bash
# Build a single def bundle using lake
WS="$(cd "$(dirname "$0")/.." && pwd)"
cd "$WS"

# Ensure the lean toolchain is on PATH (lake uses 'lean' internally)
export PATH="$HOME/.elan/toolchains/leanprover--lean4---v4.33.1/bin:$PATH"

# Check if .olean already exists
MODNAME="${1%.lean}"
OLFILE=".lake/build/lib/lean/Definitions/${MODNAME}"
if [ -f "${OLFILE}.olean" ]; then
    echo "SKIP (already built): $1"
    exit 0
fi

echo "BUILDING: $1"
lake build "Definitions.${MODNAME}" 2>&1
exit $?
