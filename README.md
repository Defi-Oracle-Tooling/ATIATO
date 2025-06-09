# Translation System: ATIATO

This repository implements a secure, scalable, and compliant translation system for financial messaging, supporting both point-to-point and point-to-multi-point flows. It leverages Azure Logic Apps, Azure SQL Databases, Azure Key Vault, and other Azure resources for orchestration, data storage, and security.

## Features

- **Translation flows**: Point-to-point and point-to-multi-point translation for financial messages.
- **Database schemas**: For GRU M0/M1 balances, exchange rates, and ISO 4217 currency registry.
- **Compliance**: Supports ICC rules (UCP 600, URDTT), ISO 20022, SWIFT FIN MT, ISO 8583, and JSON-Meta schema for payment/settlement metadata.
- **Azure-native**: Uses Azure Logic Apps, App Service, SQL Database, Key Vault, Application Insights, and Log Analytics.
- **Security**: Managed identities, Key Vault for secrets, least-privilege access, and monitoring enabled.

## Repository Structure

- `infra/` — Bicep and parameter files for Azure infrastructure as code (IaC)
- `logic-apps/translation/` — Logic App workflows and related code
- `azure.yaml` — Azure Developer CLI configuration
- `prompts_used.md` — Project requirements and design prompts

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- [Azure Developer CLI (azd)](https://learn.microsoft.com/azure/developer/azure-developer-cli/install-azd)
- Azure subscription with sufficient permissions

## Setup & Deployment

1. **Clone the repository**

   ```sh
   git clone <this-repo-url>
   cd ATIATO
   ```

2. **Review and update parameters**
   - Edit `infra/main.parameters.json`:
     - Set `environmentName` and `location` as needed.
     - Fill in `AZURE_STORAGE_CONNECTION_STRING`, `EXCHANGE_RATE_API_KEY`, and `sqlAdminPassword` (secure value for SQL admin).
3. **Authenticate with Azure**

   ```sh
   az login
   azd auth login
   ```

4. **Deploy infrastructure**

   ```sh
   azd up
   ```

   This will provision all required Azure resources as defined in `infra/main.bicep`.

## Project Components

### Azure Resources Deployed

- **Azure App Service**: Hosts custom APIs and integrates with Logic Apps
- **Azure Logic Apps**: Orchestrates translation and routing flows
- **Azure SQL Databases**: Stores balances, exchange rates, and currency registry
- **Azure Key Vault**: Manages secrets and connection strings
- **Application Insights**: Monitoring and diagnostics
- **Log Analytics Workspace**: Centralized logging

### Database Schemas

- **GRU M0/M1 balances**: For account and monetary tracking
- **Exchange rates**: Multi-currency and historical rates
- **ISO 4217 currency registry**: Currency codes, names, and minor units

### Message & Compliance Support

- **ICC rules**: UCP 600, URDTT
- **ISO 20022**: pain.001, pacs.008, etc.
- **SWIFT FIN MT**: MT 103, MT 202
- **ISO 8583**: Card-based transactions (if needed)
- **JSON-Meta schema**: For payment/settlement metadata

## Security & Best Practices

- All secrets are managed in Azure Key Vault
- Managed identities for secure resource access
- Monitoring via Application Insights and Log Analytics
- SQL firewall rules are set to the most restrictive by default
- No credentials are hardcoded; use Key Vault for all secrets

## Development & Customization

- Implement Logic App workflows in `logic-apps/translation/`
- Extend or modify Bicep files in `infra/` for additional Azure resources
- Update `azure.yaml` to reflect new services or dependencies

## Troubleshooting

- Ensure all required Azure tools are installed (`az`, `azd`)
- Check deployment logs for errors during `azd up`
- Validate parameter values in `main.parameters.json`
- Use Azure Portal for resource diagnostics and monitoring

## Next Steps

- Implement database schemas and seed reference data
- Build and deploy Logic Apps workflows
- Integrate APIs and message mapping logic
- Test end-to-end translation flows

## References

- [Azure Logic Apps Documentation](https://learn.microsoft.com/azure/logic-apps/)
- [Azure Bicep Documentation](https://learn.microsoft.com/azure/azure-resource-manager/bicep/)
- [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/)

---
For questions or support, please open an issue in this repository.
