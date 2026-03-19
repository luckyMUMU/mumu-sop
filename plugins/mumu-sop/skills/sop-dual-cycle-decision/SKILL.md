---
name: sop-dual-cycle-decision
version: 1.0.0
description: Use when user presents complex requirements needing intent analysis, multi-round clarification needed, decision paths and rationale need recording, or review and dry-run before execution. Don't use when requirements are clear and simple (use sop-requirement-analyst directly), urgent fixes needed (skip lengthy analysis), or user explicitly requests quick implementation.
---

# sop-dual-cycle-decision

## 描述

双循环决策 Skill 提供了一个元认知层面的决策框架。该 Skill 在处理用户需求时，先通过**外循环**进行意图分析和多轮澄清，然后通过**内循环**对决策路径和执行计划进行审查预演。

主要职责：
- **外循环（战略层）**：
  - 多轮多维度提问分析用户意图
  - 记录决策路径和判断依据
  - 创建执行计划
  - 等待用户审查确认
- **内循环（战术层）**：
  - 审查决策路径的合理性
  - 预演执行计划的可行性
  - 识别潜在风险和依赖
  - 提供审查意见和改进建议

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

**第一轮：业务背景与目标**

| 维度 | 问题示例 | 目的 |
|------|----------|------|
| 业务背景 | "这个需求要解决什么业务问题？" | 理解问题本质 |
| 目标用户 | "谁会使用这个功能？核心诉求是什么？" | 明确用户画像 |
| 成功标准 | "如何衡量这个功能的成功？" | 定义验收标准 |
| 优先级 | "这个需求的优先级如何？" | 评估紧急程度 |

**第二轮：长期目标与短期实现**

| 维度 | 问题示例 | 目的 |
|------|----------|------|
| 长期愿景 | "这个功能最终要达到什么状态？" | 理解终极目标 |
| 短期目标 | "第一期需要交付哪些核心能力？" | 定义 MVP 范围 |
| 演进路径 | "从短期到长期，计划的演进路径是什么？" | 规划迭代路线 |
| 技术债务 | "短期实现是否可以接受技术债务？" | 评估技术风险 |

**第三轮：边界与约束**

| 维度 | 问题示例 | 目的 |
|------|----------|------|
| 功能边界 | "这个功能不包含什么？" | 避免范围蔓延 |
| 技术约束 | "是否有技术栈、性能、安全方面的约束？" | 识别技术限制 |
| 兼容性 | "是否需要兼容现有系统？" | 评估集成影响 |
| 资源限制 | "团队规模、时间预算如何？" | 评估可行性 |
| **依赖关系** | "这个功能依赖哪些现有模块？哪些模块会依赖这个功能？" | **识别依赖链，确定实现顺序** |

**第四轮：风险与假设**

| 维度 | 问题示例 | 目的 |
|------|----------|------|
| 风险识别 | "这个需求最大的风险是什么？" | 提前规避风险 |
| 关键假设 | "我们做了哪些假设？是否已验证？" | 暴露隐藏假设 |
| 失败场景 | "可能的失败模式是什么？" | 设计降级方案 |
| 回滚策略 | "如果上线后出现问题，如何回滚？" | 制定应急预案 |

#### 步骤 3: 记录决策路径

1. 整理多轮提问的回答
2. 记录每个决策点的判断依据
3. 识别决策依赖的前提条件
4. 保存决策路径到 `contracts/intent-analysis.json`

决策路径记录格式：

```json
{
  "decision_id": "DEC-001",
  "timestamp": "2026-03-01T10:00:00Z",
  "decision_type": "scope_definition",
  "alternatives_considered": [
    {
      "option": "完整实现所有功能",
      "pros": ["功能完整", "用户体验好"],
      "cons": ["开发周期长", "风险高"]
    },
    {
      "option": "MVP 方案",
      "pros": ["快速上线", "风险可控"],
      "cons": ["功能有限", "需后续迭代"]
    }
  ],
  "selected_option": "MVP 方案",
  "rationale": "基于资源限制和时间约束，优先保证核心功能快速上线验证",
  "assumptions": ["用户接受分阶段交付", "核心功能已覆盖 80% 使用场景"],
  "dependencies": ["用户确认 MVP 范围", "技术团队评估可行性"]
}
```

#### 步骤 4: 创建执行计划

1. 将需求分解为最小可执行单元
2. 识别任务依赖关系
3. **确定实现顺序：从依赖方到被依赖方**（先实现被依赖的任务）
4. 确定优先级和顺序
5. 估算每个任务的工作量
6. 保存执行计划到 `contracts/execution-plan.json`

