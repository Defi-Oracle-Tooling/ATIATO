# ATIATO Modules: SDKs, Connections, and Banking API Integration

This directory contains reusable modules for connecting to Azure services, blockchain APIs (Alchemy), and Open Banking APIs (Barclays, etc.), as well as business logic for financial message translation and orchestration.

## Contents

- `azure_sql.py`: Azure SQL Database connection and query logic
- `key_vault.py`: Azure Key Vault secret management
- `logic_app_client.py`: Trigger and interact with Azure Logic Apps
- `iso20022_parser.py`, `swift_mt_parser.py`, `iso8583_parser.py`: Message parsing and translation logic
- `alchemy_client.py`: Blockchain (Ethereum) API integration via Alchemy
- `barclays_open_banking.py`: Barclays Open Banking API integration (OAuth2, payments, account info)

## Example: Azure SQL Query

```python
from modules.azure_sql import get_connection
conn = get_connection()
cursor = conn.cursor()
cursor.execute('SELECT * FROM gru_balances')
for row in cursor.fetchall():
    print(row)
```

## Example: Fetch Secret from Azure Key Vault

```python
from modules.key_vault import get_secret
api_key = get_secret('EXCHANGE_RATE_API_KEY')
```

## Example: Trigger Logic App Workflow

```python
from modules.logic_app_client import trigger_workflow
result = trigger_workflow({"messageType": "ISO20022", "payload": {}})
```

## Example: Parse Financial Messages

```python
from modules.iso20022_parser import parse_iso20022
parsed = parse_iso20022(xml_payload)
```

## Barclays Open Banking API Integration

- Implements OAuth2 client credentials flow
- Endpoints for account info, payment initiation, and transaction history
- Example (Python):

```python
import requests, os
BARCLAYS_TOKEN_URL = os.getenv('BARCLAYS_TOKEN_URL')
BARCLAYS_CLIENT_ID = os.getenv('BARCLAYS_CLIENT_ID')
BARCLAYS_CLIENT_SECRET = os.getenv('BARCLAYS_CLIENT_SECRET')
def get_barclays_token():
    resp = requests.post(BARCLAYS_TOKEN_URL, data={
        'grant_type': 'client_credentials',
        'client_id': BARCLAYS_CLIENT_ID,
        'client_secret': BARCLAYS_CLIENT_SECRET
    })
    return resp.json()['access_token']
```

## Alchemy Blockchain API Integration

- Connects to Ethereum and other EVM chains for on-chain data
- Example (Python):

```python
import requests, os
ALCHEMY_URL = f"https://eth-mainnet.g.alchemy.com/v2/{os.getenv('ALCHEMY_API_KEY')}"
def get_eth_balance(address):
    resp = requests.post(ALCHEMY_URL, json={
        "jsonrpc": "2.0", "id": 1, "method": "eth_getBalance", "params": [address, "latest"]
    })
    return int(resp.json()['result'], 16) / 1e18
```

## Business Logic: Message Routing & Orchestration

- Use message type and metadata to route between blockchain and banking rails
- Validate and enrich messages using ICC rules, currency registry, and exchange rates
- Store all transaction metadata in Azure SQL and log to Application Insights

## References

- [Azure SDK for Python](https://learn.microsoft.com/python/api/overview/azure/)
- [Alchemy API Docs](https://docs.alchemy.com/reference/ethereum-apis)
- [Barclays Open Banking API](https://developer.barclays.com/)
- [UK Open Banking Standard](https://www.openbanking.org.uk/)

---
For new integrations, add your SDK or connection logic as a new module in this directory and update this documentation accordingly.
