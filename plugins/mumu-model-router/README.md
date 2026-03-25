# Mumu Model Router Plugin

A Claude Code plugin that enables different agents and subagents to use different AI models and API endpoints.

## Features

- 🔄 **Model Routing**: Route different agents to different AI models
- 🔗 **Custom Endpoints**: Configure custom API base URLs per provider
- 💰 **Cost Optimization**: Route simple tasks to cheaper models
- ⚡ **Fallback Support**: Define fallback models for reliability
- 📊 **Cost Tracking**: Monitor and limit API costs

## Installation

Place this plugin in your Claude Code plugins directory.

## Quick Start

### 1. Configure Environment Variables

```bash
# Anthropic API
export ANTHROPIC_API_KEY=your-api-key

# OpenAI API (optional)
export OPENAI_API_KEY=your-api-key
```

### 2. Create Configuration File

Create `.mumu-model-router.yaml` in your project root:

```yaml
model_routing:
  default_model: claude-sonnet-4-6
  aliases:
    fast: claude-haiku-4-5-20251001
    balanced: claude-sonnet-4-6
    powerful: claude-opus-4-6
    cheap: gpt-4o-mini
```

### 3. Use Agents

The plugin provides pre-configured agents:

| Agent | Model | Use Case |
|-------|-------|----------|
| `fast-responder` | Claude Haiku | Quick queries |
| `code-implementer-router` | Claude Sonnet | Code implementation |
| `architect-decider` | Claude Opus | Architecture decisions |
| `batch-processor` | GPT-4o Mini | Bulk operations |

## Available Agents

### fast-responder

```yaml
model: claude-haiku-4-5-20251001
```

For simple queries, quick responses, format conversions.

### code-implementer-router

```yaml
model: claude-sonnet-4-6
```

For code implementation, bug fixes, refactoring.

### architect-decider

```yaml
model: claude-opus-4-6
```

For architecture design, technology selection, complex decisions.

### batch-processor

```yaml
model: gpt-4o-mini
```

For bulk processing, cost-sensitive operations.

## Configuration

See `_resources/config/` for detailed configuration options:

- [model-routing.yaml](_resources/config/model-routing.yaml) - Full configuration template
- [api-endpoints.yaml](_resources/config/api-endpoints.yaml) - API endpoint configuration
- [agent-model-config.md](_resources/config/agent-model-config.md) - Agent model guide

## Custom Endpoints

Support for various OpenAI-compatible endpoints:

```yaml
api_endpoints:
  # Official providers
  anthropic:
    base_url: https://api.anthropic.com
  openai:
    base_url: https://api.openai.com/v1

  # Compatible services
  groq:
    base_url: https://api.groq.com/openai/v1
  together:
    base_url: https://api.together.xyz/v1

  # Local LLM
  ollama:
    base_url: http://localhost:11434/v1
```

## License

MIT

---

**Version**: 1.0.0
**Author**: luckyMUMU