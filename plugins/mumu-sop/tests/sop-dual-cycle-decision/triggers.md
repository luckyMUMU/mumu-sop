# sop-dual-cycle-decision 触发测试

## 应该触发

### 英文触发词
- "analyze complex requirement"
- "dual cycle decision"
- "intent analysis"
- "deep clarification needed"

### 中文触发词
- "复杂需求分析"
- "决策分析"
- "意图分析"
- "双循环决策"

### 改写/同义词
- "这个需求很复杂，帮我分析一下"
- "需要多轮澄清"
- "深度分析用户意图"

## 不应触发

### 简单需求
- "简单需求" (应触发 sop-requirement-analyst)
- "快速实现" (应触发 sop-code-implementation)

### 其他场景
- "代码审查" (应触发 sop-code-review)
- "设计架构" (应触发 sop-architecture-design)

---

**测试日期**: 2026-03-20