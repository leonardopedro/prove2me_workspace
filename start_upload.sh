#!/usr/bin/env bash
# Resilient background launcher for the prove2me upload pipeline.
# Survives shell closures, terminal disconnects, and SIGHUP.
#
# Usage:
#   ./start_upload.sh          # start (or restart)
#   ./start_upload.sh stop     # stop
#   ./start_upload.sh status   # status
#   ./start_upload.sh restart  # stop + start

# Workspace root: PROVE2ME_WS override, else the directory holding this script.
WS="${PROVE2ME_WS:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)}"
LOG="${WS}/state/upload.log"
mkdir -p "$(dirname "$LOG")"

PIPELINE="python3 ${WS}/pipeline/upload_pipeline.py"
export PROVE2ME_WS="${WS}"
PIDFILE="/tmp/upload_pipeline.pid"

start() {
    # Stop any existing instance first
    stop 2>/dev/null
    sleep 1

    # Crash-loop wrapper: the pipeline exits 1 while work remains (and 0 when
    # done); restart it every time it exits non-zero, with a short backoff, so
    # the upload survives process crashes, API hiccups, and restarts.  setsid +
    # nohup + disown detach it from the calling shell/session entirely, so it
    # survives shell logout, terminal disconnect, SIGHUP, and tool-run
    # cleanup that kills process groups.
    setsid nohup bash -c "cd ${WS} && while true; do ${PIPELINE} >> ${LOG} 2>&1; rc=\$?; echo \"[$(date +%F\ %T)] pipeline exited rc=\$rc\" >> ${LOG}; [ \$rc -eq 0 ] && break; sleep 20; done" \
        < /dev/null > /dev/null 2>&1 &
    disown
    sleep 2
    if [ -f "$PIDFILE" ]; then
        echo "Upload pipeline started (PID $(cat "$PIDFILE")). Log: ${LOG}"
    else
        # Try to detect PID
        local pid
        pid=$(pgrep -f "upload_pipeline.py" 2>/dev/null | head -1)
        if [ -n "$pid" ]; then
            echo "$pid" > "$PIDFILE"
            echo "Upload pipeline started (PID $pid). Log: ${LOG}"
        else
            echo "Upload pipeline started. Log: ${LOG}"
        fi
    fi
}

stop() {
    # Kill the recorded wrapper PID first (graceful), then sweep every
    # uploader process (wrapper AND python) so an orphaned child can never
    # keep submitting while a fresh instance starts.
    if [ -f "$PIDFILE" ]; then
        local pid
        pid=$(cat "$PIDFILE")
        if kill -0 "$pid" 2>/dev/null; then
            kill "$pid" 2>/dev/null
            for i in 1 2 3 4 5; do
                if kill -0 "$pid" 2>/dev/null; then
                    sleep 1
                else
                    break
                fi
            done
            kill -9 "$pid" 2>/dev/null
        fi
        rm -f "$PIDFILE"
    fi
    # Sweep leftovers: kill ONLY the real uploader processes (the python
    # pipeline and the crash-loop wrapper).  The pattern includes the full
    # python3 invocation so shells that merely *grep/pgrep* for the pipeline
    # name are never matched and killed.
    pkill -f "python3 ${WS}/pipeline/upload_pipeline.py" 2>/dev/null
    sleep 1
    echo "Upload pipeline stopped."
}

status() {
    if [ -f "$PIDFILE" ]; then
        local pid
        pid=$(cat "$PIDFILE")
        if kill -0 "$pid" 2>/dev/null; then
            echo "Running (PID $pid)."
            echo "  Log tail:"
            tail -5 "$LOG" 2>/dev/null || echo "    (no log yet)"
        else
            echo "Not running (stale PID file)."
            rm -f "$PIDFILE"
        fi
    else
        local pid
        pid=$(pgrep -f "upload_pipeline.py" 2>/dev/null | head -1)
        if [ -n "$pid" ]; then
            echo "Running (PID $pid, no PID file)."
            echo "  Log tail:"
            tail -5 "$LOG" 2>/dev/null || echo "    (no log yet)"
        else
            echo "Not running."
        fi
    fi
}

case "${1:-start}" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        stop
        sleep 1
        start
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
        ;;
esac

exit 0
