# Document Engineering — File Templates

Use these as the starting point when scaffolding a new function or product.

---

## Product/Reference.md

```markdown
# <ProductName>

## Brief

<One paragraph describing what this product does, who it's for, and its core value.>

## Global Docs

- [Product Overview](Overview.md) — feature map, user journey, feature relationships
- [Architecture](Architecture.md) — layers, module deps, data flow, key decisions
- [CHANGELOG](CHANGELOG.md) — unified changelog for all functions and product-level changes

## Function Index

| Function | Brief | PRD | Code | QA |
|----------|-------|-----|------|----|
| <FunctionName> | <Brief> | [PRD](Functions/<FunctionName>/PRD.md) | [Code](Functions/<FunctionName>/Code.md) | [QA](Functions/<FunctionName>/QA.md) |
```

---

## Product/Overview.md

```markdown
# <ProductName> — Product Overview

## Core Value

<One sentence: what problem this product solves and for whom.>

## User Journey

<Step-by-step narrative of the primary usage flow:>

1. Step one
2. Step two
3. ...

<!-- Diagram (optional): add a Flowchart TD or User Journey diagram if the flow has branching decisions -->

## Feature Map

<How functions relate to each other. Group by theme or dependency.>

### <Group Name>

- **FunctionA** — brief role
- **FunctionB** — brief role, depends on FunctionA

<!-- Diagram (optional): add a Flowchart LR if cross-function dependencies are complex -->

## Out of Scope

- <What this product deliberately does not do.>
```

---

## Product/Architecture.md

```markdown
# <ProductName> — Architecture

## Directory Structure

<Annotated tree of the key source directories:>

```
src/
├── <layerA>/   ← <responsibility>
├── <layerB>/   ← <responsibility>
└── <layerC>/   ← <responsibility>
```

## Layers

| Layer | Directory | Responsibility |
|-------|-----------|----------------|
| <LayerA> | src/<layerA>/ | <what it does> |
| <LayerB> | src/<layerB>/ | <what it does> |

## Data Model

<Key entities and their relationships:>

| Entity | Key Fields | Notes |
|--------|-----------|-------|
|        |           |       |

## Data Flow

<How data moves through the system for the primary use case:>

```
Input → <LayerA> → <LayerB> → Output
```

<!-- Diagram (optional): add a C4 Container or Flowchart LR if 3+ components interact -->

## Key Design Decisions

- <Why this framework/library/pattern was chosen>
- <Significant tradeoffs made>
```

---

## Product/Functions/<FunctionName>/PRD.md

```markdown
---
related_prd:
  # - ../OtherFunction/PRD.md
---

# <FunctionName> — PRD

## Purpose

<What problem does this function solve? Why does it exist?>

## Requirements

### Functional
- 

### Non-functional
- 

## User stories

- As a <user>, I want to <action> so that <outcome>.

<!-- Diagram (optional): add a Flowchart TD if the user flow has meaningful branching paths -->

## Out of scope

- 

## Open questions

- 
```

---

## Product/Functions/<FunctionName>/Code.md

```markdown
---
related_code:
  # - ../OtherFunction/Code.md
---

# <FunctionName> — Code

## Codebase Index

| File/Module | Role |
|-------------|------|
| | |

## Data Model

<Describe key data structures, types, schemas, or DB tables relevant to this function.>

<!-- Diagram (optional): add an ERD if 2+ entities have relationships -->

## State

<Describe how state is managed: local, global, persisted, ephemeral, etc.>

<!-- Diagram (optional): add a State Diagram if the entity has 3+ distinct lifecycle states -->

## Key decisions

<Architectural choices, tradeoffs, or gotchas a future maintainer should know.>

## External dependencies

<APIs, libraries, or services this function depends on.>
```

---

## Product/Functions/<FunctionName>/QA.md

```markdown
# <FunctionName> — QA Checklist

## Happy Path

- [ ] <Standard successful scenario>
- [ ] <Another expected success case>

## Edge Cases

- [ ] <Empty input / null>
- [ ] <Max/min boundary>
- [ ] <Concurrent access>
- [ ] <Failure/error recovery>

## Known issues

- 
```

---

## Product/CHANGELOG.md

```markdown
# <ProductName> — CHANGELOG

## [Unreleased]

## [Init] <YYYY-MM-DD>
- **<FunctionName>**: Initial scaffold
```

Entry format:

```
## [<Type>] YYYY-MM-DD
- **<FunctionName>**: description of what changed and why
- **Overview**: description (if product-level docs changed)
```

Types: `Init` / `Feature` / `Fix` / `Refactor` / `Break` / `Deprecate`
