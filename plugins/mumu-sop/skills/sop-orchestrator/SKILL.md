---
name: sop-orchestrator
version: 1.1.0
description: |
  Orchestrates the 5-stage SOP workflow (intent→design→implement→review→archive).
  触发词: workflow, orchestrate, start workflow, 开始工作流, 执行流程, SOP.
license: MIT
compatibility: "Language-agnostic, works with any programming language and framework"
metadata:
  author: luckyMUMU
  category: orchestration
  tags: [workflow, orchestration, sop, process-management]
  language_agnostic: true
---

# sop-workflow-orchestrator

## 描述

工作流编排 Skill 负责管理整个工作流程的状态转换。该 Skill 是编排层的核心，确保工作流按正确的顺序执行。

主要职责：
- 管理工作流状态
- 编排阶段转换
- 管理规范版本
- 协调 Skill 执行

## 使用场景

触发此 Skill 的条件：

1. **工作流启动**：用户提交新需求，启动工作流
2. **阶段转换**：一个阶段完成，需要转换到下一阶段
3. **状态查询**：需要查询当前工作流状态
4. **异常处理**：工作流执行出现异常，需要处理

## 指令

### 步骤 0: 双循环决策（新增，针对复杂需求）

**对于复杂需求，在进入 Stage 1 之前先执行双循环决策流程：**

1. 调用 `sop-dual-cycle-decision` Skill
2. 执行外循环：
   - 多轮多维度提问分析用户意图
   - 记录决策路径和判断依据
   - 创建执行计划
3. 执行内循环：
   - 审查决策路径的合理性
   - 预演执行计划的可行性
   - 生成审查意见
4. 等待用户审查确认
5. 如果通过，将决策路径和执行计划传递给后续阶段
6. 如果有反馈，重新进入外循环

**对于简单需求，可跳过此步骤，直接进入 Stage 1。**

### 步骤 1: 初始化工作流

1. 读取权重决策（Stage 0）
2. 检查工作流是否包含双循环决策产物（复杂需求）
3. 创建工作流状态文件
4. 初始化阶段队列
5. 记录工作流元数据

### 步骤 2: 编排阶段执行

1. 确定当前阶段
2. 加载阶段契约
3. 调度相关 Skill
4. 监控执行状态

### 步骤 3: 管理阶段转换

1. 验证当前阶段完成条件
2. 执行质量门控检查
3. 更新工作流状态
4. 启动下一阶段

### 步骤 4: 处理异常情况

1. 检测执行异常
2. 触发熔断机制（三击熔断）
3. 记录异常信息
4. 通知相关人员

### 步骤 5: 更新工作流状态

1. 记录阶段完成状态
2. 更新进度信息
3. 保存工作流状态文件
4. 生成状态报告

## 契约

### 输入契约

```yaml
required_inputs:
  - name: "weight_decision"
    type: json
    path: "contracts/stage-0-decision.json"
    description: "权重决策结果"
  
  - name: "constitution_docs"
    type: files
    path: "../../_resources/constitution/"
    description: "工程宪章文档"

optional_inputs:
  - name: "workflow_state"
    type: json
    path: "contracts/workflow-state.json"
    description: "当前工作流状态"
```

### 输出契约

```yaml
required_outputs:
  - name: "workflow_state"
    type: json
    path: "contracts/workflow-state.json"
    format:
      current_stage: "stage-N"
      completed_stages: ["stage-0", "stage-1"]
      pending_stages: ["stage-2", "stage-3", "stage-4"]
    guarantees:
      - "工作流状态已更新"
      - "阶段按顺序执行"

  - name: "workflow_summary"
    type: json
    path: contracts/workflow-summary.json
    format: "阶段摘要，用于 Compaction 后的上下文恢复"
    guarantees:
      - "包含各阶段的摘要信息"
      - "包含关键决策和产物引用"

  - name: "artifact_index"
    type: yaml
    path: contracts/artifact-index.yaml
    format: "产物统一索引"
    guarantees:
      - "所有产物已注册"
      - "索引可追溯"

  - name: "rollback_point"
    type: json
    path: contracts/rollback-point.json
    format: "阶段回滚点"
    guarantees:
      - "阶段完成时创建"
      - "包含完整状态快照"
```

## Compaction 机制

### 触发条件

```yaml
compaction:
  trigger:
    type: token_threshold
    threshold: 100000
  strategy:
    current_stage: full_context
    completed_stages: summary_only
    preserve:
      - key_decisions
      - artifact_references
      - constraint_violations
```

### 输出格式

```yaml
output:
  path: contracts/workflow-summary.json
  format:
    stages:
      - name: string
        status: completed | in_progress | pending
        summary: string
        artifacts: string[]
        decisions: string[]
```

### 行为契约

```yaml
preconditions:
  - "规范重量决策已确认"
  - "工程宪章存在"

postconditions:
  - "工作流状态已更新"
  - "阶段按顺序执行"
  - "工作流状态文件已保存"

invariants:
  - "阶段必须按顺序执行"
  - "每个阶段必须通过质量门控"
  - "三击熔断机制必须生效"
```

## 常见坑

### 坑 1: 阶段跳过执行

- **现象**: 某些阶段未执行就直接进入下一阶段，导致前置条件不满足。
- **原因**: 未严格执行阶段依赖关系，错误判断某阶段可以跳过。
- **解决**: 每个阶段必须验证前置条件，只有当前置阶段全部完成且通过质量门控后才能进入下一阶段。

### 坑 2: 状态文件损坏

- **现象**: 工作流状态文件内容不完整或格式错误，无法恢复工作流状态。
- **原因**: 状态更新过程中发生异常，导致部分写入或格式错误。
- **解决**: 使用原子写入方式更新状态文件，写入前备份旧状态，写入失败时回滚。

### 坑 3: 熔断机制失效

- **现象**: 连续多次失败后工作流仍继续执行，未触发熔断。
- **原因**: 失败计数器未正确累加，或熔断阈值配置错误。
- **解决**: 确保"三击熔断"机制正确实现，连续三次失败后必须停止工作流并通知相关人员。

## 示例

### 输入示例

```json
{
  "weight_decision": {
    "complexity": "high",
    "path": "deep",
    "stages": ["stage-0", "stage-1", "stage-2", "stage-3", "stage-4"]
  }
}
```

### 输出示例

```json
{
  "workflow_id": "wf-20260301-001",
  "current_stage": "stage-1",
  "completed_stages": ["stage-0"],
  "pending_stages": ["stage-2", "stage-3", "stage-4"],
  "stage_details": {
    "stage-0": {
      "status": "completed",
      "completed_at": "2026-03-01T09:00:00Z",
      "decision": "deep"
    },
    "stage-1": {
      "status": "in_progress",
      "started_at": "2026-03-01T09:05:00Z"
    }
  }
}
```

## 相关文档

- [Skill 索引](../../index.md)
- [文档同步 Skill](../sop-document-sync/SKILL.md)
- [进度监管 Skill](../sop-progress-supervisor/SKILL.md)
- [工作流详解](../../_resources/workflow/index.md)