# CLAUDE.md — Document Engineering Rule

Add the following block to the project's `CLAUDE.md` (create it at repo root if it doesn't exist):

---

```markdown
## Definition of Done — Document Engineering

Every time you modify, add, or delete a feature or function, you MUST update the corresponding
documents in `Product/Functions/<FunctionName>/` before considering the task complete.

### Required updates per change type

| Change type        | PRD.md | Code.md | QA.md | CHANGELOG.md |
|--------------------|--------|---------|-------|--------------|
| New feature        | ✅ Create | ✅ Create | ✅ Create | ✅ Create |
| Behavior change    | ✅ Update | ✅ Update | ✅ Review | ✅ Add entry |
| Refactor (no behavior change) | — | ✅ Update | — | ✅ Add entry |
| Bug fix            | — | maybe | ✅ Add case | ✅ Add entry |
| Delete feature     | ✅ Archive | ✅ Archive | ✅ Archive | ✅ Add entry |

### CHANGELOG entry format

```
## [Type] YYYY-MM-DD
- Description of what changed and why
```

Types: `Init` / `Feature` / `Fix` / `Refactor` / `Break` / `Deprecate`

### Reference.md

If a new function was added or removed, update the Function Index table in `Product/Reference.md`.

### Never skip this

Doc updates are not optional. If you are unsure which doc to update, err on the side of updating
all four files. A stale doc is worse than a slightly over-updated one.
```
