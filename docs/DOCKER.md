# Docker & Local Development for ATIATO

This project supports local development and testing using Docker Compose.

## Quick Start

1. Build and start all containers:
   ```sh
   ./scripts/dev_env.sh
   ```
2. Stop all containers:
   ```sh
   ./scripts/stop_env.sh
   ```
3. Clean up all containers, volumes, and images:
   ```sh
   ./scripts/cleanup.sh
   ```

## docker-compose.yml Overview

- **app**: Main application container (Python, SDKs, Logic App client, etc.)
- **sqlserver**: Microsoft SQL Server 2019 for local database

### Environment Variables
- `SQL_SERVER`, `SQL_DATABASE`, `SQL_USER`, `SQL_PASSWORD`: For DB connection
- `KEY_VAULT_URL`, `LOGIC_APP_URL`: For Azure integrations

## Useful Scripts

- `scripts/dev_env.sh`: Build, start, and initialize everything
- `scripts/compose_logs.sh`: View logs
- `scripts/compose_exec.sh`: Run a command in the app container
- `scripts/compose_build.sh`: Build containers
- `scripts/compose_restart.sh`: Restart containers
- `scripts/compose_down.sh`: Remove all containers and volumes

## Notes
- The default SQL Server password is for local dev only. Change for production.
- You can extend the `docker-compose.yml` to add more services (e.g., Redis, RabbitMQ, etc.) as needed.

---
See the main [README.md](../README.md) and [docs/README.md](./README.md) for full project and infrastructure documentation.
