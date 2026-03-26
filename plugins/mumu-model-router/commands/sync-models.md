---
name: sync-models
description: |
  同步模型配置并重新加载插件。
  从 .mumu-model-router.yaml 读取配置，更新所有 agent 的模型设置。
  使用场景: sync-models, 同步模型, 更新模型配置, reload models
---

# 同步模型配置

从 `.mumu-model-router.yaml` 读取配置并更新所有 Agent 的模型设置。

## 执行步骤

1. 读取配置文件 `.mumu-model-router.yaml`
2. 同步 agent 模型配置
3. 提示用户执行 `/reload-plugins`

## 命令

```bash
python ${CLAUDE_PLUGIN_ROOT}/scripts/sync-agents.py sync
```

## 当前配置

运行以下命令查看当前配置：

```bash
python ${CLAUDE_PLUGIN_ROOT}/scripts/sync-agents.py show
```

## 配置文件格式

编辑项目根目录的 `.mumu-model-router.yaml`：

```yaml
model_routing:
  agent_models:
    fast-responder: minimax-m2.5        # 快速响应
    code-implementer-router: kimi-k2.5  # 代码实现
    architect-decider: glm-5            # 架构决策
    batch-processor: minimax-m2.5       # 批量处理
  aliases:
    fast: minimax-m2.5
    balanced: kimi-k2.5
    powerful: glm-5
    cheap: minimax-m2.5
```