#!/bin/bash
cd /media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace
PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/toolchains/leanprover--lean4---v4.33.1/bin:$PATH"
exec lake build 2>&1 | tee /tmp/lake_build_full.log
