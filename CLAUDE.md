# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Code plugin marketplace containing two plugins:

1. **mumu-sop** (v2.2.0): 20 SOP (Standard Operating Procedure) skills for software development workflow
2. **mumu-model-router** (v1.2.0): Multi-model agent configuration with support for Chinese LLM providers

## Key Architecture

### 6-Stage Workflow

The mumu-sop plugin implements a 6-stage development workflow:

| Stage | Command | Purpose |
|-------|---------|---------|
| 0 | `spec` | Define - Specification creation |
| 1 | `plan` | Plan - Task breakdown with vertical slicing |
| 2 | `build` | Build - Incremental implementation |
| 3 | `test` | Verify - Testing and validation |
| 4 | `review` | Review - Five-axis code review |
| 5 | `ship` | Ship - Release and archive |

**Entry Points**:
- `/sop` - Agent-guided workflow (analyzes complexity, guides through stages)
- Direct commands: `spec`, `plan`, `build`, `test`, `review`, `ship`
- Individual skills - Triggered by keywords (see plugin.json)

### Constraint Hierarchy (P0-P3)

```
P0 (Engineering Constitution) - Immutable, violation causes immediate failure
├── P1 (System Specifications) - Warnings acceptable
│   ├── P2 (Module Specifications) - Automated verification
│   │   └── P3 (Implementation Specifications) - IDE hints
```

**Principle**: Design from root (P0→P1→P2→P3), implement from leaves (P3→P2→P1→P0)

### Five-Axis Review

All verification skills use five review dimensions:
1. **Correctness** - Does it work as specified (P2)
2. **Readability** - Is it understandable (P3)
3. **Architecture** - Does it match design (P2/P0)
4. **Security** - Does it introduce vulnerabilities (P0)
5. **Performance** - Are there performance issues (P1)

## Project Structure

### mumu-sop Plugin

```
plugins/mumu-sop/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest (entry points, skill categories)
├── .claude/commands/        # 6-stage workflow commands (spec.md, plan.md, etc.)
├── skills/                   # 20 skills, each in a directory with SKILL.md
│   ├── sop-orchestrator/
│   │   └── SKILL.md         # Required: YAML frontmatter + markdown content
│   └── ...
├── agents/
│   └── sop-agent/           # Entry agent (AGENT.md, SYSTEM_PROMPT.md)
├── commands/
│   └── init-spec-tree.md    # Additional commands
├── hooks/
│   ├── pre-apply-hook.sh    # Stage 2 pre-implementation validation
│   └── post-archive-hook.sh # Stage 5 post-ship updates
├── _resources/
│   ├── constitution/         # P0 architecture principles
│   ├── constraints/          # P0-P3 constraint definitions
│   ├── workflow/             # 6-stage workflow documentation
│   ├── contracts/            # Stage contracts (stage-0-contract.yaml, etc.)
│   ├── templates/            # Constraint & report templates
│   ├── references/           # Five-axis review, etc.
│   └── examples/             # Example temp node files
├── tests/                    # Per-skill test documentation
│   └── {skill-name}/
│       ├── triggers.md       # Trigger test cases
│       └── functional.md     # Functional test cases
└── index.md                  # Skill index ( Chinese )
```

### mumu-model-router Plugin

```
plugins/mumu-model-router/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── agents/                   # 4 pre-configured agents
│   ├── fast-responder.md    # claude-haiku-4-5 for simple queries
│   ├── code-implementer-router.md  # claude-sonnet-4-6 for implementation
│   ├── architect-decider.md        # claude-opus-4-6 for architecture
│   └── batch-processor.md          # gpt-4o-mini for batch tasks
├── _resources/
│   └── config/
│       ├── model-routing.yaml      # Complexity-based routing rules
│       └── api-endpoints.yaml      # Provider endpoint configuration
└── commands/
    └── sync-models.md       # Sync model configuration
```

## Skill Categories (20 Skills)

| Category | Count | Skills |
|----------|-------|--------|
| Orchestration | 3 | `sop-orchestrator`, `sop-sync`, `sop-progress-supervisor` |
| Specification | 4 | `sop-decision-analyst`, `sop-requirement-analyst`, `sop-architecture-designer`, `sop-implementation-designer` |
| Implementation | 3 | `sop-code-explorer`, `sop-code-implementer`, `sop-test-implementer` |
| Verification | 5 | `sop-architecture-reviewer`, `sop-code-reviewer`, `sop-performance-reviewer`, `sop-browser-testing`, `sop-spring-reviewer` |
| Maintenance | 4 | `sop-bug-analyst`, `sop-code-refactorer`, `sop-tech-debt-manager`, `sop-dependency-manager` |
| Documentation | 1 | `sop-document-writer` |

**Note**: `sop-spring-reviewer` (Java/Spring) and `sop-browser-testing` (JavaScript/TypeScript frontend) are language-specific; all others are language-agnostic.

