# Skill 测试用例

本文档定义了 mumu-sop 所有 Skill 的测试用例，包括触发测试和功能测试。

---

## 测试说明

### 触发测试

测试 Skill 是否在正确的用户输入下被触发。

**测试方法**：
1. 输入"应该触发"的查询，验证 Skill 加载
2. 输入"不应触发"的查询，验证 Skill 不加载
3. 输入改写/同义词查询，验证 Skill 仍能触发

### 功能测试

测试 Skill 执行后是否产生正确的输出。

**测试方法**：
1. 准备测试输入
2. 执行 Skill
3. 验证输出符合预期

---

## 测试用例索引

### 编排类

| Skill | 触发测试 | 功能测试 |
|-------|----------|----------|
| sop-orchestrator | [triggers.md](./sop-orchestrator/triggers.md) | [functional.md](./sop-orchestrator/functional.md) |
| sop-sync | [triggers.md](./sop-sync/triggers.md) | [functional.md](./sop-sync/functional.md) |
| sop-progress-supervisor | [triggers.md](./sop-progress-supervisor/triggers.md) | [functional.md](./sop-progress-supervisor/functional.md) |

### 规范类

| Skill | 触发测试 | 功能测试 |
|-------|----------|----------|
| sop-decision-analyst | [triggers.md](./sop-decision-analyst/triggers.md) | [functional.md](./sop-decision-analyst/functional.md) |
| sop-requirement-analyst | [triggers.md](./sop-requirement-analyst/triggers.md) | [functional.md](./sop-requirement-analyst/functional.md) |
| sop-architecture-designer | [triggers.md](./sop-architecture-designer/triggers.md) | [functional.md](./sop-architecture-designer/functional.md) |
| sop-implementation-designer | [triggers.md](./sop-implementation-designer/triggers.md) | [functional.md](./sop-implementation-designer/functional.md) |

### 实现类

| Skill | 触发测试 | 功能测试 |
|-------|----------|----------|
| sop-code-explorer | [triggers.md](./sop-code-explorer/triggers.md) | [functional.md](./sop-code-explorer/functional.md) |
| sop-code-implementer | [triggers.md](./sop-code-implementer/triggers.md) | [functional.md](./sop-code-implementer/functional.md) |
| sop-test-implementer | [triggers.md](./sop-test-implementer/triggers.md) | [functional.md](./sop-test-implementer/functional.md) |

### 验证类

| Skill | 触发测试 | 功能测试 |
|-------|----------|----------|
| sop-architecture-reviewer | [triggers.md](./sop-architecture-reviewer/triggers.md) | [functional.md](./sop-architecture-reviewer/functional.md) |
| sop-code-reviewer | [triggers.md](./sop-code-reviewer/triggers.md) | [functional.md](./sop-code-reviewer/functional.md) |
| sop-performance-reviewer | [triggers.md](./sop-performance-reviewer/triggers.md) | [functional.md](./sop-performance-reviewer/functional.md) |
| sop-browser-testing | [triggers.md](./sop-browser-testing/triggers.md) | [functional.md](./sop-browser-testing/functional.md) |
| sop-spring-reviewer | [triggers.md](./sop-spring-reviewer/triggers.md) | [functional.md](./sop-spring-reviewer/functional.md) |

### 维护类

| Skill | 触发测试 | 功能测试 |
|-------|----------|----------|
| sop-bug-analyst | [triggers.md](./sop-bug-analyst/triggers.md) | [functional.md](./sop-bug-analyst/functional.md) |
| sop-code-refactorer | [triggers.md](./sop-code-refactorer/triggers.md) | [functional.md](./sop-code-refactorer/functional.md) |
| sop-tech-debt-manager | [triggers.md](./sop-tech-debt-manager/triggers.md) | [functional.md](./sop-tech-debt-manager/functional.md) |
| sop-dependency-manager | [triggers.md](./sop-dependency-manager/triggers.md) | [functional.md](./sop-dependency-manager/functional.md) |

### 文档类

| Skill | 触发测试 | 功能测试 |
|-------|----------|----------|
| sop-document-writer | [triggers.md](./sop-document-writer/triggers.md) | [functional.md](./sop-document-writer/functional.md) |

---

## 测试覆盖率目标

| 指标 | 目标 |
|------|------|
| 触发准确率 | ≥ 90% |
| 功能测试通过率 | 100% |
| 边界情况覆盖 | ≥ 80% |

---

**文档版本**: v2.1.0
**最后更新**: 2026-04-07