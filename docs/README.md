# ATIATO Translation System Documentation

Welcome to the comprehensive documentation for the ATIATO Translation System. This documentation covers architecture, setup, business logic, API integration, automation, and developer guidance for the entire codebase.

- [Project Overview](#project-overview)
- [Architecture](#architecture)
- [Setup & Deployment](#setup--deployment)
- [Modules & Integrations](#modules--integrations)
- [Database Schemas](#database-schemas)
- [Business Logic & Workflows](#business-logic--workflows)
- [API & Banking Integrations](#api--banking-integrations)
- [Automation Scripts](#automation-scripts)
- [Docker & Local Development](#docker--local-development)
- [References & Further Reading](#references--further-reading)

---

## Project Overview

ATIATO is a secure, scalable, and compliant translation system for financial messaging, supporting point-to-point and point-to-multi-point flows. It leverages Azure Logic Apps, Azure SQL, Key Vault, and integrates with both blockchain (Alchemy) and open banking (Barclays) APIs.

See the main [README.md](../README.md) for a quick start and high-level summary.

---

## Architecture

- Azure-native: Logic Apps, App Service, SQL, Key Vault, Application Insights, Log Analytics
- Modular Python SDKs for all integrations
- Message translation, validation, and routing logic
- End-to-end automation with scripts and Docker Compose


See [WORKFLOWS.md](./WORKFLOWS.md) for diagrams and sequence flows.

## Standards, Regulations, and Guidance

- [Standards & Regulations Index](standards/README.md)

For each new standard, regulation, or guidance, see the template in the standards directory.

---

## Setup & Deployment

1. **Clone the repository**
2. **Edit parameters** in `infra/main.parameters.json`
3. **Authenticate**: `az login` and `azd auth login`
4. **Deploy**: `azd up` or use scripts in `scripts/`
5. **Initialize DB**: `./scripts/init_db.sh`
6. **Load reference data**: `./scripts/load_reference_data.sh`

See [README.md](../README.md) for details.

---

## Modules & Integrations

- `modules/azure_sql.py`: Azure SQL DB connection
- `modules/key_vault.py`: Azure Key Vault secrets
- `modules/logic_app_client.py`: Logic App triggers
- `modules/alchemy_client.py`: Blockchain (Ethereum) via Alchemy
- `modules/barclays_open_banking.py`: Barclays Open Banking API
- `modules/iso20022_parser.py`, `swift_mt_parser.py`, `iso8583_parser.py`: Message parsing

See [modules/README.md](../modules/README.md) for usage examples.

---

## Database Schemas

- `schemas/gru_balances.sql`, `exchange_rates.sql`: Balances & rates
- `schemas/currency_registry.sql`: ISO 4217 registry
- `schemas/icc_rules_reference.sql`: ICC rules
- `schemas/iso_20022_mapping.sql`, `swift_mt_mapping.sql`, `iso_8583_mapping.sql`: Message mapping
- `schemas/json_meta_schema_payment.json`: Payment/settlement metadata schema

---

## Business Logic & Workflows

- Logic App workflows in `logic-apps/translation/`
- End-to-end orchestration: ingest, parse, enrich, validate, route, execute, store, log
- See [WORKFLOWS.md](./WORKFLOWS.md) for diagrams and business logic

---

## API & Banking Integrations

- **Alchemy**: Blockchain balance and transaction API ([alchemy_client.py](../modules/alchemy_client.py))
- **Barclays**: OAuth2, account info, payment initiation ([barclays_open_banking.py](../modules/barclays_open_banking.py))
- **Custom API**: `/api/translate` endpoint for message translation

---

## Automation Scripts

Scripts in `scripts/` automate:
- Infrastructure deployment
- Database initialization
- Reference data loading
- Logic App workflow deployment/testing
- API endpoint testing
- Docker Compose management

See [scripts/README.md](../scripts/README.md) for usage.

---

## Docker & Local Development

- `docker-compose.yml` for local dev: brings up app and SQL Server
- Scripts for build, start, stop, logs, cleanup
- See [README.md](../README.md) for Docker usage

---

## References & Further Reading

- [Main README.md](../README.md)
- [WORKFLOWS.md](./WORKFLOWS.md)
- [Azure Logic Apps](https://learn.microsoft.com/azure/logic-apps/)
- [Azure Bicep](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Alchemy API](https://docs.alchemy.com/)
- [Barclays Open Banking](https://developer.barclays.com/)
