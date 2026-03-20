# 决策记录格式模板

## 决策路径记录格式

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

## 执行计划格式

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

## 实现顺序原则

- **从依赖方到被依赖方**：先实现被其他任务依赖的任务（基础模块），再实现依赖它们的任务（上层模块）
- **依赖来源必须准确**：依赖关系应当基于设计文档、架构文档或明确的业务逻辑
- **无法确定依赖时提问**：当无法确定依赖关系或依赖来源不明确时，**必须向用户提问确认**，不得假设