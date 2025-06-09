# Batch Processing & Reconciliation

This document details the batch file ingestion, reconciliation, and reporting flows for ATIATO, including non-typical scenarios such as partial reconciliation, duplicate batch detection, and exception reporting.

## Flowchart: Batch Processing

```mermaid
flowchart TD
    A[Batch File Received] --> B[Validate File Format]
    B --> C{Valid?}
    C -- No --> D[Reject Batch & Notify]
    C -- Yes --> E[Parse Records]
    E --> F[Ingest Records to Staging]
    F --> G[Reconcile with Ledger]
    G --> H{Fully Reconciled?}
    H -- Yes --> I[Mark Batch Complete]
    H -- No --> J[Partial Reconciliation]
    J --> K[Generate Exception Report]
    K --> L[Notify Operations]
    F --> M{Duplicate Batch?}
    M -- Yes --> N[Reject & Alert]
    M -- No --> G
```

## State Diagram: Batch Lifecycle

```mermaid
stateDiagram-v2
    [*] --> Received
    Received --> Validated: Validate Format
    Validated --> Ingested: Ingest Records
    Ingested --> Reconciled: Reconcile with Ledger
    Reconciled --> Completed: Fully Reconciled
    Reconciled --> Partial: Partial Reconciliation
    Partial --> Exception: Exception Reported
    Exception --> Completed: Resolved
    Exception --> [*]
    Completed --> [*]
    Ingested --> Duplicate: Duplicate Detected
    Duplicate --> [*]
```

---
For more, see [System Architecture](architecture.md).
