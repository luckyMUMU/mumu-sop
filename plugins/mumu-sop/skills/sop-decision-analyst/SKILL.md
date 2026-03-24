---
name: sop-decision-analyst
version: 1.1.0
description: |
  Provides dual-cycle decision framework: outer for intent analysis, inner for review.
  触发词: analyze complex requirement, 决策分析, 意图分析, 双循环决策, clarify.
license: MIT
compatibility: "Language-agnostic, works with any programming language and framework"
metadata:
  author: luckyMUMU
  category: specification
  tags: [decision, analysis, clarification, intent]
  language_agnostic: true
---

# sop-dual-cycle-decision

## 描述

双循环决策 Skill 提供了一个元认知层面的决策框架。该 Skill 在处理用户需求时，先通过**外循环**进行意图分析和多轮澄清，然后通过**内循环**对决策路径和执行计划进行审查预演。

主要职责：
- **外循环（战略层）**：多轮多维度提问分析用户意图，记录决策路径，创建执行计划
- **内循环（战术层）**：审查决策路径的合理性，预演执行计划的可行性，识别潜在风险

## 使用场景

触发此 Skill 的条件：

1. **复杂需求分析**：用户提出复杂需求，需要深入分析意图
2. **多轮澄清**：需要多轮次、多维度的澄清和确认
3. **决策记录**：需要记录决策路径和判断依据
4. **执行前审查**：需要在执行前进行审查和预演

## 指令

### 外循环：意图分析与计划制定

#### 步骤 1: 初始意图识别

1. 读取用户原始请求
2. 识别关键词和核心诉求
3. 初步判断需求类型（新功能、重构、修复、优化）
4. 评估需求复杂度和影响范围

#### 步骤 2: 多轮多维度提问

| 轮次 | 维度 | 目的 |
|------|------|------|
| 第一轮 | 业务背景与目标 | 理解问题本质，定义验收标准 |
| 第二轮 | 长期目标与短期实现 | 理解终极目标，定义 MVP 范围 |
| 第三轮 | 边界与约束 | 避免范围蔓延，识别技术限制和依赖关系 |
| 第四轮 | 风险与假设 | 提前规避风险，暴露隐藏假设 |

#### 步骤 3: 记录决策路径

整理多轮提问的回答，记录每个决策点的判断依据，保存到 `contracts/intent-analysis.json`。

> 详细格式参见 [templates.md](references/templates.md)

#### 步骤 4: 创建执行计划

将需求分解为最小可执行单元，识别任务依赖关系，确定实现顺序（从依赖方到被依赖方），保存到 `contracts/execution-plan.json`。

> 详细格式参见 [templates.md](references/templates.md)

#### 步骤 5: 等待用户审查

展示意图分析报告、决策路径和执行计划，请求用户确认或提供反馈。

### 内循环：审查与预演

#### 步骤 6: 审查决策路径

- **一致性检查**：决策是否与用户目标一致，决策之间是否存在冲突
- **完整性检查**：是否遗漏重要决策点，是否考虑了所有约束条件
- **可行性检查**：资源是否充足，时间是否合理，技术是否可行

#### 步骤 7: 预演执行计划

- **依赖关系验证**：绘制任务依赖图，检查循环依赖，识别关键路径
- **风险预演**：模拟每个任务的执行过程，识别可能的失败点
- **资源冲突检测**：检查资源过度分配和时间冲突

#### 步骤 8: 生成审查意见

总结审查发现，识别高风险决策，提出改进建议，保存到 `contracts/review-feedback.md`。

#### 步骤 9-10: 循环处理反馈

读取用户反馈，识别反馈类型，调整决策路径或执行计划，重新进入内循环审查。

## 契约

### 输入契约

```yaml
required_inputs:
  - name: "user_request"
    type: text
    validation: "长度 >= 10 字符"
    description: "用户原始请求"

optional_inputs:
  - name: "context"
    type: json
    description: "当前上下文信息"
```

### 输出契约

```yaml
required_outputs:
  - name: "intent_analysis"
    type: json
    path: "contracts/intent-analysis.json"
  - name: "decision_path"
    type: json
    path: "contracts/decision-path.json"
  - name: "execution_plan"
    type: json
    path: "contracts/execution-plan.json"
  - name: "review_feedback"
    type: markdown
    path: "contracts/review-feedback.md"
```

### 行为契约

```yaml
preconditions:
  - "用户请求清晰（长度 >= 10 字符）"
  - "用户愿意参与多轮澄清"

postconditions:
  - "意图分析报告已生成"
  - "决策路径记录完整"
  - "用户已确认或提供反馈"

invariants:
  - "必须进行至少一轮澄清提问"
  - "必须记录决策路径"
  - "必须进行内循环审查"
  - "必须等待用户确认后才能执行"
```

## 常见坑

| 坑 | 现象 | 解决 |
|---|------|------|
| 过度分析 | 陷入无休止分析 | 设置时间盒，采用"足够好"原则 |
| 忽视反馈循环 | 未等待用户确认 | 严格执行等待步骤 |
| 决策记录不完整 | 缺少替代方案或依据 | 使用结构化模板强制记录 |
| 内循环流于形式 | 审查意见泛泛而谈 | 使用检查清单确保覆盖 |
| 依赖关系不明确 | 实现顺序错误 | 必须识别依赖来源，不确定时提问 |

## 相关文档

- [模板与格式](references/templates.md)
- [完整示例](references/examples.md)
- [Skill 索引](../../index.md)
- [需求分析 Skill](../sop-requirement-analyst/SKILL.md)