#!/bin/bash

echo "[INFO] Starting miner..."

# load config
source ./config.sh

# detect CPU
THREADS=$(nproc)

echo "[INFO] CPU threads: $THREADS"
echo "[INFO] Worker: $WORKER"

# tải xmrig nếu chưa có
if [ ! -f "xmrig" ]; then
    echo "[INFO] Downloading xmrig..."
    wget -q https://github.com/xmrig/xmrig/releases/latest/download/xmrig-6.22.0-linux-x64.tar.gz
    tar -xvf xmrig-*.tar.gz >/dev/null 2>&1
    mv xmrig-*/xmrig .
    rm -rf xmrig-*
fi

# chạy miner
./xmrig \
  -o $POOL \
  -u $WALLET \
  -k \
  --threads=$THREADS \
  --cpu-max-threads-hint=$CPU_LIMIT \
  --randomx-1gb-pages
