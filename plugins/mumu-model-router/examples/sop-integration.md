# 与 mumu-sop 协同配置示例

本示例展示如何在 mumu-sop 工作流中使用 mumu-model-router 实现智能模型路由。

## 场景

在 SOP 工作流的不同阶段，根据任务复杂度自动选择不同模型：

| SOP 阶段 | 典型任务 | 推荐模型 | 模型别名 |
|---------|---------|---------|---------|
| Stage 0 (意图分析) | 简单查询、快速响应 | minimax-m2.5 | fast |
| Stage 1 (架构设计) | 复杂架构决策 | glm-5 | powerful |
| Stage 2 (代码实现) | 功能开发、Bug修复 | kimi-k2.5 | balanced |
| Stage 3 (代码审查) | 批量文件处理 | minimax-m2.5 | fast |
| Stage 4 (归档) | 批量更新、日志生成 | minimax-m2.5 | cheap |

## 配置方法

### 1. 在项目根目录创建 `.mumu-model-router.yaml`

```yaml
model_routing:
  # 为 SOP 工作流各阶段配置模型
  agent_models:
    # Stage 0: 快速响应阶段
    sop-intent-analyzer: minimax-m2.5
    
    # Stage 1: 架构决策阶段
    sop-architecture-designer: glm-5
    sop-decision-analyst: glm-5
    
    # Stage 2: 代码实现阶段
    sop-code-implementer: kimi-k2.5
    sop-code-refactorer: kimi-k2.5
    sop-bug-analyst: kimi-k2.5
    
    # Stage 3: 审查阶段
    sop-code-reviewer: minimax-m2.5
    sop-architecture-reviewer: minimax-m2.5
    
    # Stage 4: 归档阶段
    sop-document-writer: minimax-m2.5
    
  # 模型别名（可选）
  aliases:
    fast: minimax-m2.5
    balanced: kimi-k2.5
    powerful: glm-5
    cheap: minimax-m2.5
    
  # API 端点配置（可选）
  api_endpoints:
    default: https://api.anthropic.com
    fallback: https://api.openai.com
```

### 2. 在 SOP 工作流中启用模型路由

编辑 `.sop/config.yaml`:

```yaml
# SOP 工作流配置
workflow:
  # 启用模型路由
  enable_model_routing: true
  
  # 各阶段默认模型
  stage_models:
    stage_0: fast          # 意图分析
    stage_1: powerful      # 架构设计
    stage_2: balanced      # 代码实现
    stage_3: fast          # 审查验证
    stage_4: cheap         # 归档文档
    
  # 复杂度覆盖规则
  complexity_override:
    low:
      stage_1: fast        # 简单需求用快速模型
      stage_2: fast
    high:
      stage_1: powerful    # 复杂需求用强力模型
      stage_2: balanced
      
  # hooks 配置
  hooks:
    pre_stage:
      - name: model-router-sync
        description: "同步模型配置"
    post_stage:
      - name: model-usage-log
        description: "记录模型使用情况"
```

### 3. 使用示例

#### 场景 1: 简单 Bug 修复

```
用户: 修复登录页面的样式问题

SOP Agent 分析:
- 任务类型: Bug 修复
- 复杂度: 低
- 推荐 spec 树深度: 2 层
- 模型路由: fast (minimax-m2.5)

执行流程:
Stage 0 → Stage 1 (fast) → Stage 2 (fast) → Stage 4 (cheap)
```

#### 场景 2: 复杂功能开发

```
用户: 实现用户认证系统

SOP Agent 分析:
- 任务类型: 新功能开发
- 复杂度: 高
- 推荐 spec 树深度: 4 层
- 模型路由: stage_1(powerful), stage_2(balanced)

执行流程:
Stage 0 (fast) → Stage 1 (powerful) → Stage 2 (balanced) → 
Stage 3 (fast) → Stage 4 (cheap)
```

## 成本优化效果

假设某项目有 100 个任务：

| 模型 | 单价 | 不使用路由 | 使用路由 |
|-----|------|-----------|---------|
| minimax-m2.5 | ¥0.01 | 100次 | 60次 |
| kimi-k2.5 | ¥0.05 | 0次 | 30次 |
| glm-5 | ¥0.20 | 0次 | 10次 |
| **总成本** | - | **¥1.00** | **¥2.60** |

> 注意：实际成本取决于任务分布。对于简单任务占比高的项目，路由可降低成本；对于复杂任务占比高的项目，成本可能增加但质量提升。

## 独立性说明

- **mumu-sop** 可以独立运行，不依赖 model-router
- **mumu-model-router** 可以独立运行，为任何 Agent 提供路由
- 两者配合时，通过配置文件联动，无硬编码依赖

## 故障回退

如果 model-router 配置无效或不可用：

1. SOP 工作流继续使用默认模型
2. 在日志中记录路由失败
3. 不阻塞工作流执行

---

**配置版本**: 1.0
**最后更新**: 2026-04-07
