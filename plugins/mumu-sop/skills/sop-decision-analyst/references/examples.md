# 双循环决策示例

## 输入示例

```
用户请求：
我需要一个用户管理系统，支持注册、登录、权限控制。
希望能快速上线，但也要考虑未来的扩展性。
```

## 外循环输出示例

### 意图分析报告 (contracts/intent-analysis.json)

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

### 决策路径记录 (contracts/decision-path.json)

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

### 执行计划 (contracts/execution-plan.json)

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

## 内循环输出示例

### 审查意见 (contracts/review-feedback.md)

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