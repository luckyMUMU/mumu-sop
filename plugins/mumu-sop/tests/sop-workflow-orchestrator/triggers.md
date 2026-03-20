# sop-workflow-orchestrator 触发测试

## 应该触发

### 英文触发词
- "start workflow"
- "run SOP"
- "orchestrate stages"
- "manage workflow"
- "begin development process"

### 中文触发词
- "开始工作流"
- "执行流程"
- "管理开发流程"
- "运行SOP"
- "工作流编排"

### 改写/同义词
- "帮我启动开发流程"
- "开始一个新的SOP流程"
- "执行标准工作流程"

## 不应触发

### 无关查询
- "What is the weather today?"
- "Help me write Python code"
- "Create a database table"
- "设计架构" (应触发 sop-architecture-design)
- "写代码" (应触发 sop-code-implementation)

### 其他 Skill 的触发词
- "分析需求" (应触发 sop-requirement-analyst)
- "代码审查" (应触发 sop-code-review)
- "写测试" (应触发 sop-test-implementation)

## 边界情况

### 可能误触发
- "工作流" (太泛化，应询问用户意图)
- "流程" (太泛化，应询问用户意图)

### 可能漏触发
- "启动项目开发" (需要识别为工作流启动)
- "帮我按SOP流程来做" (需要识别SOP关键词)

---

**测试日期**: 2026-03-20
**预期结果**: 触发准确率 ≥ 90%