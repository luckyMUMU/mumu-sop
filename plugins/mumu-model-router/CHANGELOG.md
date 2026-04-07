# Changelog

## [1.2.0] - 2026-04-07

### Added
- 支持国产大模型：Moonshot (Kimi)、SiliconFlow (GLM/Qwen)、智谱 AI、阿里云
- 更新 model_aliases: fast/balanced/powerful/cheap 映射到国产模型
- 扩展 supported_models 配置，包含 6 个提供商

### Changed
- 版本号: 1.1.0 → 1.2.0
- 默认模型从 Anthropic 切换到国产模型

## [1.1.0] - 2026-03-24

### Added
- 初始版本，支持多模型路由
- 4 个预配置 agent: fast-responder, code-implementer-router, architect-decider, batch-processor
