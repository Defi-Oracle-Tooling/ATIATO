#!/bin/bash
# Initialize all database schemas for ATIATO translation system
set -e

# Example: Set these variables or export them before running
# export SQL_SERVER=your_server.database.windows.net
# export SQL_DATABASE=your_db
# export SQL_USER=your_user
# export SQL_PASSWORD=your_password

for schema in schemas/*.sql; do
  echo "Applying $schema..."
  /opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER" -d "$SQL_DATABASE" -U "$SQL_USER" -P "$SQL_PASSWORD" -i "$schema"
done
