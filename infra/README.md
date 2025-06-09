# Translation System Azure Infrastructure

This folder contains Bicep and parameter files for deploying the translation system using Azure Developer CLI (azd).

## Resources Deployed

- Azure App Service (for Logic App integration)
- Azure SQL Databases (exchange-rate-db, currency-registry-db)
- Azure Key Vault
- Application Insights
- Log Analytics Workspace

## Deployment Steps

1. Review and update `main.parameters.json` with your environment values and secrets.
2. Run `azd up` from the project root to deploy all resources.
3. Use Key Vault to securely store and retrieve secrets for your application.

## Security & Best Practices

- All secrets are managed in Azure Key Vault.
- Managed identities are used for secure resource access.
- Monitoring is enabled via Application Insights and Log Analytics.
- SQL firewall rules are set to the most restrictive by default.

## Integration Points

- Database schemas for balances, exchange rates, currency registry, and message mapping are in `../schemas/`.
- Python modules for Azure SQL, Key Vault, Logic App, and message parsing are in `../modules/`.
- Logic App workflow templates are in `../logic-apps/translation/`.

## Next Steps

- Implement and test Logic App workflows for message orchestration.
- Integrate Python modules with Azure resources and Logic Apps.
- Extend schemas and modules as needed for new message types or business rules.
