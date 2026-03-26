#!/usr/bin/env python3
"""
Model Router - 动态模型配置加载器

从 .mumu-model-router.yaml 读取配置，返回 Agent 对应的模型设置。
"""

import os
import sys
import yaml
import json
from pathlib import Path


def find_config_file():
    """查找配置文件"""
    # 项目根目录
    cwd = Path.cwd()

    # 检查当前目录及父目录
    for path in [cwd] + list(cwd.parents):
        config_path = path / ".mumu-model-router.yaml"
        if config_path.exists():
            return config_path

    # 默认配置
    default_config = Path(__file__).parent.parent.parent / ".mumu-model-router.yaml"
    if default_config.exists():
        return default_config

    return None


def load_config():
    """加载配置文件"""
    config_file = find_config_file()
    if not config_file:
        return get_default_config()

    try:
        with open(config_file, "r", encoding="utf-8") as f:
            config = yaml.safe_load(f)
            return config or get_default_config()
    except Exception as e:
        print(f"Warning: Failed to load config: {e}", file=sys.stderr)
        return get_default_config()


def get_default_config():
    """默认配置"""
    return {
        "model_routing": {
            "default_model": "glm-5",
            "agent_models": {
                "fast-responder": "minimax-m2.5",
                "code-implementer-router": "kimi-k2.5",
                "architect-decider": "glm-5",
                "batch-processor": "minimax-m2.5",
            },
            "aliases": {
                "fast": "minimax-m2.5",
                "balanced": "kimi-k2.5",
                "powerful": "glm-5",
                "cheap": "minimax-m2.5",
            }
        },
        "api_endpoints": {
            "custom_llm": {
                "base_url": "https://coding.dashscope.aliyuncs.com/apps/anthropic",
                "api_key_env": "DASHSCOPE_API_KEY",
                "models": ["glm-5", "kimi-k2.5", "minimax-m2.5"]
            }
        }
    }


def get_agent_model(agent_name: str) -> str:
    """获取 Agent 对应的模型"""
    config = load_config()

    model_routing = config.get("model_routing", {})
    agent_models = model_routing.get("agent_models", {})

    # 优先使用 Agent 特定配置
    if agent_name in agent_models:
        return agent_models[agent_name]

    # 使用默认模型
    return model_routing.get("default_model", "glm-5")


def resolve_alias(alias: str) -> str:
    """解析模型别名"""
    config = load_config()

    aliases = config.get("model_routing", {}).get("aliases", {})

    if alias in aliases:
        return aliases[alias]

    # 如果不是别名，直接返回
    return alias


def get_api_endpoint(model: str) -> dict:
    """获取模型对应的 API 端点配置"""
    config = load_config()

    api_endpoints = config.get("api_endpoints", {})

    for endpoint_name, endpoint_config in api_endpoints.items():
        models = endpoint_config.get("models", [])
        if model in models or not models:
            return {
                "name": endpoint_name,
                "base_url": endpoint_config.get("base_url", ""),
                "api_key_env": endpoint_config.get("api_key_env", ""),
            }

    return {"name": "default", "base_url": "", "api_key_env": ""}


def get_all_agent_models() -> dict:
    """获取所有 Agent 的模型配置"""
    config = load_config()
    return config.get("model_routing", {}).get("agent_models", {})


def print_agent_config(agent_name: str = None):
    """打印 Agent 配置"""
    if agent_name:
        model = get_agent_model(agent_name)
        endpoint = get_api_endpoint(model)
        result = {
            "agent": agent_name,
            "model": model,
            "endpoint": endpoint
        }
        print(json.dumps(result, indent=2, ensure_ascii=False))
    else:
        all_models = get_all_agent_models()
        result = {
            "agents": all_models,
            "aliases": load_config().get("model_routing", {}).get("aliases", {})
        }
        print(json.dumps(result, indent=2, ensure_ascii=False))


def main():
    """主函数"""
    if len(sys.argv) < 2:
        print_agent_config()
        return

    command = sys.argv[1]

    if command == "model":
        agent_name = sys.argv[2] if len(sys.argv) > 2 else None
        if agent_name:
            print(get_agent_model(agent_name))
        else:
            print_agent_config()

    elif command == "resolve":
        alias = sys.argv[2] if len(sys.argv) > 2 else ""
        print(resolve_alias(alias))

    elif command == "endpoint":
        model = sys.argv[2] if len(sys.argv) > 2 else ""
        result = get_api_endpoint(model)
        print(json.dumps(result, indent=2, ensure_ascii=False))

    elif command == "config":
        agent_name = sys.argv[2] if len(sys.argv) > 2 else None
        print_agent_config(agent_name)

    else:
        print(f"Unknown command: {command}", file=sys.stderr)
        print("Usage: model-router.py [model|resolve|endpoint|config] [args...]")
        sys.exit(1)


if __name__ == "__main__":
    main()