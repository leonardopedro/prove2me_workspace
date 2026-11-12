#!/bin/bash
# Wait for any running regate_bundles to exit, then run the given regate
# command.  The wrapper's own cmdline is "bash debug/regate_chain.sh ..." so
# the pgrep pattern below cannot match itself.
cd "$(dirname "$0")/.." || exit 1
while pgrep -f 'regate_bundles\.py' >/dev/null 2>&1; do sleep 20; done
exec "$@"
