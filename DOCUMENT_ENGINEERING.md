# Document Engineering

## Structure

- Product/
    - Reference.md
        - Brief
        - Function Index (point to Functions/FunctionName)
    - Functions/
        - FunctionName/
            - PRD.md
                - metadata (Related Prd.md Index, ...)
                - PRD
            - Code.md
                - metadata (Related Code.md Index, ...)
                - Code
                    - Code Base Index
                    - Data
                    - State
                    - ...
            - QA.md
                - Checklist
                    - Happy Path
                    - Edge Cases
            - CHANGELOG.md

## Maintanence

### AI 受控 — 让 AI 自觉维护

把文档更新写进 Definition of Done 在 CLAUDE.md 里加规则：

`每次修改/新增/删除功能后，必须根据 Document Engineering 的要求，维护 Documents Structure`

### AI 不受控时 — 自动检测漂移

1. Git pre-commit hook. 如果改了代码，却没有更新 Documents，需要提示，但不要直接阻断退出。
2. 定期 audit. 根据 git log, 找到 Documents 更新时间 以及 未同步到 Documents 的提交记录，做同步动作。