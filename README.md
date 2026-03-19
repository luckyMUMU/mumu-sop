# SOP Skills Plugin

SOP (Standard Operating Procedure) Skills for software development workflow. Includes 14 skills covering orchestration, specification, implementation, verification, and documentation.

## Installation

Copy this plugin to your Claude Code plugins directory:

```
cp -r . ~/.claude/plugins/local/sop-skills/
```

Or add to your project's `.claude/plugins/` directory.

## Structure

```
sop-skills/
├── .claude-plugin/
│   └── plugin.json        # Plugin metadata
├── skills/                 # 14 Skills
│   ├── sop-workflow-orchestrator/
│   ├── sop-document-sync/
│   ├── sop-progress-supervisor/
│   ├── sop-dual-cycle-decision/
│   ├── sop-requirement-analyst/
│   ├── sop-architecture-design/
│   ├── sop-implementation-designer/
│   ├── sop-code-explorer/
│   ├── sop-code-implementation/
│   ├── sop-test-implementation/
│   ├── sop-architecture-reviewer/
│   ├── sop-code-review/
│   ├── sop-document-creator/
│   └── spring-code-reviewer/
├── _resources/             # Supporting resources
│   ├── constitution/       # P0 engineering constitution
│   ├── constraints/        # P0-P3 constraint definitions
│   ├── workflow/           # 5-stage workflow definitions
│   ├── templates/          # Document and report templates
│   └── specifications/     # P1-P2 specification templates
└── index.md               # Skill index
```

## Skills Overview

### Orchestration Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-workflow-orchestrator` | Default entry point, manages workflow state |
| `sop-document-sync` | Synchronizes documentation with code changes |
| `sop-progress-supervisor` | Monitors workflow progress |

### Specification Skills (4)

| Skill | Description |
|-------|-------------|
| `sop-dual-cycle-decision` | Complex requirement pre-analysis with dual-loop decision |
| `sop-requirement-analyst` | Analyzes requirements and generates specifications |
| `sop-architecture-design` | Designs system architecture |
| `sop-implementation-designer` | Designs implementation details |

### Implementation Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-code-explorer` | Explores and analyzes existing code |
| `sop-code-implementation` | Implements code based on specifications |
| `sop-test-implementation` | Implements tests based on BDD scenarios |

### Verification Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-architecture-reviewer` | Reviews architecture design |
| `sop-code-review` | Reviews code implementation |
| `spring-code-reviewer` | Spring/Java architecture-level code review |

### Documentation Skills (1)

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

- [Skill Index](./index.md)
- [Workflow Definition](./_resources/workflow/index.md)
- [Constraint Definitions](./_resources/constraints/index.md)
- [Architecture Principles](./_resources/constitution/architecture-principles.md)

## Version

- Plugin version: 1.0.0
- Skill format version: v5.0.0

## License

MIT