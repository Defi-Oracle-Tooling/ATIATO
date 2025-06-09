# Workflow & Architecture Overview

This document provides workflow diagrams, usage examples, and API documentation for the ATIATO Translation System.

## System Architecture

```mermaid
flowchart TD
    A[Inbound Message] --> B(Logic App: Ingest & Validate)
    B --> C{Message Type?}
    C -- ISO 20022 --> D[Transform: ISO 20022]
    C -- SWIFT MT --> E[Transform: SWIFT MT]
    C -- ISO 8583 --> F[Transform: ISO 8583]
    D & E & F --> G[Enrich/Validate: ICC Rules, Currency, Rates]
    G --> H[Route: Point-to-Point or Multi-Point]
    H --> I[Outbound Message(s)]
    G --> J[Store Metadata/Settlement]
    J -->|SQL| K[(Azure SQL DB)]
    G -->|Key Vault| L[(Azure Key Vault)]
    G -->|Log| M[(App Insights/Log Analytics)]
```

## Usage Example: Deploy & Run

1. Deploy infrastructure (see main README):

   ```sh
   azd up
   ```

2. Add/modify Logic App workflows in `logic-apps/translation/`.
3. Use Azure Portal or Logic Apps Designer to configure triggers and actions.

## API Example: Custom Translation Endpoint

Suppose you deploy a custom API to App Service for advanced translation:

- **Endpoint:** `POST /api/translate`
- **Request Body:**

  ```json
  {
    "messageType": "ISO20022",
    "payload": { /* ... */ },
    "target": ["SWIFT_MT", "ISO_8583"]
  }
  ```

- **Response:**

  ```json
  {
    "results": [
      { "type": "SWIFT_MT", "payload": "..." },
      { "type": "ISO_8583", "payload": "..." }
    ],
    "status": "success"
  }
  ```

## Customization Guidance

- Add new message types by extending Logic App workflows and transformation logic.
- Update Bicep files in `infra/` to provision additional Azure resources.
- Use Key Vault for all new secrets and connection strings.
- Document new endpoints and workflows in this file.

---
For further customization, add diagrams, sequence flows, or additional API examples as needed.
