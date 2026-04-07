# mumu-sop

**SOP (Standard Operating Procedure) Skills for Claude Code**

A comprehensive Claude Code plugin providing 20 skills for software development workflow, covering orchestration, specification, implementation, verification, maintenance, and documentation phases.

## Features

- **20 Skills**: 18 language-agnostic + 2 specialized (Spring & Browser testing)
- **6-Stage Workflow**: Define → Plan → Build → Verify → Review → Ship
- **Five-Axis Review**: Correctness, Readability, Architecture, Security, Performance
- **Constraint Hierarchy**: P0-P3 constraint tree with automatic validation
- **Multiple Entry Points**: Agent (`/sop`), Commands (`spec`, `plan`, etc.), or Direct Skills
- **Automation Hooks**: Automatic validation and updates at workflow stages
- **Cross-IDE Support**: Claude Code, Cursor, Windsurf, GitHub Copilot, Gemini CLI

## Installation

1. Clone or download this repository
2. Copy the `plugins/mumu-sop` directory to your Claude Code plugins folder
3. Enable the plugin in your Claude Code settings

## Quick Start

```
User: sop
```

The `sop-agent` will analyze your request and guide you through the workflow.

## Skills Overview

| Category | Skills |
|----------|--------|
| Orchestration | workflow-orchestrator, document-sync, progress-supervisor |
| Specification | dual-cycle-decision, requirement-analyst, architecture-design, implementation-designer |
| Implementation | code-explorer, code-implementation, test-implementation |
| Verification | architecture-reviewer, code-review, spring-code-reviewer (Java/Spring) |
| Maintenance | bug-analysis, code-refactor, tech-debt-manager, dependency-manager |
| Documentation | document-creator |

## Core Principles

### Design from Root
```
P0 (工程宪章) → P1 (系统规范) → P2 (模块规范) → P3 (实现规范) → 临时节点
```

### Implementation from Leaves
```
临时节点 → P3 → P2 → P1 → P0
```

### Dynamic Depth

| Complexity | Depth | Layers |
|------------|-------|--------|
| Low | 2 | P0 → P1 → temp |
| Medium | 3 | P0 → P1 → P2 → temp |
| High | 4 | P0 → P1 → P2 → P3 → temp |

## Documentation

- [Skill Index](./index.md) - Complete skill documentation
- [Workflow](./_resources/workflow/index.md) - 5-stage workflow details
- [Constraints](./_resources/constraints/index.md) - P0-P3 constraint definitions
- [Templates](./_resources/templates/index.md) - Document templates
- [Hooks](./hooks/index.md) - Automation hooks

## License

MIT License - See [LICENSE](./LICENSE) for details.

## Author

luckyMUMU

## Repository

[https://github.com/luckyMUMU/mumu-sop](https://github.com/luckyMUMU/mumu-sop)