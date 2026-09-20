#!/bin/bash
cd /media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace

export PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH"
export LEAN_PATH=".lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.lake/packages/mathlib/.lake/build/lib/lean:/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/lib/lean"
export LAKE_BIN="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin/lean"
export PROVE2ME_SKIP_LOCAL_COMPILE=1

# Check if already running
if [ -f state/upload.pid ]; then
    OLD_PID=$(cat state/upload.pid)
    if kill -0 $OLD_PID 2>/dev/null; then
        echo "Upload already running (PID $OLD_PID)"
        exit 1
    fi
fi

nohup python3 pipeline/upload_pipeline.py --parallel 50 --job-timeout 60 --max-seconds 600 > state/upload.log 2>&1 &
echo "Upload started with PID $!"
echo $! > state/upload.pid
echo "Started at $(date)"
