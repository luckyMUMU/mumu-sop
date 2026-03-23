# sop-bug-analysis 触发测试

## 应该触发

### 英文触发词
- "bug analysis"
- "analyze bug"
- "root cause analysis"
- "debug issue"
- "reproduce bug"
- "investigate issue"

### 中文触发词
- "bug分析"
- "分析bug"
- "问题排查"
- "根因分析"
- "故障分析"
- "复现问题"

### 改写/同义词
- "这个问题是什么原因导致的"
- "帮我定位bug"
- "为什么会出现这个错误"
- "排查生产问题"

## 不应触发

### 无关查询
- "写代码"
- "设计架构"
- "代码审查"

### 其他 Skill 的触发词
- "重构代码" (应触发 sop-code-refactor)
- "升级依赖" (应触发 sop-dependency-manager)
- "技术债务" (应触发 sop-tech-debt-manager)

## 边界情况

### 可能误触发
- "问题" (可能是需求问题，应询问用户意图)
- "分析" (可能是需求分析)

### 可能漏触发
- "出错了怎么办" (隐含bug分析)
- "这个功能不工作了" (隐含问题排查)

---

**测试日期**: 2026-03-23
**预期结果**: 触发准确率 ≥ 90%