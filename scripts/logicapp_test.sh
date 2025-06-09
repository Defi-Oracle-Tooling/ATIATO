#!/bin/bash
# Test Logic App workflow endpoint
set -e

if [ -z "$LOGIC_APP_URL" ]; then
  echo "Please set LOGIC_APP_URL environment variable."
  exit 1
fi

curl -X POST "$LOGIC_APP_URL" \
  -H "Content-Type: application/json" \
  -d '{"messageType": "ISO20022", "payload": {"sample": true}}'
