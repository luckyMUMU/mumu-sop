# Model Router 测试索引

## 测试结构

```
tests/
├── fast-responder/
│   ├── triggers.md      # 触发词测试
│   └── functional.md    # 功能测试
├── code-implementer-router/
│   ├── triggers.md
│   └── functional.md
├── architect-decider/
│   ├── triggers.md
│   └── functional.md
└── batch-processor/
    ├── triggers.md
    └── functional.md
```

## Agent 测试覆盖

| Agent | 触发测试 | 功能测试 | 状态 |
|-------|----------|----------|------|
| fast-responder | ✅ | ✅ | Ready |
| code-implementer-router | ✅ | ✅ | Ready |
| architect-decider | ✅ | ✅ | Ready |
| batch-processor | ✅ | ✅ | Ready |

## 测试方法

### 触发测试
验证触发词的准确性和召回率：
- 应该触发：列出应触发该 Agent 的关键词
- 不应触发：列出不应触发该 Agent 的关键词
- 边界情况：识别可能的误触发和漏触发场景

### 功能测试
验证 Agent 的核心功能：
- 测试用例：基于场景的功能测试
- 预期结果：每个测试用例的成功标准
- 测试日期：记录测试执行时间

## 运行测试

触发测试通过实际对话验证，功能测试通过 Agent 执行验证。

---

**最后更新**: 2026-04-07
