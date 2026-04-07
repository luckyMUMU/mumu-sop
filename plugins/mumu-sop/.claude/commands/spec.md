---
description: |
  启动 SOP 规范阶段 —— 在编写代码之前创建结构化规范。
  对应 Define 阶段，使用 sop-decision-analyst 和 sop-requirement-analyst skill。
  触发词: spec, define, 规范, 需求分析
---

启动 SOP 规范阶段，将模糊的想法转化为具体的规范文档。

## 执行流程

1. **意图分析** (sop-decision-analyst)
   - 分析用户需求的复杂度
   - 评估是简单任务还是复杂需求
   - 确定是否需要双循环决策

2. **需求规范** (sop-requirement-analyst)
   - 澄清目标和目标用户
   - 定义核心功能和验收标准
   - 明确技术栈偏好和约束
   - 确定边界规则（Always do / Ask first / Never do）

3. **生成 SPEC.md**
   - 保存规范到项目根目录
   - 包含六个核心领域：目标、命令、项目结构、代码风格、测试策略、边界

## 何时使用

- 启动新项目或新功能
- 需求不明确或不完整
- 变更涉及多个文件或模块
- 需要做出架构决策
- 任务预计需要超过30分钟实现

## 何时不使用

- 单行修复、拼写更正
- 需求明确且自包含的变更
- 已通过 /sop 启动完整工作流

## 输出

- `SPEC.md` - 结构化规范文档
- `.sop/specs/{change-id}/` - 约束树临时节点
