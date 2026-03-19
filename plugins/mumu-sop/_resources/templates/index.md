---
version: v5.0.0
updated: 2026-03-15
---

# 模板索引

> **用途**: 提供各类文档和契约的标准模板

---

## 概述

本目录存放所有模板文件，包括约束模板、临时约束模板、文档模板、契约模板、报告模板。

---

## 约束模板（与 P0-P3 对齐）

**目录**: [constraints/](constraints/)

| 模板 | 用途 | 约束强度 |
|------|------|----------|
| [p0-constraint.md](constraints/p0-constraint.md) | P0 约束模板 | 不可违背，违反即熔断 |
| [p1-constraint.md](constraints/p1-constraint.md) | P1 约束模板 | 警告可接受，需技术负责人审批 |
| [p2-constraint.md](constraints/p2-constraint.md) | P2 约束模板 | 自动化验证，需模块负责人审批 |
| [p3-constraint.md](constraints/p3-constraint.md) | P3 约束模板 | IDE 实时提示，自动化工具验证 |

### 约束模板结构

```markdown
---
version: v5.0.0
level: P0|P1|P2|P3
---

# [约束名称]

constraint_id: PX-XXX-NNN
constraint_strength: [约束强度]

## 约束描述
[约束的详细描述]

## 验证方法
[如何验证此约束]

## 违反处理
[违反时的处理方式]

## 例外情况
[允许的例外情况，若无例外则说明]
```

---

## 临时约束模板（参考性质）

**目录**: [temporary/](temporary/)

| 模板 | 用途 | 说明 |
|------|------|------|
| [spec.md](temporary/spec.md) | 临时规范模板 | 任务规范文档 |
| [tasks.md](temporary/tasks.md) | 临时任务模板 | 任务列表 |
| [checklist.md](temporary/checklist.md) | 临时检查清单模板 | 验证标准 |

### 临时约束存储位置

```
.trae/specs/{change-id}/
├── spec.md        # 任务规范文档
├── tasks.md       # 任务列表
└── checklist.md   # 检查清单
```

### 临时约束生命周期

1. **创建**: 独立存储，引用 P3 节点
2. **执行**: 继承 P3 及其祖先节点的约束
3. **完成**: 归档，解除引用关系

---

## 报告模板

**目录**: [reports/](reports/)

| 模板 | 用途 | 使用场景 |
|------|------|----------|
| [review-report.md](reports/review-report.md) | 审查报告模板 | 代码/架构审查 |
| [constraint-report.md](reports/constraint-report.md) | 约束验证报告模板 | 约束验证 |

---

## 使用方法

1. 复制模板文件到目标目录
2. 替换 `[占位符]` 为实际内容
3. 删除不需要的部分
4. 确保符合相关约束

---

## 相关文档

- [约束规范](../constraints/) - P0-P3 约束定义
- [工作流程](../workflow/) - 5 阶段流程
- [工程宪章](../constitution/) - P0 级规范

---

**文档所有者**: 文档团队  
**最后审核**: 2026-03-15  
**下次审核**: 2026-07-15
