#!/bin/bash
# Test the deployed API endpoint for translation
set -e

if [ -z "$API_URL" ]; then
  echo "Please set API_URL environment variable."
  exit 1
fi

curl -X POST "$API_URL/api/translate" \
  -H "Content-Type: application/json" \
  -d '{"messageType": "ISO20022", "payload": {"sample": true}, "target": ["SWIFT_MT", "ISO_8583"]}'
