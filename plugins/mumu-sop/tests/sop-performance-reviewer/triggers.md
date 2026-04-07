# sop-performance-reviewer 触发测试

## 应该触发

### 英文触发词
- "performance review"
- "check performance"
- "optimize this"
- "performance issue"
- "slow query"
- "N+1 problem"
- "memory leak"

### 中文触发词
- "性能审查"
- "优化检查"
- "性能问题"
- "查询优化"
- "慢查询"
- "内存泄漏"

### 改写/同义词
- "这段代码性能如何"
- "检查性能瓶颈"
- "优化建议"
- "性能调优"

## 不应触发

### 功能相关
- "实现功能" (应触发 sop-code-implementer)
- "写代码" (应触发 build)
- "修复 bug" (应触发 sop-bug-analyst)

### 其他审查
- "代码审查" (应触发 review 或 sop-code-reviewer)
- "安全审查" (应触发 security check)

## 边界情况

### 可能误触发
- "功能性能" (可能混淆功能和性能)
- "性能测试" (可能混淆测试和性能审查)

### 可能漏触发
- "这个查询很慢" (需要识别为性能问题)
- "页面加载慢" (需要识别为前端性能)

---

**测试日期**: 2026-04-07
**预期结果**: 触发准确率 ≥ 85%
