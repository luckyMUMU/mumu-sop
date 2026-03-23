# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Code plugin marketplace containing the **mumu-sop** plugin. The plugin provides 14 SOP (Standard Operating Procedure) skills for software development workflow, covering orchestration, specification, implementation, verification, and documentation phases.

## Key Architecture

### 5-Stage Workflow

The plugin implements a 5-stage development workflow:
1. **Stage 0**: Intent Analysis & Constraint Identification
2. **Stage 1**: Hierarchical Design (P0→P1→P2→P3)
3. **Stage 2**: Execution Plan & Implementation (P3→P2→P1→P0)
4. **Stage 3**: Change Review & Confirmation
5. **Stage 4**: Archive & Constraint Tree Update

**Core principle**: Design flows from root to leaves (P0→P3), implementation flows from leaves to root (P3→P0).

### Constraint Hierarchy (P0-P3)

```
P0 (Engineering Constitution) - Immutable, violation causes immediate failure
├── P1 (System Specifications) - Warnings acceptable
│   ├── P2 (Module Specifications) - Automated verification
│   │   └── P3 (Implementation Specifications) - IDE hints
```

### Skill Categories

| Category | Skills |
|----------|--------|
| Orchestration | `sop-workflow-orchestrator`, `sop-document-sync`, `sop-progress-supervisor` |
| Specification | `sop-dual-cycle-decision`, `sop-requirement-analyst`, `sop-architecture-design`, `sop-implementation-designer` |
| Implementation | `sop-code-explorer`, `sop-code-implementation`, `sop-test-implementation` |
| Verification | `sop-architecture-reviewer`, `sop-code-review`, `spring-code-reviewer` (Java/Spring only) |
| Documentation | `sop-document-creator` |

All skills are language-agnostic except `spring-code-reviewer` which is Java/Spring specific.

## Project Structure

```
plugins/mumu-sop/
├── .claude-plugin/
│   └── plugin.json          # Plugin manifest
├── skills/                   # 14 skills, each with SKILL.md
├── _resources/
│   ├── constitution/         # P0 architecture principles
│   ├── constraints/          # P0-P3 constraint definitions
│   ├── workflow/             # 5-stage workflow documentation
│   ├── contracts/            # Stage contracts (YAML)
│   ├── templates/            # Constraint & report templates
│   └── examples/             # Example temp node files
├── tests/                    # Per-skill trigger & functional tests
└── index.md                  # Skill index and documentation root
```

## Development Commands

### Adding a New Skill

1. Create directory: `plugins/mumu-sop/skills/your-skill-name/`
2. Create `SKILL.md` with YAML frontmatter (required fields: `name`, `description`)
3. Add references in `references/` subdirectory if needed
4. Register in `plugin.json` under `skills.language_agnostic` or `skills.language_specific`
5. Create tests in `tests/your-skill-name/` (triggers.md and functional.md)
6. Update `plugins/mumu-sop/index.md` skill index

### Skill Development Guidelines

See `docs/skill-development-guide.md` for comprehensive guidance on:
- YAML frontmatter requirements
- Description writing best practices
- Progressive disclosure patterns
- Testing methodology

### Key Constraints When Editing Skills

- File must be named `SKILL.md` (case-sensitive)
- Skill name in frontmatter must be kebab-case
- Description must include "what it does" and "when to use it"
- No XML tags in descriptions (reserved for system use)
- Avoid reserved prefixes: `claude-`, `anthropic-`

## Important Files

| Purpose | File |
|---------|------|
| Plugin manifest | `plugins/mumu-sop/.claude-plugin/plugin.json` |
| Skill index | `plugins/mumu-sop/index.md` |
| Workflow definition | `plugins/mumu-sop/_resources/workflow/index.md` |
| Constraint hierarchy | `plugins/mumu-sop/_resources/constraints/index.md` |
| Architecture principles (P0) | `plugins/mumu-sop/_resources/constitution/architecture-principles.md` |
| Development guide | `docs/skill-development-guide.md` |
| Test index | `plugins/mumu-sop/tests/index.md` |

## Contract-Based Design

Stages communicate via contracts defined in `_resources/contracts/`:
- `stage-0-contract.yaml` through `stage-4-contract.yaml`
- Contracts define preconditions, logic context, and postconditions
- No shared state between stages - only contract files

## Temporary Node Pattern

Implementation tasks create temporary nodes stored independently:
```
.trae/specs/{change-id}/
├── spec.md        # Task specification
├── tasks.md       # Task list
└── checklist.md   # Verification checklist
```

Temporary nodes reference P3 constraints but are archived after completion.