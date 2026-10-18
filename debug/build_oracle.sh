#!/usr/bin/env bash
# Build the local sol oracle: workspace Definitions + Theorems oleans.
# With those in .lake/build/lib/lean, `lake env lean Solutions/Sol_X.lean`
# resolves `import Definitions.Def_ChapterY` and `import Theorems.Thm_Z`, so a
# repaired sol can be verified locally before spending a platform attempt.
set -u
WS=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace
cd "$WS"
export PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH"
echo "=== oracle build start $(date -Is) ==="
lake build Definitions Theorems
echo "=== oracle build end $(date -Is) rc=$? ==="
