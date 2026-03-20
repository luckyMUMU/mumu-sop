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

| Skill | 触发测试 | 功能测试 |
|-------|----------|----------|
| sop-workflow-orchestrator | [triggers.md](./sop-workflow-orchestrator/triggers.md) | [functional.md](./sop-workflow-orchestrator/functional.md) |
| sop-requirement-analyst | [triggers.md](./sop-requirement-analyst/triggers.md) | [functional.md](./sop-requirement-analyst/functional.md) |
| sop-architecture-design | [triggers.md](./sop-architecture-design/triggers.md) | [functional.md](./sop-architecture-design/functional.md) |
| sop-implementation-designer | [triggers.md](./sop-implementation-designer/triggers.md) | [functional.md](./sop-implementation-designer/functional.md) |
| sop-code-explorer | [triggers.md](./sop-code-explorer/triggers.md) | [functional.md](./sop-code-explorer/functional.md) |
| sop-code-implementation | [triggers.md](./sop-code-implementation/triggers.md) | [functional.md](./sop-code-implementation/functional.md) |
| sop-test-implementation | [triggers.md](./sop-test-implementation/triggers.md) | [functional.md](./sop-test-implementation/functional.md) |
| sop-architecture-reviewer | [triggers.md](./sop-architecture-reviewer/triggers.md) | [functional.md](./sop-architecture-reviewer/functional.md) |
| sop-code-review | [triggers.md](./sop-code-review/triggers.md) | [functional.md](./sop-code-review/functional.md) |
| spring-code-reviewer | [triggers.md](./spring-code-reviewer/triggers.md) | [functional.md](./spring-code-reviewer/functional.md) |
| sop-document-creator | [triggers.md](./sop-document-creator/triggers.md) | [functional.md](./sop-document-creator/functional.md) |
| sop-document-sync | [triggers.md](./sop-document-sync/triggers.md) | [functional.md](./sop-document-sync/functional.md) |
| sop-dual-cycle-decision | [triggers.md](./sop-dual-cycle-decision/triggers.md) | [functional.md](./sop-dual-cycle-decision/functional.md) |
| sop-progress-supervisor | [triggers.md](./sop-progress-supervisor/triggers.md) | [functional.md](./sop-progress-supervisor/functional.md) |

---

## 测试覆盖率目标

| 指标 | 目标 |
|------|------|
| 触发准确率 | ≥ 90% |
| 功能测试通过率 | 100% |
| 边界情况覆盖 | ≥ 80% |

---

**文档版本**: v1.0.0
**最后更新**: 2026-03-20