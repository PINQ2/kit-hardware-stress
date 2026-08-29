# kit-hardware-stress
a kit to run on AHP to consume various resources

CPU: Number of CPU cores to stress (e.g., 4 or 0 for all cores).
RAM_WORKERS: Number of memory allocation threads (e.g., 2).
RAM_BYTES: Size of RAM per worker to consume (e.g., 2G or 80%).
GPU_TIME: Duration in seconds to run the GPU matrix calculation stress test.
TIME: Duration for the CPU/RAM stress test (e.g., 60s, 2m).

Run with environment variables:You must pass the --gpus all flag so Docker can access your host GPU.

docker run --rm --gpus all \
  -e CPU="4" \
  -e RAM_WORKERS="2" \
  -e RAM_BYTES="2G" \
  -e GPU_TIME="60" \
  -e TIME="60s" \
  hardware-stress-test