**实现顺序原则**：

- **从依赖方到被依赖方**：先实现被其他任务依赖的任务（基础模块），再实现依赖它们的任务（上层模块）
- **依赖来源必须准确**：依赖关系应当基于设计文档、架构文档或明确的业务逻辑
- **无法确定依赖时提问**：当无法确定依赖关系或依赖来源不明确时，**必须向用户提问确认**，不得假设

执行计划格式：

```json
{
  "plan_id": "PLAN-001",
  "created_at": "2026-03-01T10:30:00Z",
  "tasks": [
    {
      "task_id": "T001",
      "name": "创建用户认证模型",
      "description": "实现用户模型与认证中间件",
      "priority": "P0",
      "estimated_hours": 4,
      "dependencies": [],
      "dependency_source": "架构文档 3.2 节：用户模型是核心聚合根",
      "skill_required": "sop-code-implementation",
      "acceptance_criteria": [
        "用户模型包含必需字段",
        "认证中间件可正常工作"
      ]
    },
    {
      "task_id": "T002",
      "name": "实现登录接口",
      "description": "构建登录 API 端点",
      "priority": "P0",
      "estimated_hours": 3,
      "dependencies": ["T001"],
      "dependency_source": "设计文档：登录接口依赖用户模型进行身份验证",
      "skill_required": "sop-code-implementation",
      "acceptance_criteria": [
        "登录接口可接收请求",
        "验证用户凭证",
        "返回认证令牌"
      ]
    }
  ],
  "critical_path": ["T001", "T002"],
  "total_estimated_hours": 7,
  "implementation_order_principle": "从依赖方到被依赖方，先实现基础模块再实现上层模块"
}
```

#### 步骤 5: 等待用户审查

1. 展示意图分析报告
2. 展示决策路径和判断依据
3. 展示执行计划
4. 请求用户确认或提供反馈

### 内循环：审查与预演

#### 步骤 6: 审查决策路径

1. **一致性检查**：
   - 检查决策是否与用户目标一致
   - 检查决策之间是否存在冲突
   - 检查假设是否合理

2. **完整性检查**：
   - 检查是否遗漏重要决策点
   - 检查是否考虑了所有约束条件
   - 检查是否识别了所有关键风险

3. **可行性检查**：
   - 检查资源是否充足
   - 检查时间是否合理
   - 检查技术是否可行

#### 步骤 7: 预演执行计划

1. **依赖关系验证**：
   - 绘制任务依赖图
   - 检查是否存在循环依赖
   - 识别关键路径

2. **风险预演**：
   - 模拟每个任务的执行过程
   - 识别可能的失败点
   - 评估影响和概率

3. **资源冲突检测**：
   - 检查是否有资源过度分配
   - 检查是否有时间冲突
   - 识别瓶颈任务

#### 步骤 8: 生成审查意见

1. 总结审查发现
2. 识别高风险决策
3. 提出改进建议
4. 保存审查意见到 `contracts/review-feedback.md`

审查意见格式：

```markdown
# 审查意见

## 决策路径审查

### 通过的决策
- DEC-001: MVP 范围定义 ✓
  - 依据充分，符合资源约束
  - 假设合理，已识别风险

### 需要重新考虑的决策
- DEC-002: 技术选型 ⚠️
  - 风险：团队对该技术栈不熟悉
  - 建议：考虑替代方案或增加培训时间

## 执行计划审查

### 关键路径
- T001 → T002 → T005（总工期：15 小时）

### 高风险任务
- T003: 集成第三方 API
  - 风险：外部依赖不可控
  - 缓解：提前进行技术验证

### 资源冲突
- 无

## 改进建议
1. 为 T003 增加缓冲时间（+2 小时）
2. 提前进行技术预研（T000）
3. 考虑并行执行 T004 和 T005

## 审查结论
- [ ] 通过，可执行
- [x] 有条件通过（需按建议修改）
- [ ] 不通过，需重新规划
```

#### 步骤 9: 等待用户审查反馈

1. 展示审查意见
2. 请求用户确认或提供反馈
3. 如果用户通过，进入执行阶段
4. 如果用户有反馈，返回步骤 1 重新分析

#### 步骤 10: 循环处理反馈

1. 读取用户反馈
2. 识别反馈类型（修改、补充、否定）
3. 调整决策路径或执行计划
4. 重新进入内循环审查

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
    description: "当前上下文信息（项目状态、历史决策等）"
