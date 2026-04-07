# Getting Started with mumu-sop

快速开始指南，帮助你在 5 分钟内上手 mumu-sop 工作流。

## 安装

### Claude Code (推荐)

```bash
# 通过 Marketplace 安装
/plugin marketplace add luckyMUMU/mumu-sop
/plugin install mumu-sop

# 或本地安装
git clone https://github.com/luckyMUMU/mumu-sop.git
claude --plugin-dir ./mumu-sop/plugins/mumu-sop
```

### 其他 IDE

- [Cursor 配置](./cursor-setup.md)
- [Windsurf 配置](./windsurf-setup.md)
- [GitHub Copilot 配置](./github-copilot-setup.md)
- [Gemini CLI 配置](./gemini-cli-setup.md)

## 快速开始

### 1. 初始化项目

```bash
# 创建约束树结构
/init-spec-tree
```

这会创建：
```
.sop/
├── specs/           # 临时节点存储
├── constraints/     # P0-P3 约束目录
├── constitution/    # 工程宪章
└── contracts/       # 阶段契约
```

### 2. 选择入口方式

#### 方式 A: Agent 入口（完整工作流）
```
/sop
# Agent 会自动引导你完成所有阶段
```

#### 方式 B: 命令入口（单阶段快速进入）
```
spec    # Stage 0: 定义规范
plan    # Stage 1: 计划任务
build   # Stage 2: 构建实现
test    # Stage 3: 测试验证
review  # Stage 4: 代码审查
ship    # Stage 5: 发布交付
```

#### 方式 C: Skill 直接触发
```
sop-code-reviewer    # 直接代码审查
sop-bug-analyst      # 直接 Bug 分析
sop-code-refactorer  # 直接代码重构
```

### 3. 完整示例

```bash
# 1. 定义规范
spec
# 输出: SPEC.md 和约束树临时节点

# 2. 计划任务  
plan
# 输出: tasks.md（垂直切片任务列表）

# 3. 构建实现
build
# 按垂直切片增量实现

# 4. 测试验证
test
# 运行测试金字塔

# 5. 代码审查
review
# 五轴审查: Correctness/Readability/Architecture/Security/Performance

# 6. 发布交付
ship
# 归档到约束树
```

## 6 阶段工作流详解

```
┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐
│ Define  │ → │  Plan   │ → │  Build  │ → │ Verify  │ → │ Review  │ → │  Ship   │
│  (spec) │   │  (plan) │   │ (build) │   │  (test) │   │ (review)│   │  (ship) │
└─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘
   定义          计划          构建          验证          审查          交付
```

| 阶段 | 命令 | 核心活动 | 输出 |
|-----|------|---------|------|
| Define | `spec` | 意图分析、规范创建 | SPEC.md |
| Plan | `plan` | 垂直切片任务分解 | tasks.md |
| Build | `build` | 增量实现、P3→P0约束检查 | 代码变更 |
| Verify | `test` | 测试金字塔、覆盖率验证 | 测试报告 |
| Review | `review` | 五轴审查 | 审查报告 |
| Ship | `ship` | 归档、约束树更新 | CHANGELOG |

## 约束层级

```
P0 工程宪章（不可违背）
├── [Always do] 始终验证用户输入
├── [Never do] 绝不硬编码密钥
└── [Ask first] 数据库模式变更

P1 系统规范（警告可接受）
├── [Ask first] 添加新依赖
└── [Always do] API 包含版本号

P2 模块规范（自动化验证）
├── [Always do] 公共API有文档
└── [Ask first] 修改公共接口

P3 实现规范（IDE提示）
├── [Always do] 代码格式化
└── [Always do] Conventional Commits
```

## 五轴审查

每个审查覆盖五个维度：

1. **Correctness（正确性）** - 是否按规范工作
2. **Readability（可读性）** - 是否易于理解
3. **Architecture（架构）** - 是否符合设计
4. **Security（安全）** - 是否引入漏洞
5. **Performance（性能）** - 是否存在性能问题

## 常见问题

### Q: 如何选择入口方式？

**Agent 入口** (`/sop`): 适合复杂任务，需要完整流程管理
**命令入口** (`spec`, `plan`...): 适合特定阶段，快速进入
**Skill 入口**: 适合特定场景，如只审查代码

### Q: 工作流可以跳过阶段吗？

可以。对于简单任务：
```
spec → build → ship
```

对于 Bug 修复：
```
sop-bug-analyst → build → test → ship
```

### Q: P0 约束违反会怎样？

触发**熔断机制**：
- 立即停止当前操作
- 记录违规详情
- 通知责任人
- 必须修复后才能继续

## 下一步

- 阅读 [完整文档](../index.md)
- 查看 [技能索引](../skills/)
- 了解 [约束系统](../_resources/constraints/)

## 获取帮助

```
# 查看命令帮助
/spec --help
/build --help

# 查看 Agent 帮助
/sop help
```

---

**版本**: 2.1.0
**最后更新**: 2026-04-07
