#!/usr/bin/env bash
set -euo pipefail

EXPECTED_HOST="${1:-}"
EXPECTED_IP="${2:-}"

if [[ -z "$EXPECTED_HOST" || -z "$EXPECTED_IP" ]]; then
  echo "Usage: $0 EXPECTED_HOSTNAME EXPECTED_PRIVATE_IP"
  echo "Example: $0 ewb-app-a 10.10.2.10"
  exit 2
fi

echo "=== Host identity ==="
hostname
echo
echo "=== IPv4 addresses ==="
hostname -I
echo
echo "=== Expected identity ==="
echo "Expected hostname label: $EXPECTED_HOST"
echo "Expected private IPv4:   $EXPECTED_IP"

if hostname -I | tr ' ' '\\n' | grep -Fxq "$EXPECTED_IP"; then
  echo "PASS: expected private IPv4 is present on this host."
else
  echo "WARN: expected IP was not found. Verify the EC2 private IP and interface configuration."
  exit 1
fi
