# SOP Skills Marketplace

SOP (Standard Operating Procedure) Skills marketplace for software development workflow. Contains two plugins: **mumu-sop** with 18 skills covering orchestration, specification, implementation, verification, maintenance, and documentation, and **mumu-model-router** for multi-model agent configuration.

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

Then install the plugins:

```bash
# Install SOP workflow plugin
claude plugin install mumu-sop

# Install model routing plugin
claude plugin install mumu-model-router
```

## Marketplace Structure

```
mumu-sop/
├── .claude-plugin/
│   └── marketplace.json    # Marketplace metadata
└── plugins/
    ├── mumu-sop/           # SOP workflow plugin
    │   ├── .claude-plugin/
    │   │   └── plugin.json
    │   ├── skills/         # 18 Skills
    │   ├── agents/         # Entry agent
    │   └── _resources/     # Supporting resources
    └── mumu-model-router/  # Model routing plugin
        ├── .claude-plugin/
        │   └── plugin.json
        ├── agents/         # 4 Pre-configured agents
        └── _resources/     # Configuration templates
```

## Plugin: mumu-sop

### Skills Overview (18 Skills)

#### Orchestration Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-orchestrator` | Default entry point, manages workflow state |
| `sop-sync` | Synchronizes documentation with code changes |
| `sop-progress-supervisor` | Monitors workflow progress |

#### Specification Skills (4)

| Skill | Description |
|-------|-------------|
| `sop-decision-analyst` | Complex requirement pre-analysis with decision paths |
| `sop-requirement-analyst` | Analyzes requirements and generates specifications |
| `sop-architecture-designer` | Designs system architecture |
| `sop-implementation-designer` | Designs implementation details |

#### Implementation Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-code-explorer` | Explores and analyzes existing code |
| `sop-code-implementer` | Implements code based on specifications |
| `sop-test-implementer` | Implements tests based on specifications |

#### Verification Skills (3)

| Skill | Description |
|-------|-------------|
| `sop-architecture-reviewer` | Reviews architecture design |
| `sop-code-reviewer` | Reviews code implementation |
| `sop-spring-reviewer` | Spring/Java architecture-level code review (Java/Spring only) |

#### Maintenance Skills (4)

| Skill | Description |
|-------|-------------|
| `sop-bug-analyst` | Bug analysis and root cause identification |
| `sop-code-refactorer` | Safe code refactoring |
| `sop-tech-debt-manager` | Technical debt management |
| `sop-dependency-manager` | Dependency upgrade management |

#### Documentation Skills (1)

| Skill | Description |
|-------|-------------|
| `sop-document-writer` | Creates technical documentation and user guides |

## Plugin: mumu-model-router

Model routing plugin that allows different agents to use different AI models and API endpoints.

### Pre-configured Agents (4)

| Agent | Model | Use Case |
|-------|-------|----------|
| `fast-responder` | claude-haiku-4-5 | Simple queries, format conversion |
| `code-implementer-router` | claude-sonnet-4-6 | Code implementation, regular tasks |
| `architect-decider` | claude-opus-4-6 | Architecture decisions, complex analysis |
| `batch-processor` | gpt-4o-mini | Batch processing, simple repetitive tasks |

### Features

- **Model Routing**: Different agents use different models
- **API Endpoint Configuration**: Custom API base URLs
- **Cost Optimization**: Simple tasks use cheaper models
- **Fallback Support**: Define backup models for reliability

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

- [mumu-sop Skill Index](./plugins/mumu-sop/index.md)
- [mumu-model-router Documentation](./plugins/mumu-model-router/index.md)
- [Workflow Definition](./plugins/mumu-sop/_resources/workflow/index.md)
- [Constraint Definitions](./plugins/mumu-sop/_resources/constraints/index.md)
- [Architecture Principles](./plugins/mumu-sop/_resources/constitution/architecture-principles.md)

## Version

- Marketplace version: 1.4.0
- mumu-sop version: 2.0.0
- mumu-model-router version: 1.0.0

## License

MIT