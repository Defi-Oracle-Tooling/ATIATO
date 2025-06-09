# ATIATO Project Prompts & Implementation Plan

## Inputs & Outputs

- Database schema for GRU M0/M1 balances & exchange‐rate tables
- ICC rules: UCP 600 (Documentary Credits), URDTT (Documentary Transferable Titles)
- ISO 4217 currency code registry
- ISO 20022 message definitions (pain.001, pacs.008, etc.)
- SWIFT FIN MT formats (MT 103, MT 202)
- ISO 8583 spec for card‐based transactions (if needed)
- JSON-Meta schema guidelines for payment/settlement metadata

## Technical Master Plan

**Solution Architecture:**

- Azure Logic Apps for orchestration (point-to-point and point-to-multi-point)
- Azure SQL Databases for balances, exchange rates, currency registry
- Azure Key Vault for secrets
- Azure App Service for custom APIs/logic
- Application Insights & Log Analytics for monitoring
- Azure Blob Storage for large payloads (optional)
- Managed identities and least-privilege access

**Azure Resources:**

- Logic Apps, App Service, SQL DBs, Key Vault, App Insights, Log Analytics, Blob Storage

**Implementation Steps:**

1. Infrastructure as Code (Bicep, parameters, azure.yaml)
2. Database schemas & reference data
3. Logic Apps workflows (ingest, transform, validate, route)
4. Message mapping & validation (ISO 20022, SWIFT MT, ISO 8583, JSON-Meta)
5. Security & monitoring
6. Testing & deployment

**Project Milestones:**

- Weeks 1-2: Infra setup & deployment
- Week 3: Database schemas & data
- Weeks 4-5: Logic Apps & mapping logic
- Week 6: Security, monitoring, logging
- Week 7: Testing & docs
- Week 8: Go-live

---

All infrastructure, schemas, modules, and workflows are implemented and validated. For further customization or troubleshooting, see the main documentation and workflow files.
