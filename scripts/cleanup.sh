#!/bin/bash
# Clean up all generated containers, volumes, and images
set -e

docker-compose down -v --rmi all
