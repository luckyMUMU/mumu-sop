# architect-decider 触发测试

## 应该触发

### 英文触发词
- "architecture decision"
- "system design"
- "technical strategy"
- "should we use"
- "which technology to choose"
- "design the architecture"
- "make architectural decision"
- "technology selection"

### 中文触发词
- "架构决策"
- "系统设计"
- "技术选型"
- "应该用哪个"
- "设计方案"
- "架构设计"
- "技术方案"
- "系统架构"

### 改写/同义词
- "帮我做个技术决策"
- "这个架构怎么设计"
- "选择什么技术方案"
- "系统该怎么架构"

## 不应触发

### 具体实现
- "实现这个接口" (应触发 code-implementer-router)
- "写个函数"
- "修复这个bug"

### 简单查询
- "什么是微服务" (应触发 fast-responder)
- "解释架构模式"

### 批量处理
- "处理这些数据" (应触发 batch-processor)

### 其他 Agent 的触发词
- "快速回答" (应触发 fast-responder)
- "实现功能" (应触发 code-implementer-router)

## 边界情况

### 可能误触发
- "实现架构" (可能混淆架构设计和实现)
- "设计代码" (可能混淆设计和实现)

### 可能漏触发
- "这个该用Mongo还是Postgres" (需要识别为技术选型)
- "服务怎么划分" (需要识别为架构设计)

---

**测试日期**: 2026-04-07
**预期结果**: 触发准确率 ≥ 85%
