#!/bin/bash
# DEV-589: Redis ACL Audit Script
# Usage: ./redis-acl-audit.sh [host] [port]

HOST=${1:-127.0.0.1}
PORT=${2:-6379}
RC="redis-cli -h $HOST -p $PORT"

echo "=== Redis ACL Audit — $(date) ==="
echo "Target: $HOST:$PORT"
echo

echo "--- Version ---"
$RC INFO server | grep redis_version

echo "--- Current User ---"
$RC ACL WHOAMI

echo "--- Default User Permissions ---"
$RC ACL GETUSER default

echo "--- All ACL Users ---"
$RC ACL LIST

echo "--- Global Password Status ---"
$RC CONFIG GET requirepass

echo "--- Network Bindings ---"
$RC CONFIG GET bind
$RC CONFIG GET protected-mode
$RC CONFIG GET port

echo "--- Recent ACL Security Events ---"
$RC ACL LOG

echo "--- Dangerous Command Category ---"
$RC ACL CAT dangerous

echo "=== Audit Complete ==="
