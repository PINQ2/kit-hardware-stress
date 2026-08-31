#!/bin/sh

# Create output directories in writable /tmp location
mkdir -p /tmp/outputs /tmp/logs
chmod 755 /tmp/outputs /tmp/logs


STRESS_ARGS=""
if [ -n "$CPU" ]; then STRESS_ARGS="$STRESS_ARGS --cpu $CPU"; fi
if [ -n "$RAM_WORKERS" ] && [ -n "$RAM_BYTES" ]; then STRESS_ARGS="$STRESS_ARGS --vm $RAM_WORKERS --vm-bytes $RAM_BYTES"; fi
if [ -n "$TIME" ]; then STRESS_ARGS="$STRESS_ARGS --timeout $TIME"; fi

if [ -n "$STRESS_ARGS" ]; then
    echo "Starting CPU/RAM stress with args: $STRESS_ARGS"
    stress-ng $STRESS_ARGS
fi


exec "$@"
