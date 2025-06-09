#!/bin/bash
# Stop and remove all containers, networks, and volumes
set -e

docker-compose down -v
