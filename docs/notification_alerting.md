# Notification & Alerting Flows

This document details the notification and alerting flows for ATIATO, including non-typical scenarios such as multi-channel escalation, alert suppression, and notification failure handling.

## Sequence Diagram: Notification Flow

```mermaid
sequenceDiagram
    participant System
    participant Notif as Notification Service
    participant Email
    participant SMS
    participant Webhook
    System->>Notif: Trigger Alert
    Notif->>Email: Send Email
    Notif->>SMS: Send SMS
    Notif->>Webhook: Send Webhook
    alt Email Failure
        Notif->>System: Email Failure Alert
    else SMS Failure
        Notif->>System: SMS Failure Alert
    else Webhook Failure
        Notif->>System: Webhook Failure Alert
    else All Success
        Notif-->>System: Notification Success
    end
```

## State Diagram: Notification Lifecycle

```mermaid
stateDiagram-v2
    [*] --> Pending
    Pending --> Sending: Send Notification
    Sending --> Sent: All Channels Success
    Sending --> Failed: Any Channel Failure
    Failed --> Retrying: Retry Policy
    Retrying --> Sent: Success
    Retrying --> Failed: Max Retries Exceeded
    Sent --> [*]
    Failed --> [*]
```

---
For more, see [System Architecture](architecture.md).
