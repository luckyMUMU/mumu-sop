# Changelog

All notable changes to the mumu-sop plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2026-03-24

### Added

- **Automation Hooks**: Automatic workflow triggers at key stages
  - `pre-apply-hook`: Validates temporary node integrity before Stage 2
  - `post-archive-hook`: Updates constraint tree after Stage 4
  - Hook actions: verify-temp-node, guardrail-check, spec-tree-update, reference-cleanup

- **Hook Documentation**: Complete hook index and YAML configuration files
  - `hooks/index.md`: Comprehensive hook documentation
  - `hooks/pre-apply-hook.yaml`: Pre-apply hook configuration
  - `hooks/post-archive-hook.yaml`: Post-archive hook configuration

### Changed

- **Plugin Version**: Updated to 1.5.0
- **Templates Index**: Updated to v6.1.0 with hook templates section
- **Skill Index**: Added Agent and Hooks sections

## [1.4.0] - 2026-03-24

### Added

- **Entry Agent**: `sop-agent` as unified workflow entry point
  - Automatic complexity analysis
  - Dynamic depth adjustment (2-4 levels)
  - Workflow guidance and monitoring

- **OpenSpec-inspired Templates**: Enhanced temporary node structure
  - `proposal.md`: Change proposal with complexity assessment
  - `design.md`: Technical design with dependency subtree references
  - `specs/requirements.md`: Requirements specification
  - `specs/scenarios.md`: BDD scenarios with Gherkin syntax
  - `.meta.yaml`: Metadata with complexity factors

- **Task Dependencies**: Parallel execution support in tasks.md
  - `dependencies` field for task ordering
  - `parallel_group` field for concurrent execution
  - Mermaid diagrams for task dependency visualization

- **Dynamic Depth Analysis**: Adaptive spec tree depth
  - Low complexity: depth 2 (P0 → P1 → temp)
  - Medium complexity: depth 3 (P0 → P1 → P2 → temp)
  - High complexity: depth 4 (P0 → P1 → P2 → P3 → temp)

- **Dependency Subtrees**: Third-party dependency management
  - `dependency-subtree.md` template
  - Readonly protection (`readonly: true`)
  - Capability and constraint documentation

- **Spec Tree Update Flow**: Post-archive constraint tree updates
  - P3 → P2 → P1 → P0 upward validation
  - Reference cleanup mechanism

- **Dual-Path Storage**: Compatibility with Trae IDE
  - Primary path: `.sop/specs/{change-id}/`
  - Compatible path: `.trae/specs/{change-id}/`

### Changed

- **Constraint Tree References**: Updated all workflow and contract files for dual-path support
- **Architecture Principles**: Added OpenSpec reference and dynamic depth sections
- **Example Files**: Updated with task dependencies and complexity assessment

## [1.3.0] - 2026-03-23

### Added

- **Maintenance Phase Skills**: 4 new skills for software maintenance scenarios
  - `sop-bug-analysis`: Bug analysis with root cause analysis and reproduction tests
  - `sop-code-refactor`: Structured refactoring with TDD protection
  - `sop-tech-debt-manager`: Technical debt identification, prioritization, and planning
  - `sop-dependency-manager`: Dependency upgrade with impact analysis

- **Constraint Tree Mapping**: All new skills map to P0-P3 constraint hierarchy
  - P0: Security vulnerabilities, data risks
  - P1: System stability issues
  - P2: Module functionality defects
  - P3: UI/style issues

- **Quick Paths**: Added quick entry points for common scenarios
  - Bug fix: sop-bug-analysis → fix → verify
  - Refactor: sop-code-refactor → test → refactor → verify
  - Tech debt: sop-tech-debt-manager → identify → plan → repay
  - Dependency: sop-dependency-manager → check → analyze → upgrade → verify

- **Test Coverage**: Complete test suite for new skills
  - 8 trigger test files (triggers.md)
  - 8 functional test files (functional.md)

### Changed

- **Skill Index**: Updated to 18 skills with new maintenance category
- **Description**: Updated plugin description to reflect 18 skills and maintenance support
- **Keywords**: Added bug-analysis, refactor, tech-debt keywords

## [1.2.0] - 2026-03-23

### Changed

- **TDD Compliance**: Restructured `sop-code-implementation` to enforce Red-Green-Refactor cycle
  - Step order changed: now requires writing failing tests before implementation
  - Added explicit TDD cycle verification with mermaid diagram
  - Added "跳过红阶段直接实现" as a new pitfall (坑1)
  - Updated skill version from 1.1.0 to 1.2.0

- **Test Updates**: Updated functional tests for `sop-code-implementation`
  - Added 4 new TDD-specific test cases (Red/Green/Refactor phases + full cycle)
  - Removed outdated non-TDD test cases

- **Plugin Manifest**: Fixed plugin.json to comply with Claude Code specification
  - Moved non-standard fields (`language_agnostic`, `skills`) to `metadata`
  - Added CLAUDE.md for repository context

## [1.1.0] - 2026-03-20

### Added

- **References Directory**: Added `references/` directories to all 14 skills with examples and templates
  - 17 reference files created (examples.md, templates.md, check-patterns.md)

- **Test Coverage**: Complete test suite for all skills
  - 14 trigger test files (triggers.md)
  - 14 functional test files (functional.md)
  - Test index file (tests/index.md)

### Changed

- **Description Optimization**: Simplified all skill descriptions with unified trigger word format
  - Format: `[功能描述]\n触发词: X, Y, Z`
  - Average description length reduced by 66%

- **MCP Dependency Removed**: Removed GitLab MCP dependency from spring-code-reviewer
  - Now uses native git commands (`git diff`, `git log`) for code changes
  - More portable and requires no external MCP server configuration

- **Progressive Disclosure**: Extracted detailed content from long SKILL.md files
  - Maximum file size reduced from 608 lines to 267 lines
  - All files now under 300 lines

### Fixed

- Language-specific component clearly marked (spring-code-reviewer)
- Unified trigger word format across all skills
- Removed outdated MCP references from documentation

## [1.0.0] - 2026-03-18

### Added

- Initial release of mumu-sop plugin
- 14 Skills covering SOP workflow:
  - **Orchestration**: sop-workflow-orchestrator, sop-document-sync, sop-progress-supervisor
  - **Specification**: sop-dual-cycle-decision, sop-requirement-analyst, sop-architecture-design, sop-implementation-designer
  - **Implementation**: sop-code-explorer, sop-code-implementation, sop-test-implementation
  - **Verification**: sop-architecture-reviewer, sop-code-review, spring-code-reviewer
  - **Documentation**: sop-document-creator
- 5-stage workflow (Stage 0-4)
- Contract-based skill collaboration
- P0-P3 constraint hierarchy
- DDD architecture principles
- Language-agnostic design (except spring-code-reviewer)