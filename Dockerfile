FROM ubuntu:24.04

# Install stress-ng for CPU/RAM and gpu-burn for GPU testing
RUN apt-get update && apt-get install -y \
    stress-ng \
    && rm -rf /var/lib/apt/lists/*

COPY . .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
