# Document Engineering

## Structure

- Product/
    - Reference.md — Product brief + Function Index
    - Overview.md — User journey, feature relationships, cross-function groupings
    - Architecture.md — Global codebase view: layers, module deps, data flow, key decisions
    - CHANGELOG.md — Single unified changelog for all functions and product-level changes
    - Functions/
        - FunctionName/
            - PRD.md — metadata + Product Requirements
            - Code.md — metadata + Codebase index, data model, state, architecture notes
            - QA.md — Checklist: happy path + edge cases
        - _deprecated/ — Deleted function folders moved here

## Maintenance

### AI 受控 — 让 AI 自觉维护

把文档更新写进 Definition of Done，在 CLAUDE.md 里加规则：

`每次修改/新增/删除功能后，必须根据 Document Engineering 的要求，维护 Documents Structure`

### AI 不受控时 — 自动检测漂移

1. Git pre-commit hook. 如果改了代码，却没有更新 Documents，需要提示，但不要直接阻断退出。
2. 定期 audit. 根据 git log，找到 Documents 更新时间以及未同步到 Documents 的提交记录，做同步动作。