# 与 mumu-model-router 协同工作

mumu-sop 可以与 mumu-model-router 插件配合使用，为不同工作流阶段智能选择模型。

## 协同优势

| 方面 | 独立使用 mumu-sop | 配合 mumu-model-router |
|------|------------------|----------------------|
| 模型选择 | 固定使用当前模型 | 按阶段自动选择最优模型 |
| 成本控制 | 单一成本模型 | 简单任务用便宜模型，复杂任务用好模型 |
| 响应速度 | 统一响应时间 | 简单任务更快响应 |
| 复杂任务质量 | 依赖当前模型能力 | 复杂任务使用更强模型 |

## 启用方法

### 1. 确保两个插件都已安装

```bash
# 检查已安装插件
/claude-plugin list
```

### 2. 配置模型路由（可选）

创建 `.mumu-model-router.yaml`:

```yaml
model_routing:
  agent_models:
    # SOP Agent 使用平衡模型
    sop-agent: kimi-k2.5
    
    # 具体 Skill 可单独配置
    sop-decision-analyst: glm-5      # 复杂决策用强模型
    sop-code-reviewer: minimax-m2.5   # 代码审查用快模型
    sop-document-writer: minimax-m2.5 # 文档生成用快模型
```

### 3. 在 SOP 配置中启用

编辑 `.sop/config.yaml`:

```yaml
workflow:
  enable_model_routing: true
  
  # 配置各阶段使用的 Agent 类型
  stage_agents:
    stage_0: fast-responder        # 意图分析 - 快速响应
    stage_1: architect-decider     # 架构设计 - 架构决策
    stage_2: code-implementer-router # 代码实现 - 代码实现
    stage_3: fast-responder        # 审查验证 - 快速响应
    stage_4: batch-processor       # 归档 - 批量处理
```

## 自动路由规则

当启用模型路由时，SOP 工作流会自动根据以下规则选择模型：

### 按阶段路由

| 阶段 | 任务特点 | 默认路由到 | 原因 |
|------|---------|-----------|------|
| Stage 0 | 意图识别、简单查询 | fast-responder | 快速响应 |
| Stage 1 | 架构设计、技术选型 | architect-decider | 复杂决策 |
| Stage 2 | 代码实现、重构 | code-implementer-router | 代码专长 |
| Stage 3 | 代码审查、验证 | fast-responder | 快速检查 |
| Stage 4 | 批量归档、文档生成 | batch-processor | 批量处理 |

### 按复杂度路由

在 Stage 2 代码实现阶段，根据复杂度选择模型：

| 复杂度 | 模型 | 说明 |
|--------|------|------|
| 低 | fast | 简单修改、格式调整 |
| 中 | balanced | 常规功能开发 |
| 高 | powerful | 复杂算法、架构重构 |

## 配置示例

### 最小配置

只需安装两个插件，无需额外配置即可使用默认路由规则。

### 完整配置

```yaml
# .sop/config.yaml
workflow:
  enable_model_routing: true
  
  complexity_rules:
    low:
      max_tokens: 10000
      model: fast
    medium:
      max_tokens: 50000
      model: balanced
    high:
      max_tokens: 100000
      model: powerful
      
  stage_overrides:
    # 特定阶段强制使用指定模型
    stage_1:
      always_use: powerful  # 架构设计始终使用强模型
    stage_4:
      always_use: cheap     # 归档始终使用便宜模型
```

## 独立性保证

mumu-sop 始终保持独立：

1. **无硬依赖**: 未安装 mumu-model-router 时，SOP 工作流正常运行
2. **配置可选**: 所有模型路由配置都是可选的
3. **故障安全**: 路由失败时自动回退到默认模型
4. **透明集成**: 用户可选择是否启用路由功能

## 验证协同工作

运行以下命令验证配置：

```bash
# 检查 SOP 配置
/sop:config

# 检查模型路由配置
/sync-models show

# 启动工作流（会自动应用路由）
/sop
```

## 故障排查

### 模型路由未生效

1. 检查 `.sop/config.yaml` 中 `enable_model_routing: true`
2. 确认 mumu-model-router 插件已加载
3. 检查 `.mumu-model-router.yaml` 配置有效性

### 特定阶段使用了错误模型

1. 检查 `stage_agents` 配置
2. 确认 Agent 定义存在
3. 查看工作流日志中的模型选择记录

### 成本未优化

1. 检查复杂度评估是否正确
2. 调整 `complexity_rules` 阈值
3. 验证模型别名配置

---

**相关文档**:
- [mumu-model-router 集成示例](../mumu-model-router/examples/sop-integration.md)
- [模型路由配置](../mumu-model-router/_resources/config/agent-model-config.md)

**配置版本**: 1.0
**最后更新**: 2026-04-07