```

### 输出契约

```yaml
required_outputs:
  - name: "intent_analysis"
    type: json
    path: "contracts/intent-analysis.json"
    guarantees:
      - "包含 4 轮提问的完整记录"
      - "包含用户画像和成功标准"
  
  - name: "decision_path"
    type: json
    path: "contracts/decision-path.json"
    guarantees:
      - "记录所有决策点"
      - "包含判断依据和替代方案"
      - "可追溯和审计"
  
  - name: "execution_plan"
    type: json
    path: "contracts/execution-plan.json"
    guarantees:
      - "任务拆分到最小粒度"
      - "依赖关系清晰"
      - "优先级明确"
  
  - name: "review_feedback"
    type: markdown
    path: "contracts/review-feedback.md"
    guarantees:
      - "包含风险识别"
      - "包含改进建议"
      - "包含审查结论"
```

### 行为契约

```yaml
preconditions:
  - "用户请求清晰（长度 >= 10 字符）"
  - "用户愿意参与多轮澄清"

postconditions:
  - "意图分析报告已生成"
  - "决策路径记录完整"
  - "执行计划已拆分到最小粒度"
  - "审查意见已生成"
  - "用户已确认或提供反馈"

invariants:
  - "必须进行至少一轮澄清提问"
  - "必须记录决策路径"
  - "必须进行内循环审查"
  - "必须等待用户确认后才能执行"
  - "用户反馈必须触发重新分析"
```

## 常见坑

### 坑 1: 过度分析导致 paralysis by analysis

- **现象**: 陷入无休止的分析和澄清，迟迟不进入执行阶段。
- **原因**: 追求完美分析，害怕遗漏任何细节。
- **解决**: 设置分析时间盒（timebox），对于低风险决策采用"足够好"原则，明确 MVP 范围后快速进入执行。

### 坑 2: 忽视用户反馈循环

- **现象**: 生成分析和计划后直接执行，未等待用户确认。
- **原因**: 假设初始理解正确，忽视用户可能的反馈。
- **解决**: 严格执行"等待用户审查"步骤，将用户反馈作为输入重新进入分析循环。

### 坑 3: 决策路径记录不完整

- **现象**: 决策记录缺少替代方案或判断依据，无法追溯。
- **原因**: 为了节省时间省略详细记录。
- **解决**: 使用结构化模板强制记录所有字段，定期审计决策路径质量。

### 坑 4: 内循环审查流于形式

- **现象**: 审查意见泛泛而谈，未识别真实风险。
- **原因**: 审查者缺乏经验或时间压力。
- **解决**: 使用检查清单（checklist）确保覆盖所有审查维度，邀请第三方参与审查。

### 坑 5: 依赖关系不明确导致实现顺序错误

- **现象**: 执行计划中任务依赖关系模糊，实现时先实现了上层模块，导致返工。
- **原因**: 未识别清楚模块间的依赖关系，或依赖来源不明确时未提问确认。
- **解决**: 
  - 在创建执行计划时，**必须识别每个任务的依赖来源**（设计文档、架构文档、业务逻辑）
  - **无法确定依赖关系时，必须向用户提问确认**，不得假设
  - 遵循**从依赖方到被依赖方**的实现顺序，先实现基础模块

## 示例

### 输入示例

```
用户请求：
我需要一个用户管理系统，支持注册、登录、权限控制。
希望能快速上线，但也要考虑未来的扩展性。
```

### 外循环输出示例

**意图分析报告（contracts/intent-analysis.json）**:

```json
{
  "request_id": "REQ-20260301-001",
  "analyzed_at": "2026-03-01T10:00:00Z",
  "business_context": {
    "problem": "现有系统缺乏用户管理功能，无法支持多用户协作",
    "target_users": "企业内部员工，预计 50-100 人",
    "success_metrics": "用户可自主注册登录，管理员可分配权限",
    "priority": "高，需在 2 周内上线"
  },
  "long_term_vision": {
    "ultimate_goal": "完整的身份和访问管理（IAM）系统",
    "mvp_scope": "注册、登录、基础 RBAC 权限控制",
    "evolution_path": [
      "Phase 1: 基础认证（2 周）",
      "Phase 2: RBAC 权限（3 周）",
      "Phase 3: SSO 集成（后续）"
    ],
    "technical_debt_acceptable": "可接受，但需保证核心认证逻辑质量"
  },
  "constraints": {
    "out_of_scope": "不支持第三方登录，不支持多因素认证",
    "technical_constraints": "必须使用现有技术栈（Node.js + PostgreSQL）",
    "compatibility": "需兼容现有用户表结构",
    "resource_limits": "2 名开发，2 周时间"
  },
  "risks_and_assumptions": {
    "risks": [
      "时间紧张可能导致测试不足",
      "权限模型设计不当可能导致返工"
    ],
    "assumptions": [
      "现有数据库可支持新需求",
      "无需迁移历史数据"
    ],
    "rollback_strategy": "功能开关控制，问题时可快速关闭"
  }
}
```

**决策路径记录（contracts/decision-path.json）**:

```json
{
  "decisions": [
    {
      "decision_id": "DEC-001",
      "type": "scope_definition",
      "alternatives": [
        {
          "option": "完整 IAM 系统",
          "pros": ["功能完整", "长期无需重构"],
          "cons": ["开发周期 3 个月", "超出资源限制"]
        },
        {
          "option": "MVP 方案",
          "pros": ["2 周可上线", "风险可控"],
          "cons": ["需后续迭代", "存在技术债务"]
        }
      ],
      "selected": "MVP 方案",
      "rationale": "资源有限，优先满足核心需求快速上线",
      "assumptions": ["MVP 可覆盖 80% 使用场景", "技术债务可在 Phase 2 偿还"]
    },
    {
      "decision_id": "DEC-002",
      "type": "technology_choice",
      "alternatives": [
        {
          "option": "使用现有 Auth 库",
          "pros": ["开发快", "团队熟悉"],
          "cons": ["灵活性较低"]
        },
        {
          "option": "自研认证模块",
          "pros": ["完全可控", "可定制"],
          "cons": ["开发周期长", "风险高"]
        }
      ],
      "selected": "使用现有 Auth 库",
      "rationale": "时间约束下优先保证交付",
      "dependencies": ["评估现有库是否支持 RBAC"]
    }
  ]
}
```

**执行计划（contracts/execution-plan.json）**:

```json
{
  "plan_id": "PLAN-001",
  "tasks": [
    {
      "task_id": "T001",
      "name": "数据库设计",
      "description": "设计用户表和权限表结构",
      "priority": "P0",
      "estimated_hours": 3,
      "dependencies": [],
      "skill": "sop-implementation-designer"
    },
    {
      "task_id": "T002",
      "name": "用户模型实现",
      "description": "创建用户实体和仓储",
      "priority": "P0",
      "estimated_hours": 4,
      "dependencies": ["T001"],
      "skill": "sop-code-implementation"
    },
    {
      "task_id": "T003",
      "name": "注册接口",
      "description": "实现用户注册 API",
      "priority": "P0",
      "estimated_hours": 3,
      "dependencies": ["T002"],
      "skill": "sop-code-implementation"
    },
    {
      "task_id": "T004",
      "name": "登录接口",
      "description": "实现用户登录 API",
      "priority": "P0",
      "estimated_hours": 3,
      "dependencies": ["T002"],
      "skill": "sop-code-implementation"
    },
    {
      "task_id": "T005",
      "name": "权限模型",
      "description": "实现 RBAC 权限控制",
      "priority": "P1",
      "estimated_hours": 6,
      "dependencies": ["T002"],
      "skill": "sop-code-implementation"
    }
  ],
  "critical_path": ["T001", "T002", "T003"],
  "total_hours": 19
}
```

### 内循环输出示例

**审查意见（contracts/review-feedback.md）**:

```markdown
# 审查意见

