# Document Engineering — File Templates

Use these as the starting point when scaffolding a new function or product.

---

## Product/Reference.md

```markdown
# <ProductName>

## Brief

<One paragraph describing what this product does, who it's for, and its core value.>

## Function Index

| Function | PRD | Code | QA | CHANGELOG |
|----------|-----|------|----|-----------|
| <FunctionName> | [PRD](Functions/<FunctionName>/PRD.md) | [Code](Functions/<FunctionName>/Code.md) | [QA](Functions/<FunctionName>/QA.md) | [CHANGELOG](Functions/<FunctionName>/CHANGELOG.md) |
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

## State

<Describe how state is managed: local, global, persisted, ephemeral, etc.>

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

## Product/Functions/<FunctionName>/CHANGELOG.md

```markdown
# <FunctionName> — CHANGELOG

## [Unreleased]

## [Init] <YYYY-MM-DD>
- Initial scaffold
```
