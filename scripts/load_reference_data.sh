#!/bin/bash
# Load reference data (e.g., ICC rules, currency codes) into the database
set -e

# Example: Set these variables or export them before running
# export SQL_SERVER=your_server.database.windows.net
# export SQL_DATABASE=your_db
# export SQL_USER=your_user
# export SQL_PASSWORD=your_password

/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER" -d "$SQL_DATABASE" -U "$SQL_USER" -P "$SQL_PASSWORD" -i schemas/icc_rules_reference.sql
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER" -d "$SQL_DATABASE" -U "$SQL_USER" -P "$SQL_PASSWORD" -i schemas/currency_registry.sql
