# Automation Scripts for ATIATO Translation System

This directory contains scripts to automate common tasks:

- `deploy_infra.sh` — Deploy Azure infrastructure using azd
- `init_db.sh` — Initialize all database schemas
- `load_reference_data.sh` — Load ICC rules and currency codes into the database
- `run_logicapp_workflow.sh` — Trigger a Logic App workflow with a sample payload
- `test_api.sh` — Test the deployed translation API endpoint

## Usage

Make scripts executable:

```sh
chmod +x scripts/*.sh
```

Run a script:

```sh
./scripts/deploy_infra.sh
```

Set required environment variables as needed (see comments in each script).
