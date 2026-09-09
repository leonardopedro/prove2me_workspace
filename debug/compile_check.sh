#!/usr/bin/env bash
# Compile-gate every def bundle needed for the upstream-def publication wave.
# Per-module targets (lake build Definitions.Def_<chapter>) so the `BookProof`
# lib dependency of the `Definitions` lean_lib is NOT dragged in.
#
# Usage: debug/compile_check.sh [LIST_FILE]
#   LIST_FILE defaults to debug/upstream_list.txt (publish order, deps first).
# Output: state/compile_check.log (append) and state/compile_failures.txt.
set -u
export PATH="/home/leo/.elan/bin:$PATH"
cd /home/leo/prove2me_workspace

LIST="${1:-debug/upstream_list.txt}"
LOG=state/compile_check.log
FAILTXT=state/compile_failures.txt
: > "$LOG"
: > "$FAILTXT"

FAIL=()
while read -r chap; do
  [ -z "$chap" ] && continue
  if out=$(lake build "Definitions.Def_${chap}" 2>&1); then
    echo "OK   $chap" | tee -a "$LOG"
  else
    echo "FAIL $chap" | tee -a "$LOG"
    echo "$out" | grep -E "error" | head -4 | sed 's/^/     /' >> "$LOG"
    FAIL+=("$chap")
    echo "$chap" >> "$FAILTXT"
  fi
done < "$LIST"

echo
echo "FAILURES: ${#FAIL[@]} (see $FAILTXT)"
