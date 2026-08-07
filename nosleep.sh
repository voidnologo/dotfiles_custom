#!/bin/bash
# Toggle system sleep inhibitor on/off
# Screen will still turn off (DPMS), but suspend/sleep is blocked.

PIDFILE="/tmp/nosleep.pid"

case "${1:-status}" in
  on)
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo "Already running (PID $(cat "$PIDFILE"))"
    else
      systemd-inhibit --what=idle:sleep:handle-lid-switch \
        --who="nosleep" \
        --why="Keeping system awake" \
        --mode=block sleep infinity &
      echo $! > "$PIDFILE"
      echo "Sleep inhibited (PID $!)"
    fi
    ;;
  off)
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      kill "$(cat "$PIDFILE")"
      rm -f "$PIDFILE"
      echo "Sleep inhibitor removed"
    else
      rm -f "$PIDFILE"
      echo "Not running"
    fi
    ;;
  status)
    if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo "Active (PID $(cat "$PIDFILE"))"
    else
      rm -f "$PIDFILE" 2>/dev/null
      echo "Inactive"
    fi
    ;;
  *)
    echo "Usage: nosleep {on|off|status}"
    ;;
esac
