# sop-code-implementation 触发测试

## 应该触发

### 英文触发词
- "implement code"
- "write code"
- "build feature"
- "create module"
- "coding"

### 中文触发词
- "实现代码"
- "写代码"
- "开发功能"
- "编码"
- "实现这个功能"

### 改写/同义词
- "帮我写代码实现这个功能"
- "根据设计文档编码"
- "开发这个模块"

## 不应触发

### 无关查询
- "What is the time?"
- "帮我写一篇文章"
- "分析需求" (应触发 sop-requirement-analyst)
- "审查代码" (应触发 sop-code-review)

### 其他 Skill 的触发词
- "写测试" (应触发 sop-test-implementation)
- "设计架构" (应触发 sop-architecture-design)
- "探索代码" (应触发 sop-code-explorer)

## 边界情况

### 可能误触发
- "代码" (太泛化，应询问用户意图)
- "功能" (可能是分析需求)

### 可能漏触发
- "把这个设计变成代码" (隐含实现)
- "根据规范写实现" (隐含编码)

---

**测试日期**: 2026-03-20
**预期结果**: 触发准确率 ≥ 90%