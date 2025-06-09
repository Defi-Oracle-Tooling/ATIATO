#!/bin/bash
# Show logs for all containers
set -e

docker-compose logs -f
