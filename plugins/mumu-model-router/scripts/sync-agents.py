#!/usr/bin/env python3
"""
Sync Agent Models - 从配置文件同步 Agent 模型配置

读取 .mumu-model-router.yaml 中的 agent_models 配置，
自动更新 agents/*.md 文件中的 model 字段。
"""

import os
import re
import sys
import yaml
from pathlib import Path


def find_config_file():
    """查找配置文件"""
    cwd = Path.cwd()
    for path in [cwd] + list(cwd.parents):
        config_path = path / ".mumu-model-router.yaml"
        if config_path.exists():
            return config_path
    return None


def load_config():
    """加载配置文件"""
    config_file = find_config_file()
    if not config_file:
        print("Error: .mumu-model-router.yaml not found")
        sys.exit(1)

    with open(config_file, "r", encoding="utf-8") as f:
        return yaml.safe_load(f)


def update_agent_model(agent_file: Path, model: str):
    """更新 Agent 文件中的 model 字段"""
    if not agent_file.exists():
        print(f"Warning: Agent file not found: {agent_file}")
        return False

    content = agent_file.read_text(encoding="utf-8")

    # 匹配 model 字段（支持带注释的行）
    pattern = r'^(model:\s*).*$'

    new_content = re.sub(
        pattern,
        f'model: {model}',
        content,
        flags=re.MULTILINE
    )

    if new_content != content:
        agent_file.write_text(new_content, encoding="utf-8")
        print(f"✓ Updated {agent_file.name}: model = {model}")
        return True
    else:
        print(f"  No change: {agent_file.name} already has model = {model}")
        return False


def sync_all_agents():
    """同步所有 Agent 模型配置"""
    config = load_config()

    agent_models = config.get("model_routing", {}).get("agent_models", {})

    if not agent_models:
        print("Warning: No agent_models defined in config")
        return

    # Agent 文件目录
    script_dir = Path(__file__).parent
    agents_dir = script_dir.parent / "agents"

    updated = 0
    for agent_name, model in agent_models.items():
        agent_file = agents_dir / f"{agent_name}.md"
        if update_agent_model(agent_file, model):
            updated += 1

    print(f"\nSummary: {updated} agent(s) updated")


def show_current_config():
    """显示当前配置"""
    config = load_config()
    agent_models = config.get("model_routing", {}).get("agent_models", {})
    aliases = config.get("model_routing", {}).get("aliases", {})

    print("Current Agent Models:")
    print("-" * 40)
    for agent, model in agent_models.items():
        print(f"  {agent}: {model}")

    print("\nModel Aliases:")
    print("-" * 40)
    for alias, model in aliases.items():
        print(f"  {alias}: {model}")


def main():
    """主函数"""
    if len(sys.argv) < 2:
        sync_all_agents()
        return

    command = sys.argv[1]

    if command == "sync":
        sync_all_agents()
    elif command == "show":
        show_current_config()
    elif command == "update":
        if len(sys.argv) < 4:
            print("Usage: sync-agents.py update <agent_name> <model>")
            sys.exit(1)
        agent_name = sys.argv[2]
        model = sys.argv[3]

        script_dir = Path(__file__).parent
        agents_dir = script_dir.parent / "agents"
        agent_file = agents_dir / f"{agent_name}.md"

        if update_agent_model(agent_file, model):
            print(f"\n✓ Agent {agent_name} updated to use {model}")
    else:
        print(f"Unknown command: {command}")
        print("Usage: sync-agents.py [sync|show|update]")


if __name__ == "__main__":
    main()