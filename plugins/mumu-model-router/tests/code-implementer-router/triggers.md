# code-implementer-router 触发测试

## 应该触发

### 英文触发词
- "implement this feature"
- "write code for"
- "code implementation"
- "build this function"
- "develop this module"
- "implement user authentication"
- "fix this bug"
- "refactor this code"

### 中文触发词
- "实现这个功能"
- "编写代码"
- "开发模块"
- "修复bug"
- "代码实现"
- "重构代码"
- "写代码"

### 改写/同义词
- "帮我实现一下"
- "把这个功能做出来"
- "写个函数"
- "开发这个功能"
- "实现这个需求"

## 不应触发

### 简单查询
- "什么是工厂模式"
- "解释一下这段代码"
- "Python 的语法"

### 架构设计
- "设计一个微服务架构" (应触发 architect-decider)
- "系统架构怎么设计"

### 批量处理
- "处理这100个文件" (应触发 batch-processor)
- "批量转换这些数据"

### 其他 Agent 的触发词
- "快速回答" (应触发 fast-responder)
- "架构决策" (应触发 architect-decider)

## 边界情况

### 可能误触发
- "实现方案设计" (可能混淆架构和实现)
- "代码架构" (可能混淆架构和实现)

### 可能漏触发
- "把这个做一下" (需要识别为实现任务)
- "补全这个功能" (需要识别为实现意图)

---

**测试日期**: 2026-04-07
**预期结果**: 触发准确率 ≥ 90%
