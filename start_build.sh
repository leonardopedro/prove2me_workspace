#!/bin/bash
# Start lake build Definitions as a fully detached daemon
# Usage: nohup ./start_build.sh &>/dev/null &
cd "$(dirname "$0")"
LEAN=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean
LAKE=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lake
export LAKE_BIN="$LAKE"
setsid "$LAKE" build Definitions > /tmp/lake_build.log 2>&1 &
disown
echo "Build started in background"
