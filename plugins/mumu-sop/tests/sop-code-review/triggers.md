# sop-code-review 触发测试

## 应该触发

### 英文触发词
- "review code"
- "code review"
- "check code quality"
- "audit code"
- "PR review"

### 中文触发词
- "代码审查"
- "审查代码"
- "PR审查"
- "代码评审"
- "代码质量检查"

### 改写/同义词
- "帮我看看这段代码"
- "检查一下代码质量"
- "评审这个PR"

## 不应触发

### 无关查询
- "What is the capital of France?"
- "写代码" (应触发 sop-code-implementation)
- "设计架构" (应触发 sop-architecture-design)

### 其他 Skill 的触发词
- "分析需求" (应触发 sop-requirement-analyst)
- "架构审查" (应触发 sop-architecture-reviewer)
- "Spring代码审查" (应触发 spring-code-reviewer)

## 边界情况

### 可能误触发
- "审查" (太泛化，应询问审查什么)
- "检查" (太泛化，应询问检查什么)

### 可能漏触发
- "这个代码有问题吗" (隐含审查)
- "代码写得怎么样" (隐含评审)

---

**测试日期**: 2026-03-20
**预期结果**: 触发准确率 ≥ 90%