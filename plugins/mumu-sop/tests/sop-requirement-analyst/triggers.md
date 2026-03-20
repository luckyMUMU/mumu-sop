# sop-requirement-analyst 触发测试

## 应该触发

### 英文触发词
- "analyze requirements"
- "create spec"
- "define acceptance criteria"
- "clarify requirements"
- "write specification"

### 中文触发词
- "分析需求"
- "写规范"
- "定义验收标准"
- "需求文档"
- "需求分析"

### 改写/同义词
- "帮我把这个需求整理成文档"
- "这个功能的需求是什么"
- "定义一下验收条件"
- "用户故事怎么写"

## 不应触发

### 无关查询
- "What is machine learning?"
- "翻译这段文字"
- "实现代码" (应触发 sop-code-implementation)
- "设计架构" (应触发 sop-architecture-design)

### 其他 Skill 的触发词
- "代码审查" (应触发 sop-code-review)
- "探索代码库" (应触发 sop-code-explorer)
- "同步文档" (应触发 sop-document-sync)

## 边界情况

### 可能误触发
- "需求" (太泛化，应询问用户意图)
- "文档" (可能是创建文档，应触发 sop-document-creator)

### 可能漏触发
- "用户想要一个登录功能" (隐含需求分析)
- "业务规则是这样的" (隐含规范创建)

---

**测试日期**: 2026-03-20
**预期结果**: 触发准确率 ≥ 90%