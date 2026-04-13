# CLAUDE.md — Document Engineering Rule

Add the following block to the project's `CLAUDE.md` (create it at repo root if it doesn't exist):

---

```markdown
## Definition of Done — Document Engineering

Every time you modify, add, or delete a feature or function, you MUST update the corresponding
documents in `Product/Functions/<FunctionName>/` before considering the task complete.

### Required updates per change type

| Change type        | PRD.md | Code.md | QA.md |
|--------------------|--------|---------|-------|
| New feature        | ✅ Create | ✅ Create | ✅ Create |
| Behavior change    | ✅ Update | ✅ Update | ✅ Review |
| Refactor (no behavior change) | — | ✅ Update | — |
| Bug fix            | — | maybe | ✅ Add case |
| Delete feature     | ✅ Archive | ✅ Archive | ✅ Archive |

Always add an entry to `Product/CHANGELOG.md` for every change.

### CHANGELOG entry format

```
## [Type] YYYY-MM-DD
- **<FunctionName>**: description of what changed and why
```

Types: `Init` / `Feature` / `Fix` / `Refactor` / `Break` / `Deprecate`

### Reference.md

If a new function was added or removed, update the Function Index table in `Product/Reference.md`.

### Overview.md and Architecture.md

- If the change affects cross-function user flows or feature relationships, update `Product/Overview.md`.
- If the change affects overall architecture, module boundaries, data flow, or global design decisions, update `Product/Architecture.md`.

### Never skip this

Doc updates are not optional. If you are unsure which doc to update, err on the side of updating
all files. `Product/CHANGELOG.md` must always be updated. A stale doc is worse than a slightly over-updated one.
```
