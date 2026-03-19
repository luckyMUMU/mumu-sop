# SOP Skills Marketplace

SOP (Standard Operating Procedure) Skills marketplace for software development workflow. Contains the mumu-sop plugin with 14 skills covering orchestration, specification, implementation, verification, and documentation.

## Installation

Add this marketplace to Claude Code:

```bash
claude plugin add luckyMUMU/mumu-sop
```

Or manually add to your settings:

```json
{
  "pluginMarketplaces": {
    "mumu-sop-marketplace": {
      "source": "github",
      "repo": "luckyMUMU/mumu-sop"
    }
  }
}
```

Then install the plugin:

```bash
claude plugin install mumu-sop
```

## Marketplace Structure

```
mumu-sop/
├── .claude-marketplace/
│   └── marketplace.json    # Marketplace metadata
└── plugins/
    └── mumu-sop/           # Single plugin
        ├── .claude-plugin/
        │   └── plugin.json
        ├── skills/         # 14 Skills
        └── _resources/     # Supporting resources
```

## Plugin: mumu-sop

### Skills Overview

#### Orchestration Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-workflow-orchestrator` | Default entry point, manages workflow state |
| `sop-document-sync` | Synchronizes documentation with code changes |
| `sop-progress-supervisor` | Monitors workflow progress |

#### Specification Skills (4)

| Skill | Description |
|-------|-------------|
| `sop-dual-cycle-decision` | Complex requirement pre-analysis with dual-loop decision |
| `sop-requirement-analyst` | Analyzes requirements and generates specifications |
| `sop-architecture-design` | Designs system architecture |
| `sop-implementation-designer` | Designs implementation details |

#### Implementation Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-code-explorer` | Explores and analyzes existing code |
| `sop-code-implementation` | Implements code based on specifications |
| `sop-test-implementation` | Implements tests based on specifications |

#### Verification Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-architecture-reviewer` | Reviews architecture design |
| `sop-code-review` | Reviews code implementation |
| `spring-code-reviewer` | Spring/Java architecture-level code review |

#### Documentation Skills (1)

| Skill | Description |
|-------|-------------|
| `sop-document-creator` | Creates technical documentation |

## Core Concepts

### 5-Stage Workflow

1. **Stage 0**: Intent Analysis & Constraint Identification
2. **Stage 1**: Hierarchical Design (P0→P1→P2→P3)
3. **Stage 2**: Execution Plan & Implementation (P3→P2→P1→P0)
4. **Stage 3**: Change Review & Confirmation
5. **Stage 4**: Archive & Constraint Tree Update

### Constraint Hierarchy

```
P0 (Engineering Constitution) - Cannot be violated
├── P1 (System Specifications) - Warnings acceptable
│   ├── P2 (Module Specifications) - Automated verification
│   │   └── P3 (Implementation Specifications) - IDE hints
```

### Key Principles

- **Design from root**: P0 → P1 → P2 → P3
- **Implement from leaves**: P3 → P2 → P1 → P0
- **Guardrail-first**: Check constraints after each level
- **Contract-based**: Use JSON/YAML contracts between stages

## Usage

These skills are model-invoked capabilities that Claude autonomously uses based on task context. Simply describe your development task, and Claude will invoke the appropriate skills.

Example prompts:
- "I need to implement a new feature for user authentication"
- "Review the architecture of my Spring application"
- "Create a specification document for the order management module"

## Resources

- [Skill Index](./plugins/mumu-sop/index.md)
- [Workflow Definition](./plugins/mumu-sop/_resources/workflow/index.md)
- [Constraint Definitions](./plugins/mumu-sop/_resources/constraints/index.md)
- [Architecture Principles](./plugins/mumu-sop/_resources/constitution/architecture-principles.md)

## Version

- Marketplace version: 1.0.0
- Plugin version: 1.0.0
- Skill format version: v5.0.0

## License

MIT