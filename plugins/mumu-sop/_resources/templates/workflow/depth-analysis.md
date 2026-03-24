---
version: v1.0.0
template_type: depth-analysis
language_agnostic: true
---

# 动态 Spec 树深度分析

> **用途**: 根据任务复杂度和代码复杂度动态调整 spec 树深度
> **核心原则**: 设计从 spec 根开始，实现从 spec 叶子开始

---

## 复杂度评估维度

### 评估矩阵

| 维度 | 权重 | 低复杂度 | 中复杂度 | 高复杂度 |
|------|------|---------|---------|---------|
| 任务数量 | 30% | 1-3 | 4-10 | >10 |
| 代码变更行数 | 25% | <100 | 100-500 | >500 |
| 涉及模块数 | 20% | 1 | 2-3 | >3 |
| 依赖变更数 | 15% | 0 | 1-2 | >2 |
| 安全影响 | 10% | 无 | 间接 | 直接 |

### 评分计算

```yaml
complexity_score:
  formula: "sum(factor_weight * factor_score) / sum(weights)"
  range: 0-1

  factor_scores:
    low: 0.33
    medium: 0.66
    high: 1.0

  threshold:
    low_complexity: score < 0.4
    medium_complexity: 0.4 <= score < 0.7
    high_complexity: score >= 0.7
```

---

## 深度调整规则

### 深度映射

```yaml
depth_mapping:
  low_complexity:
    depth: 2
    layers: [P0, P1]
    skip_layers: [P2, P3]
    direct_to_temp: true
    description: "简单变更，直接从 P1 跳到临时节点"

  medium_complexity:
    depth: 3
    layers: [P0, P1, P2]
    skip_layers: [P3]
    temp_node_required: true
    description: "中等变更，需要模块级设计"

  high_complexity:
    depth: 4
    layers: [P0, P1, P2, P3]
    full_hierarchy: true
    all_reviews_required: true
    description: "复杂变更，需要完整层级设计"
```

### 深度可视化

```
低复杂度 (depth=2):
┌─────────────────┐
│ P0 工程宪章     │
└────────┬────────┘
         │
┌────────▼────────┐
│ P1 系统规范     │
└────────┬────────┘
         │ (跳过 P2, P3)
┌────────▼────────┐
│ 临时子节点      │
└─────────────────┘

中复杂度 (depth=3):
┌─────────────────┐
│ P0 工程宪章     │
└────────┬────────┘
         │
┌────────▼────────┐
│ P1 系统规范     │
└────────┬────────┘
         │
┌────────▼────────┐
│ P2 模块规范     │
└────────┬────────┘
         │ (跳过 P3)
┌────────▼────────┐
│ 临时子节点      │
└─────────────────┘

高复杂度 (depth=4):
┌─────────────────┐
│ P0 工程宪章     │
└────────┬────────┘
         │
┌────────▼────────┐
│ P1 系统规范     │
└────────┬────────┘
         │
┌────────▼────────┐
│ P2 模块规范     │
└────────┬────────┘
         │
┌────────▼────────┐
│ P3 实现规范     │
└────────┬────────┘
         │
┌────────▼────────┐
│ 临时子节点      │
└─────────────────┘
```

---

## 执行流程

### 设计流程（自顶向下）

```
1. 接收用户请求
       ↓
2. 分析复杂度
       ↓
3. 确定树深度
       ↓
4. P0 设计 → 用户确认
       ↓
5. P1 设计 → 用户确认
       ↓
   [depth=2?] ──→ 创建临时节点
       ↓
6. P2 设计 → 用户确认
       ↓
   [depth=3?] ──→ 创建临时节点
       ↓
7. P3 设计 → 用户确认
       ↓
8. 创建临时节点
```

### 实现流程（自底向上）

```
[根据树深度从对应叶子开始]

临时节点实现 → 护栏检查
       ↓
[depth=4?] ──→ P3 实现 → 护栏检查
       ↓
[depth>=3?] ──→ P2 实现 → 护栏检查
       ↓
[depth>=2?] ──→ P1 实现 → 护栏检查
       ↓
P0 验证
       ↓
完成
```

---

## 特殊场景处理

### 紧急变更（Hotfix）

```yaml
hotfix_mode:
  trigger: "标记为 hotfix 或 emergency"
  depth: 2
  process:
    - 跳过详细设计阶段
    - 直接进入实现
    - 事后补充文档
  constraint_relaxation:
    - 可跳过部分审查
    - 但 P0 约束不可违反
```

### 原型验证（POC）

```yaml
poc_mode:
  trigger: "标记为 poc 或 prototype"
  depth: 1
  process:
    - 仅记录 P0 级别约束
    - 快速迭代
    - 不产生长效约束
  constraint_relaxation:
    - 可跳过 P1-P3 设计
    - 不更新约束树
```

### 技术债务偿还

```yaml
tech_debt_mode:
  trigger: "标记为 tech-debt 或 refactor"
  depth_assessment:
    # 根据影响范围确定深度
    local_impact: 2      # 局部重构
    module_impact: 3     # 模块级重构
    system_impact: 4     # 系统级重构
  constraint_updates:
    - 更新相关约束
    - 记录变更原因
```

---

## 自动化检测

### 复杂度检测脚本

```bash
# 伪代码示例
function calculate_complexity(change_request):
    score = 0

    # 任务数量评估
    task_count = count_tasks(change_request)
    score += weight.task_count * normalize(task_count, [1, 10])

    # 代码变更评估
    code_lines = estimate_code_changes(change_request)
    score += weight.code_lines * normalize(code_lines, [0, 500])

    # 模块影响评估
    modules = identify_affected_modules(change_request)
    score += weight.modules * normalize(len(modules), [1, 5])

    # 依赖变更评估
    deps = identify_dependency_changes(change_request)
    score += weight.dependencies * normalize(len(deps), [0, 3])

    # 安全影响评估
    security = assess_security_impact(change_request)
    score += weight.security * security_score(security)

    return score / sum(weights)
```

### 深度推荐

```yaml
recommend_depth:
  based_on:
    - calculated_complexity_score
    - historical_similar_changes
    - team_capacity

  output:
    recommended_depth: 2 | 3 | 4
    confidence: 0.0 - 1.0
    reasoning: "string"
```

---

## 相关文档

- [提案模板](../temporary/proposal.md)
- [元数据模板](../temporary/.meta.yaml)
- [约束树更新流程](./spec-tree-update-flow.md)