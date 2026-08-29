FROM nvidia/cuda:12.6.0-base-ubuntu22.04

# Install stress-ng for CPU/RAM and gpu-burn for GPU testing
RUN apt-get update && apt-get install -y \
    stress-ng \
    cuda-toolkit-12-6 \
    git \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Build gpu-burn utility
WORKDIR /opt
RUN git clone https://github.com && \
    cd gpu-burn && \
    make

# Create entrypoint script to handle environment variables
RUN echo '#!/bin/bash\n\
STRESS_ARGS=""\n\
if [ -n "$CPU" ]; then STRESS_ARGS="$STRESS_ARGS --cpu $CPU"; fi\n\
if [ -n "$RAM_WORKERS" ] && [ -n "$RAM_BYTES" ]; then STRESS_ARGS="$STRESS_ARGS --vm $RAM_WORKERS --vm-bytes $RAM_BYTES"; fi\n\
if [ -n "$TIME" ]; then STRESS_ARGS="$STRESS_ARGS --timeout $TIME"; fi\n\
\n\
if [ -n "$GPU_TIME" ]; then\n\
    echo "Starting GPU burn for $GPU_TIME seconds..."\n\
    /opt/gpu-burn/gpu_burn $GPU_TIME &\n\
fi\n\
\n\
if [ -n "$STRESS_ARGS" ]; then\n\
    echo "Starting CPU/RAM stress with args: $STRESS_ARGS"\n\
    stress-ng $STRESS_ARGS\n\
fi\n\
wait' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
