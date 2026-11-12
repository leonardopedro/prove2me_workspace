#!/bin/bash
# Thm/sol(+def) drain launcher.  The single-writer guard lives here, not in the
# caller's command line, so it cannot self-match its own text.
cd "$(dirname "$0")/.." || exit 1
if pgrep -f '[u]pload_pipeline\.py' >/dev/null 2>&1; then
  echo "an upload_pipeline process is already alive -- refusing (single writer)"
  exit 3
fi
LOG="state/logs/drain_sols_$(date +%m%d_%H%M).log"
echo "log: $LOG"
exec python3 pipeline/upload_pipeline.py --kind thm --kind sol --kind def --parallel 20 >> "$LOG" 2>&1
