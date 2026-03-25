# Agent Model Configuration Guide

This guide explains how to configure different models for different agents.

## Model Field in Agent Frontmatter

Every agent can specify its preferred model in the YAML frontmatter:

```yaml
---
name: my-agent
description: Agent description
model: claude-sonnet-4-6  # Model specification
---
```

## Model Value Options

### Exact Model Names

Specify the exact model identifier:

```yaml
model: claude-opus-4-6
model: claude-sonnet-4-6
model: claude-haiku-4-5-20251001
model: gpt-4o
model: gpt-4o-mini
```

### Model Aliases

Use predefined aliases for convenience:

| Alias | Model | Use Case |
|-------|-------|----------|
| `fast` | claude-haiku-4-5-20251001 | Quick responses, simple tasks |
| `balanced` | claude-sonnet-4-6 | Standard development tasks |
| `powerful` | claude-opus-4-6 | Complex reasoning, architecture |
| `cheap` | gpt-4o-mini | Cost-sensitive batch operations |

```yaml
model: fast      # Equivalent to claude-haiku-4-5-20251001
model: balanced  # Equivalent to claude-sonnet-4-6
model: powerful  # Equivalent to claude-opus-4-6
model: cheap     # Equivalent to gpt-4o-mini
```

### Inherit from Parent

Use `inherit` to use the same model as the parent context:

```yaml
model: inherit
```

## Agent Configuration Examples

### Fast Response Agent

```yaml
---
name: quick-helper
description: Quick responses for simple queries
model: fast
color: green
tools: ["Read", "Bash"]
---

You are a quick-response agent...
```

### Code Implementation Agent

```yaml
---
name: code-builder
description: Implement code features
model: balanced
color: blue
tools: ["Read", "Write", "Edit", "Bash", "Grep", "Glob"]
---

You are a code implementation agent...
```

### Architecture Decision Agent

```yaml
---
name: system-architect
description: Make architectural decisions
model: powerful
color: magenta
tools: ["Read", "Write", "Bash", "Grep", "Glob", "WebSearch"]
---

You are an architecture decision agent...
```

### Batch Processing Agent

```yaml
---
name: bulk-processor
description: Process items in bulk
model: cheap
color: yellow
tools: ["Read", "Write", "Bash", "Glob"]
---

You are a batch processing agent...
```

## SubAgent Model Inheritance

When an agent spawns a subagent, the model can be inherited or overridden:

### Inheritance Chain

```
Main Agent (claude-sonnet-4-6)
    │
    ├── SubAgent A (inherit → claude-sonnet-4-6)
    │       │
    │       └── SubAgent A1 (claude-haiku-4-5-20251001)
    │
    └── SubAgent B (claude-opus-4-6)
```

### Example: Different Models for Different Subtasks

```yaml
# Main orchestrator
---
name: task-orchestrator
model: balanced
---

The orchestrator delegates to specialized agents:

1. For quick lookups → spawn fast-responder (model: fast)
2. For implementation → spawn code-implementer (model: balanced)
3. For architecture decisions → spawn architect (model: powerful)
```

## Model Selection Strategy

### Task Complexity Mapping

```
Task Complexity Assessment
    │
    ├── LOW (score 0-3)
    │   Simple queries, format conversion, quick lookups
    │   → Use: fast (claude-haiku-4-5-20251001)
    │
    ├── MEDIUM (score 4-6)
    │   Code implementation, bug fixes, refactoring
    │   → Use: balanced (claude-sonnet-4-6)
    │
    └── HIGH (score 7-10)
        Architecture design, security analysis, complex decisions
        → Use: powerful (claude-opus-4-6)
```

### Cost Optimization

| Task Type | Recommended Model | Cost/1K tokens |
|-----------|-------------------|----------------|
| Simple formatting | cheap (gpt-4o-mini) | ~$0.0001 |
| Quick answers | fast (claude-haiku) | ~$0.001 |
| Code tasks | balanced (claude-sonnet) | ~$0.003 |
| Complex reasoning | powerful (claude-opus) | ~$0.015 |

## Custom Model Configuration

### Adding Custom Models

1. Define the model in configuration:

```yaml
# .mumu-model-router.yaml
model_routing:
  aliases:
    my-custom: custom-model-name

api_endpoints:
  custom:
    base_url: https://custom-llm.example.com/v1
    api_key_env: CUSTOM_API_KEY
    models:
      - custom-model-name
```

2. Use in agent:

```yaml
model: my-custom
```

### Using OpenAI-Compatible Services

```yaml
---
name: groq-agent
model: llama-3.1-70b-versatile
---

This agent uses Groq's Llama model...
```

Requires configuration:

```yaml
api_endpoints:
  groq:
    base_url: https://api.groq.com/openai/v1
    api_key_env: GROQ_API_KEY
```

## Troubleshooting

### Model Not Found

```
Error: Model 'claude-xyz' not found
```

Solution: Check model name spelling or add to configuration.

### API Key Missing

```
Error: API key not found for provider 'anthropic'
```

Solution: Set the environment variable `ANTHROPIC_API_KEY`.

### Rate Limit Exceeded

```
Error: Rate limit exceeded
```

Solution: Wait and retry, or use fallback model.

---

**文档版本**: v1.0.0
**最后更新**: 2026-03-24