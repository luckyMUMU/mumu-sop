---
version: v1.0.0
plugin_version: 1.0.0
---

# Model Router Plugin

> **核心理念**: 不同任务使用不同模型，优化成本与性能平衡
>
> **功能**: 为不同 Agent 和 SubAgent 配置不同的模型和 API 端点

## 概述

mumu-model-router 是一个模型路由插件，允许为不同的 Agent 配置不同的 AI 模型和 API 端点。

### 核心功能

| 功能 | 描述 |
|------|------|
| **模型路由** | 不同 Agent 使用不同模型 |
| **API 端点配置** | 配置自定义 API 基础 URL |
| **成本优化** | 简单任务使用更便宜的模型 |
| **故障转移** | 定义备用模型确保可靠性 |

## 支持的模型

### Anthropic Claude

| 模型 | 别名 | 特点 | 适用场景 |
|------|------|------|----------|
| claude-opus-4-6 | `powerful` | 最强推理能力 | 复杂决策、架构设计 |
| claude-sonnet-4-6 | `balanced` | 性能与成本平衡 | 代码实现、常规任务 |
| claude-haiku-4-5-20251001 | `fast` | 快速响应 | 简单查询、格式转换 |

### OpenAI Compatible

| 模型 | 别名 | 特点 | 适用场景 |
|------|------|------|----------|
| gpt-4o | - | 多模态能力强 | 图像处理、复杂任务 |
| gpt-4o-mini | `cheap` | 成本低廉 | 简单任务、批量处理 |
| o1 | - | 深度推理 | 复杂问题分析 |
| o3-mini | - | 快速推理 | 实时应用 |

## Agent 模型配置

### 模型字段说明

在 Agent 的 YAML frontmatter 中可以配置 `model` 字段：

```yaml
---
name: my-agent
description: Agent description
model: claude-sonnet-4-6  # 或使用别名: balanced, fast, powerful, cheap
---
```

### 模型值选项

| 值 | 含义 |
|----|------|
| `inherit` | 继承父 Agent 的模型配置 |
| `claude-opus-4-6` | 使用 Claude Opus 4.6 |
| `claude-sonnet-4-6` | 使用 Claude Sonnet 4.6 |
| `claude-haiku-4-5-20251001` | 使用 Claude Haiku 4.5 |
| `gpt-4o` | 使用 GPT-4o |
| `gpt-4o-mini` | 使用 GPT-4o Mini |
| 别名 (`fast`, `balanced`, `powerful`, `cheap`) | 使用预定义的模型别名 |

## Agent 目录

本插件提供以下预配置 Agent：

### 1. fast-responder（快速响应 Agent）

```yaml
model: fast  # claude-haiku-4-5-20251001
```

适用于简单查询、格式转换、快速响应场景。

### 2. code-implementer（代码实现 Agent）

```yaml
model: balanced  # claude-sonnet-4-6
```

适用于代码实现、重构、常规开发任务。

### 3. architect-decider（架构决策 Agent）

```yaml
model: powerful  # claude-opus-4-6
```

适用于复杂决策、架构设计、技术选型。

### 4. batch-processor（批量处理 Agent）

```yaml
model: cheap  # gpt-4o-mini
```

适用于批量处理、简单重复任务。

## 自定义 API 端点

### 环境变量配置

```bash
# Anthropic API
ANTHROPIC_API_KEY=your-api-key
ANTHROPIC_BASE_URL=https://api.anthropic.com  # 可选，自定义端点

# OpenAI API
OPENAI_API_KEY=your-api-key
OPENAI_BASE_URL=https://api.openai.com/v1  # 可选，自定义端点

# 自定义 OpenAI 兼容端点
CUSTOM_LLM_BASE_URL=https://your-custom-llm.com/v1
CUSTOM_LLM_API_KEY=your-api-key
```

### 配置文件

在项目根目录创建 `.mumu-model-router.yaml`：

```yaml
# 模型路由配置
model_routing:
  # 默认模型
  default_model: claude-sonnet-4-6

  # Agent 模型映射
  agent_models:
    fast-responder: claude-haiku-4-5-20251001
    code-implementer: claude-sonnet-4-6
    architect-decider: claude-opus-4-6
    batch-processor: gpt-4o-mini

  # 模型别名
  aliases:
    fast: claude-haiku-4-5-20251001
    balanced: claude-sonnet-4-6
    powerful: claude-opus-4-6
    cheap: gpt-4o-mini

# API 端点配置
api_endpoints:
  anthropic:
    base_url: https://api.anthropic.com
    api_key_env: ANTHROPIC_API_KEY

  openai:
    base_url: https://api.openai.com/v1
    api_key_env: OPENAI_API_KEY

  # 自定义端点
  custom_llm:
    base_url: ${CUSTOM_LLM_BASE_URL}
    api_key_env: CUSTOM_LLM_API_KEY
    models:
      - custom-model-1
      - custom-model-2

# 故障转移配置
fallback:
  enabled: true
  order:
    - claude-sonnet-4-6
    - gpt-4o
    - gpt-4o-mini
```

## 使用示例

### 在 Skill 中使用

```yaml
---
name: my-skill
description: A skill that uses model routing
---

当用户请求时：

1. 简单查询 → 使用 fast-responder Agent
2. 代码实现 → 使用 code-implementer Agent
3. 架构决策 → 使用 architect-decider Agent
4. 批量处理 → 使用 batch-processor Agent
```

### 模型选择策略

```
任务复杂度评估
    │
    ├── 低复杂度（简单查询、格式转换）
    │       └── 使用 fast/cheap 模型
    │
    ├── 中复杂度（代码实现、常规开发）
    │       └── 使用 balanced 模型
    │
    └── 高复杂度（架构设计、复杂决策）
            └── 使用 powerful 模型
```

## 配置资源

- [模型配置模板](_resources/config/model-routing.yaml)
- [API 端点配置](_resources/config/api-endpoints.yaml)

## 相关文档

- [Agent 模型配置详解](_resources/config/agent-model-config.md)

---

**文档版本**: v1.0.0
**最后更新**: 2026-03-24