## Development Commands

### Plugin Development

This is a documentation/skill-based plugin (no build step required):

```bash
# Validate plugin.json syntax
cat plugins/mumu-sop/.claude-plugin/plugin.json | python3 -m json.tool > /dev/null && echo "Valid JSON"

# Count skills
ls -d plugins/mumu-sop/skills/*/ | wc -l

# Find skills missing tests
for skill in plugins/mumu-sop/skills/*/; do
  name=$(basename "$skill")
  [ ! -d "plugins/mumu-sop/tests/$name" ] && echo "Missing tests: $name"
done

# Reload plugins in Claude Code (if needed)
/reload-plugins
```

### Adding a New Skill

1. Create directory: `plugins/mumu-sop/skills/your-skill-name/`
2. Create `SKILL.md` with YAML frontmatter (required: `name`, `description`)
3. Add references in `references/` subdirectory if needed
4. Register in `plugin.json` under `skills.language_agnostic` or `skills.language_specific`
5. Create tests in `tests/your-skill-name/` (triggers.md and functional.md)
6. Update `plugins/mumu-sop/index.md` skill index

### Skill File Requirements (SKILL.md)

```yaml
---
name: your-skill-name          # Must match directory name, kebab-case
version: 1.0.0
description: |
  What the skill does.
  触发词: keyword1, keyword2, keyword3.  # Include Chinese trigger words
license: MIT
compatibility: "Language-agnostic or specific languages"
metadata:
  author: luckyMUMU
  category: orchestration|specification|implementation|verification|maintenance|documentation
  tags: [tag1, tag2]
  language_agnostic: true|false
---

# Skill content...
```

**Key Constraints**:
- File must be named `SKILL.md` (case-sensitive)
- Skill name must be kebab-case
- Description must include "what it does" and "when to use it"
- No XML tags in descriptions (reserved for system use)
- Avoid reserved prefixes: `claude-`, `anthropic-`

## Testing

Tests are **manual/documentation-based**, not automated:

| Test Type | File | Purpose |
|-----------|------|---------|
| Trigger tests | `tests/{skill}/triggers.md` | Verify skill triggers on correct keywords |
| Functional tests | `tests/{skill}/functional.md` | Verify skill produces correct outputs |

**Test Coverage Targets**:
- Trigger accuracy: ≥ 90%
- Functional test pass rate: 100%
- Boundary case coverage: ≥ 80%

## Automation Hooks

Hooks are shell scripts triggered at workflow stages:

| Hook | Trigger | Actions |
|------|---------|---------|
| `pre-apply-hook.sh` | Stage 2 (Build) start | verify-temp-node, guardrail-check, complexity-confirmation, dependency-subtree-check |
| `post-archive-hook.sh` | Stage 5 (Ship) complete | spec-tree-update, reference-cleanup, changelog-update, constraint-validation |

## Important Files

| Purpose | File |
|---------|------|
| Marketplace manifest | `.claude-plugin/marketplace.json` |
| mumu-sop plugin manifest | `plugins/mumu-sop/.claude-plugin/plugin.json` |
| mumu-model-router plugin manifest | `plugins/mumu-model-router/.claude-plugin/plugin.json` |
| Skill index | `plugins/mumu-sop/index.md` |
| Workflow definition | `plugins/mumu-sop/_resources/workflow/index.md` |
| Constraint hierarchy | `plugins/mumu-sop/_resources/constraints/index.md` |
| Architecture principles (P0) | `plugins/mumu-sop/_resources/constitution/architecture-principles.md` |
| Five-axis review reference | `plugins/mumu-sop/_resources/references/five-axis-review.md` |
| Development guide | `docs/skill-development-guide.md` |
| Test index | `plugins/mumu-sop/tests/index.md` |

## Temporary Node Pattern

Implementation tasks create temporary nodes stored independently:

```
.sop/specs/{change-id}/          # Primary storage
.trae/specs/{change-id}/          # Compatible storage
├── spec.md        # Task specification
├── tasks.md       # Task list
└── checklist.md   # Verification checklist
```

Temporary nodes reference P3 constraints but are archived after completion.

## Contract-Based Design

Stages communicate via contracts in `_resources/contracts/`:
- `stage-0-contract.yaml` through `stage-5-contract.yaml`
- Contracts define preconditions, logic context, and postconditions
- No shared state between stages - only contract files

## Model Routing Integration

When both plugins are installed, mumu-sop stages can be routed to different models:

| Stage | Capability | Recommended Model |
|-------|------------|-------------------|
| spec, plan, review | high | claude-opus-4-6, glm-5 |
| build, test | medium | claude-sonnet-4-6, kimi-k2.5 |
| ship | low | claude-haiku-4-5, qwen3-coder-next |

Supported providers: Moonshot, SiliconFlow, Zhipu, Alibaba, Anthropic, OpenAI
