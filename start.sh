#!/bin/bash

echo "[INFO] Starting miner..."

THREADS=$(nproc)
WORKER="devbox-rig"

echo "[INFO] CPU threads: $THREADS"
echo "[INFO] Worker: $WORKER"

# Download xmrig nếu chưa có
if [ ! -f "xmrig" ]; then
    echo "[INFO] Downloading xmrig..."

    URL=$(wget -qO- https://api.github.com/repos/xmrig/xmrig/releases/latest \
    | grep browser_download_url \
    | grep linux-static-x64.tar.gz \
    | cut -d '"' -f 4)

    wget "$URL" -O xmrig.tar.gz

    tar -xvf xmrig.tar.gz
    mv xmrig-*/xmrig .
    chmod +x xmrig
fi

# Run miner (NO hugepage, NO msr, NO 1GB page)
./xmrig \
-o pool.supportxmr.com:3333 \
-u WALLET_CUA_BAN \
-k \
-t $THREADS \
--cpu-affinity=$((THREADS-1)) \
--huge-pages=0 \
--randomx-1gb-pages=0 \
--donate-level=1
