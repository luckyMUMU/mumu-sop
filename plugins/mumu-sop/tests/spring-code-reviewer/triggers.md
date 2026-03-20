# spring-code-reviewer 触发测试

## 应该触发

### 英文触发词
- "review Spring code"
- "Java code review"
- "Spring Boot review"
- "JPA code analysis"
- "Spring application audit"

### 中文触发词
- "Spring代码审查"
- "Java代码审查"
- "Spring Boot审查"
- "JPA代码检查"
- "Spring应用评审"

### 改写/同义词
- "审查这个Spring项目"
- "检查Java代码质量"
- "Spring Boot代码评审"

## 不应触发

### 非 Java/Spring 项目
- "审查Python代码" (应触发 sop-code-review)
- "review Go code" (应触发 sop-code-review)
- "审查React代码" (应触发 sop-code-review)

### 其他 Skill 的触发词
- "设计架构" (应触发 sop-architecture-design)
- "分析需求" (应触发 sop-requirement-analyst)

## 边界情况

### 可能误触发
- "Java" (太泛化，应询问用户意图)
- "Spring" (太泛化，应询问用户意图)

### 可能漏触发
- "检查这个Java项目的代码" (隐含Spring审查)
- "Spring项目代码质量" (隐含审查)

---

**测试日期**: 2026-03-20
**预期结果**: 触发准确率 ≥ 90%
**注意**: 此 Skill 为 Java/Spring 专用