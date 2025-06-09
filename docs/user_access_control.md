# User and Role Access Control

This document describes the authentication, authorization, and audit logging flows for ATIATO, including non-typical scenarios such as delegated access, session hijack detection, and role escalation.

## Flowchart: User Access Control

```mermaid
flowchart TD
    A[User Login] --> B{Authentication}
    B -- Success --> C[Session Created]
    B -- Failure --> D[Access Denied]
    C --> E{Role Check}
    E -- Admin --> F[Admin Dashboard]
    E -- Operator --> G[Operator Console]
    E -- Auditor --> H[Audit Logs]
    F --> I[Perform Admin Actions]
    G --> J[Perform Operations]
    H --> K[View Only]
    C --> L{Delegated Access?}
    L -- Yes --> M[Assume Delegated Role]
    M --> E
    L -- No --> E
    C --> N{Session Hijack Detected?}
    N -- Yes --> O[Force Logout & Alert]
    N -- No --> E
    F --> P{Role Escalation Request}
    P -- Approved --> Q[Escalate Role]
    Q --> E
    P -- Denied --> F
```

## State Diagram: Session Lifecycle

```mermaid
stateDiagram-v2
    [*] --> LoggedOut
    LoggedOut --> LoggingIn: User Login
    LoggingIn --> Authenticated: Credentials Valid
    LoggingIn --> LoggedOut: Credentials Invalid
    Authenticated --> ActiveSession: Session Created
    ActiveSession --> LoggedOut: Logout
    ActiveSession --> Suspended: Session Hijack Detected
    Suspended --> LoggedOut: Force Logout
    ActiveSession --> Escalated: Role Escalation
    Escalated --> ActiveSession: Escalation Ended
```

---
For more, see [System Architecture](architecture.md).
