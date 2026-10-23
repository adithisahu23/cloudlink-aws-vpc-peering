#!/usr/bin/env bash
set -euo pipefail

PEER_IP="${1:-}"

if [[ -z "$PEER_IP" ]]; then
  echo "Usage: $0 PEER_PRIVATE_IP"
  echo "From App-A: $0 10.20.1.10"
  echo "From App-B: $0 10.10.2.10"
  exit 2
fi

echo "=== Source host ==="
hostname
hostname -I
echo
echo "=== Ping target: $PEER_IP ==="
date -Is
ping -c 4 "$PEER_IP"
echo
echo "=== Test finished ==="
date -Is
