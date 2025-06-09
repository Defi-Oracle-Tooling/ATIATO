#!/bin/bash
# Execute a command in the app container
set -e

if [ $# -eq 0 ]; then
  echo "Usage: $0 <command>"
  exit 1
fi

docker-compose exec app "$@"
