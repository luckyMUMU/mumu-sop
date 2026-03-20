# Changelog

All notable changes to the mumu-sop plugin will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0] - 2026-03-20

### Added

- **Hooks Support**: Added SessionStart and SessionEnd hooks for workflow state persistence
  - SessionStart: Automatically restores workflow state from `contracts/workflow-state.json`
  - SessionEnd: Automatically saves workflow state at session end

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