## 决策路径审查

### 通过的决策
- DEC-001: MVP 范围定义 ✓
  - 依据充分，符合资源约束（2 周，2 人）
  - 假设合理，已识别技术债务

- DEC-002: 技术选型 ✓
  - 使用现有 Auth 库可节省 50% 开发时间
  - 风险可控

## 执行计划审查

### 关键路径
- T001 → T002 → T003（总工期：10 小时）

### 高风险任务
- T005: 权限模型
  - 风险：RBAC 设计复杂，可能超时
  - 缓解：简化为基于角色的访问控制，暂不支持细粒度权限

### 资源冲突
- 无，任务可顺序执行

### 时间风险评估
- 总工时 19 小时，2 周（80 小时）内可完成
- 建议增加 20% 缓冲时间（+4 小时）

## 改进建议
1. T005 权限模型简化为仅支持角色分配
2. 增加 T000: 技术预研（2 小时），验证 Auth 库是否支持 RBAC
3. T003 和 T004 可并行开发

## 审查结论
- [x] 通过，可执行（需按建议调整）
```

## 相关文档

- [Skill 索引](../index.md)
- [需求分析 Skill](../requirement-analyst/SKILL.md)
- [工作流编排 Skill](../workflow-orchestrator/SKILL.md)
- [进度监管 Skill](../progress-supervisor/SKILL.md)
