# Banking API Integration Flows

This document details recommended integration flows and state diagrams for connecting ATIATO to external banking APIs (e.g., Open Banking, SWIFT, SEPA, card networks).

## Table of Contents

- [Overview](#overview)
- [Open Banking API Flow](#open-banking-api-flow)
- [SWIFT Network Integration](#swift-network-integration)
- [SEPA Payment Flow](#sepa-payment-flow)
- [Card Network (ISO 8583) Flow](#card-network-iso-8583-flow)
- [State Diagrams](#state-diagrams)

## Overview

ATIATO supports modular integration with a variety of banking APIs and networks. Each integration can be implemented as a Logic App connector, Python SDK module, or external microservice.

## Open Banking API Flow

```mermaid
sequenceDiagram
    participant Client
    participant ATIATO
    participant BankAPI as OpenBankingAPI
    Client->>ATIATO: Initiate Payment (REST)
    ATIATO->>BankAPI: POST /payments (OAuth2)
    BankAPI-->>ATIATO: Payment Status/Result
    ATIATO-->>Client: Confirmation/Status
```

## SWIFT Network Integration

```mermaid
sequenceDiagram
    participant ATIATO
    participant SWIFT as SWIFT Gateway
    ATIATO->>SWIFT: Send MT 103/202 (FIN)
    SWIFT-->>ATIATO: Delivery Notification
    SWIFT-->>ATIATO: Status Update
```

## SEPA Payment Flow

```mermaid
sequenceDiagram
    participant Client
    participant ATIATO
    participant SEPA as SEPA Gateway
    Client->>ATIATO: Initiate SEPA Credit Transfer
    ATIATO->>SEPA: pain.001 (XML)
    SEPA-->>ATIATO: pain.002 (Status)
    ATIATO-->>Client: Confirmation/Status
```

## Card Network (ISO 8583) Flow

```mermaid
sequenceDiagram
    participant POS
    participant ATIATO
    participant CardNet as Card Network
    POS->>ATIATO: Card Transaction (ISO 8583)
    ATIATO->>CardNet: Forward ISO 8583
    CardNet-->>ATIATO: Auth Response
    ATIATO-->>POS: Approval/Decline
```

## State Diagrams

### Payment Lifecycle State Diagram

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
```

### Message Processing State Diagram

```mermaid
stateDiagram-v2
    [*] --> Received
    Received --> Parsed: Parse Message
    Parsed --> Validated: Business Validation
    Validated --> Routed: Route to Destination
    Routed --> Delivered: Delivery Success
    Delivered --> [*]
    Validated --> Error: Validation Error
    Error --> [*]
```

---
For more, see [System Architecture](architecture.md) and [README](../README.md).
