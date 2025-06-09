# Payment Exception Handling Flow

This document details the exception and error handling flows for payment processing in ATIATO, including non-typical scenarios such as network partition, duplicate detection, and regulatory holds.

## Sequence Diagram: Exception Handling

```mermaid
sequenceDiagram
    participant Client
    participant API as Translation API
    participant LogicApp
    participant SQL as Azure SQL
    participant Vault as Key Vault
    participant Notif as Notification Service
    Client->>API: POST /api/translate
    API->>LogicApp: Trigger workflow
    LogicApp->>SQL: Store/Fetch data
    alt Validation Error
        LogicApp-->>API: 400 Bad Request
        API-->>Client: Error Response
    else Duplicate Transaction
        LogicApp-->>API: 409 Conflict
        API-->>Client: Duplicate Detected
    else Network Timeout
        LogicApp-->>API: 504 Gateway Timeout
        API-->>Client: Timeout
        API->>Notif: Send Alert
    else Regulatory Hold
        LogicApp-->>API: 202 Accepted (Pending)
        API->>Notif: Notify Compliance
    end
```

## State Diagram: Payment Exception States

```mermaid
stateDiagram-v2
    [*] --> Initiated
    Initiated --> Validated: Validate Input
    Validated --> Authorized: Authorize Payment
    Authorized --> Settled: Settle Funds
    Settled --> [*]
    Validated --> Rejected: Validation Failed
    Authorized --> Rejected: Authorization Failed
    Rejected --> [*]
    Authorized --> OnHold: Regulatory Hold
    OnHold --> Released: Compliance Cleared
    Released --> Settled
    OnHold --> Rejected: Compliance Rejected
    Authorized --> Timeout: Network Timeout
    Timeout --> [*]
    Initiated --> Duplicate: Duplicate Detected
    Duplicate --> [*]
```

---
For more, see [System Architecture](architecture.md).
