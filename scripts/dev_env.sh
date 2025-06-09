#!/bin/bash
# Set up local development environment using Docker Compose
set -e

docker-compose up -d

echo "Waiting for SQL Server to be ready..."
sleep 20

./scripts/init_db.sh
./scripts/load_reference_data.sh
