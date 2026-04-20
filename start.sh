#!/bin/bash

source config.sh

echo "[INFO] Starting miner..."
echo "[INFO] Wallet: $WALLET"
echo "[INFO] Pool: $POOL"
echo "[INFO] Worker: $WORKER"

THREADS=$(nproc)
echo "[INFO] CPU threads: $THREADS"

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
    rm -f xmrig.tar.gz
fi

./xmrig \
  -o $POOL \
  -u $WALLET \
  -p $WORKER \
  -k \
  -t $THREADS \
  --huge-pages=0 \
  --randomx-1gb-pages=0 \
  --donate-level=1
