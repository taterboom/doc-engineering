# Mermaid Quick Reference

For more details: https://mermaid.ai/open-source/intro

## Diagram Type Selection

| Content | Diagram Type |
|---------|-------------|
| Process with decisions | `flowchart` |
| API / service interactions | `sequenceDiagram` |
| Database / entity relationships | `erDiagram` |
| System architecture | `C4Context` / `C4Container` / `C4Component` |
| Object relationships | `classDiagram` |
| State machines / lifecycle | `stateDiagram-v2` |
| User experience flow | `journey` |

---

## Flowchart

```mermaid
flowchart TD
    A([Start]) --> B[/Input/]
    B --> C{Valid?}
    C -->|Yes| D[Process]
    C -->|No| E[Show Error]
    E --> B
    D --> F[(Save to DB)]
    F --> G([End])
```

**Node shapes:**

| Shape | Syntax | Use for |
|-------|--------|---------|
| Rectangle | `[Text]` | Process step |
| Rounded | `([Text])` | Start / End |
| Diamond | `{Text}` | Decision |
| Parallelogram | `[/Text/]` | Input / Output |
| Cylinder | `[(Text)]` | Database / Storage |
| Circle | `((Text))` | Connector |

**Direction:** `TD` (top→down) · `LR` (left→right) · `BT` · `RL`

**Subgraph grouping:**
```mermaid
flowchart LR
    subgraph Frontend
        A[UI] --> B[Form]
    end
    subgraph Backend
        C[API] --> D[(DB)]
    end
    B --> C
```

---

## Sequence Diagram

```mermaid
sequenceDiagram
    actor User
    participant Frontend
    participant API
    participant DB

    User->>Frontend: Submit form
    Frontend->>API: POST /resource
    API->>DB: INSERT
    DB-->>API: ok
    API-->>Frontend: 201 Created
    Frontend-->>User: Show success

    alt Error case
        API-->>Frontend: 400 Bad Request
        Frontend-->>User: Show error
    end
```

**Participant types:** `actor` · `participant` · `boundary` · `control` · `entity` · `database` · `collections` · `queue`

**Arrow types:**

| Arrow | Syntax | Meaning |
|-------|--------|---------|
| Solid with arrowhead | `->>` | Message (most common) |
| Dotted with arrowhead | `-->>` | Return / response |
| Solid, no arrowhead | `->` | Message (no tip) |
| Dotted, no arrowhead | `-->` | Return (no tip) |
| Solid with cross | `-x` | Fire-and-forget |
| Dotted with cross | `--x` | Fire-and-forget response |
| Solid open arrow | `-)` | Async (open tip) |
| Dotted open arrow | `--)` | Async response (open tip) |

**Control blocks:** `alt / else / end` · `loop ... end` · `opt ... end` · `par ... and ... end`

---

## ERD

```mermaid
erDiagram
    USER ||--o{ ORDER : places
    ORDER }o--|| PRODUCT : contains

    USER {
        uuid id PK
        string email UK
        string name
        timestamp created_at
    }
    ORDER {
        uuid id PK
        uuid user_id FK
        enum status
        decimal total
    }
    PRODUCT {
        uuid id PK
        string name
        decimal price
    }
```

**Cardinality:**

| Symbol | Meaning |
|--------|---------|
| `\|\|` | Exactly one |
| `o\|` | Zero or one |
| `}o` | Zero or more |
| `}\|` | One or more |

Combine left + right sides: `USER \|\|--o{ ORDER` = one user to zero-or-more orders

---

## State Diagram

```mermaid
stateDiagram-v2
    [*] --> Pending : created

    Pending --> Active : payment confirmed
    Pending --> Cancelled : payment failed

    Active --> Completed : fulfilled
    Active --> Cancelled : user cancelled

    Completed --> [*]
    Cancelled --> [*]

    note right of Active
        Owner notified
        Stock reserved
    end note
```

- `[*]` = initial / terminal state
- `note right of <State>` for annotations
- Use `state "Label" as Alias` for long names

---

## C4 Diagrams

**Context** — system in its environment:
```mermaid
C4Context
    Person(user, "User", "End user")
    System(app, "My App", "Core platform")
    System_Ext(payment, "Stripe", "Payment processor")
    Rel(user, app, "Uses", "HTTPS")
    Rel(app, payment, "Charges via", "API")
```

**Container** — applications and data stores:
```mermaid
C4Container
    Person(user, "User")
    Container(web, "Web App", "React", "UI")
    Container(api, "API", "Node/Hono", "Business logic")
    ContainerDb(db, "Database", "Postgres", "Persistent data")
    Rel(user, web, "Uses", "HTTPS")
    Rel(web, api, "Calls", "JSON/HTTPS")
    Rel(api, db, "Reads/Writes", "SQL")
```

**Component** — internal structure of one container:
```mermaid
C4Component
    Container(api, "API")
    Component(routes, "Routes", "Hono Router", "HTTP endpoints")
    Component(services, "Services", "Business logic")
    Component(models, "Models", "Data access")
    Rel(routes, services, "Calls")
    Rel(services, models, "Uses")
```

---

## Styling

**Custom theme:**
```mermaid
%%{init: {'theme':'base', 'themeVariables': {
  'primaryColor':'#3B82F6',
  'primaryTextColor':'#fff',
  'primaryBorderColor':'#2563EB',
  'lineColor':'#6B7280'
}}}%%
flowchart TD
    A[Start] --> B[End]
```

**Per-node class styling:**
```mermaid
flowchart TD
    A[Success] --> B[Error]
    classDef success fill:#10B981,stroke:#059669,color:#fff
    classDef error fill:#EF4444,stroke:#DC2626,color:#fff
    class A success
    class B error
```

---

## Key Rules

- Keep under **~20 nodes** — split into multiple diagrams if larger
- Use subgraphs to group related nodes in complex flowcharts
- Diagrams go inline in markdown as ```` ```mermaid ```` blocks — never as images
- Keep diagram source in version control alongside the code it describes
- Test rendering in the target platform (GitHub, Notion, VS Code, etc.)
