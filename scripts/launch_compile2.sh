#!/bin/bash
cd /media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace
export PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin:$PATH"
nohup python3 scripts/compile_deps_parallel.py > /tmp/compile_parallel.log 2>&1 &
echo "PID=$!" > /tmp/compile_parallel.pid
