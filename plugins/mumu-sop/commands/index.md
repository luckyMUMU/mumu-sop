---
version: v1.0.0
---

# Commands 索引

SOP 插件提供的命令行工具，用于快速执行常见操作。

---

## 可用命令

| 命令 | 描述 | 用途 |
|------|------|------|
| `/init-spec-tree` | 初始化约束树 | 创建或更新项目的 P0-P3 约束结构 |

---

## /init-spec-tree

初始化或更新项目的约束树（Spec Tree）结构。

### 用法

```bash
/init-spec-tree [--force] [--depth=4] [--project=名称]
```

### 选项

| 选项 | 说明 | 默认值 |
|------|------|--------|
| `--force` | 强制覆盖现有文件 | false |
| `--depth` | 初始化深度 (1-4) | 4 |
| `--project` | 项目名称 | 当前目录名 |

### 创建的目录结构

```
.sop/
├── specs/                    # 临时 spec 节点存储
├── constraints/              # 约束定义
│   ├── p0/                   # P0 约束
│   ├── p1/                   # P1 约束
│   ├── p2/                   # P2 约束
│   ├── p3/                   # P3 约束
│   └── dependencies/         # 依赖子树
├── constitution/             # 工程宪章
└── contracts/                # 阶段契约

.trae/
└── specs/ -> ../.sop/specs/  # 兼容链接
```

### 执行流程

1. 检查现有约束树结构
2. 创建缺失的目录和文件
3. 初始化 P0-P3 约束模板
4. 创建约束树配置文件
5. 建立兼容路径符号链接

---

## 命令开发指南

### 添加新命令

1. 在 `commands/` 目录创建 `{command-name}.md` 文件
2. 添加 YAML frontmatter：
   ```yaml
   ---
   name: command-name
   description: 命令描述
   license: MIT
   compatibility: Claude Code CLI
   ---
   ```
3. 更新 `plugin.json` 的 `metadata.commands` 配置
4. 更新此索引文件

### 命令文件结构

```markdown
---
name: command-name
description: |
  命令描述。
  触发词: keyword1, keyword2
---

# 命令名称

## 用法
## 功能描述
## 执行流程
## 输出
## 错误处理
```

---

## 相关文档

- [入口 Agent](../agents/sop-agent/AGENT.md)
- [工作流概述](../_resources/workflow/index.md)
- [约束树结构](../_resources/constraints/index.md)