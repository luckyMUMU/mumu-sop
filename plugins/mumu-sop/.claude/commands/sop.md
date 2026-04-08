---
name: sop
description: |
  SOP 工作流统一入口命令。启动 SOP Agent 引导完整 6 阶段工作流，自动分析任务复杂度并推荐执行路径。
  触发词: sop, workflow, 开始工作流, propose, 提案, 启动 SOP
license: MIT
compatibility: Claude Code CLI
---

# sop 命令

SOP 工作流的统一入口，自动分析任务复杂度并引导用户完成 6 阶段软件开发流程。

## 用法

```bash
/sop [task-description]
/sop --help
```

### 示例

```bash
# 启动工作流并描述任务
/sop "实现用户认证系统，支持 JWT 和 OAuth2"

# 不指定任务，进入交互式引导
/sop

# 查看帮助
/sop --help
```

## 功能概述

`sop` 命令是进入 SOP 工作流的主要入口，提供：

1. **任务复杂度分析** - 自动评估任务规模
2. **动态深度调整** - 根据复杂度调整 spec 树深度
3. **工作流引导** - 引导完成 6 阶段流程
4. **智能推荐** - 推荐合适的执行路径

## 6 阶段工作流

```
┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐   ┌─────────┐
│ Define  │ → │  Plan   │ → │  Build  │ → │ Verify  │ → │ Review  │ → │  Ship   │
│  (spec) │   │  (plan) │   │ (build) │   │  (test) │   │ (review)│   │  (ship) │
└─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘   └─────────┘
   Stage 0      Stage 1       Stage 2       Stage 3       Stage 4       Stage 5
   定义          计划          构建          验证          审查          交付
```

## 执行流程

### 场景 1: 指定任务启动

```
用户: /sop "实现用户认证系统"

SOP Agent:
┌─────────────────────────────────────────────────────────────┐
│ 🔍 任务复杂度分析                                           │
│ ───────────────────────────────────────────────────────────  │
│ 任务: 实现用户认证系统                                       │
│ 复杂度: 中等 (Medium)                                        │
│ 推荐深度: 3 层 (P0 → P1 → P2 → temp)                        │
│ 预估工作量: 2-3 天                                           │
│                                                              │
│ 💡 推荐使用: plan 命令进行垂直切片任务分解                  │
└─────────────────────────────────────────────────────────────┘

下一步选项:
[1] 直接进入 Stage 1 (plan) - 已有明确需求
[2] 从 Stage 0 (spec) 开始 - 需要完善规范
[3] 使用 /init-spec-tree 初始化项目约束树
```

### 场景 2: 交互式启动

```
用户: /sop

SOP Agent:
欢迎使用 SOP 工作流！请描述您要完成的任务：

> _

[提示]: 描述应包含：
- 功能目标
- 目标用户
- 技术栈偏好（如有）
- 时间约束（如有）
```

## 复杂度评估

### 评估维度

| 维度 | 说明 | 权重 |
|------|------|------|
| 功能复杂度 | 功能数量和业务逻辑复杂度 | 30% |
| 技术复杂度 | 新技术、架构挑战 | 25% |
| 影响范围 | 修改的文件/模块数量 | 25% |
| 风险因素 | 安全、性能、兼容性风险 | 20% |

### 复杂度分级

| 级别 | 得分 | 深度 | 典型任务 | 推荐模型 |
|------|------|------|----------|----------|
| **Low** | 0-3 | 2 层 | Bug 修复、简单重构 | fast (qwen3-coder-next) |
| **Medium** | 4-6 | 3 层 | 新功能开发、模块重构 | balanced (kimi-k2.5) |
| **High** | 7-10 | 4 层 | 系统重构、架构升级 | powerful (glm-5) |

## 快速路径推荐

根据任务类型自动推荐路径：

### 新功能开发

```
推荐路径: spec → plan → build → test → review → ship
说明: 完整 6 阶段确保质量
```

### Bug 修复

```
推荐路径: build → test → ship (跳过 spec/plan/review)
说明: 小问题快速修复
```

### 代码重构

```
推荐路径: plan → build → test → review → ship
说明: 保持架构一致性
```

### 代码审查

```
推荐路径: review
说明: 直接触发审查阶段
```

## 与其他命令的关系

```mermaid
flowchart TD
    SOP[/sop] --> ANALYZE{复杂度分析}
    
    ANALYZE -->|Low| RECOMMEND_LOW[推荐快速路径]
    ANALYZE -->|Medium| RECOMMEND_MED[推荐标准路径]
    ANALYZE -->|High| RECOMMEND_HIGH[推荐完整路径]
    
    RECOMMEND_LOW --> SPEC[spec]
    RECOMMEND_LOW --> PLAN[plan]
    RECOMMEND_LOW --> BUILD[build]
    RECOMMEND_LOW --> TEST[test]
    RECOMMEND_LOW --> REVIEW[review]
    RECOMMEND_LOW --> SHIP[ship]
    
    RECOMMEND_MED --> SPEC
    RECOMMEND_MED --> PLAN
    RECOMMEND_MED --> BUILD
    RECOMMEND_MED --> TEST
    RECOMMEND_MED --> REVIEW
    RECOMMEND_MED --> SHIP
    
    RECOMMEND_HIGH --> SPEC
    RECOMMEND_HIGH --> PLAN
    RECOMMEND_HIGH --> BUILD
    RECOMMEND_HIGH --> TEST
    RECOMMEND_HIGH --> REVIEW
    RECOMMEND_HIGH --> SHIP
    
    SPEC --> SKILL1[sop-decision-analyst]
    SPEC --> SKILL2[sop-requirement-analyst]
    PLAN --> SKILL3[sop-implementation-designer]
    BUILD --> SKILL4[sop-code-implementer]
    TEST --> SKILL5[sop-test-implementer]
    REVIEW --> SKILL6[sop-code-reviewer]
    REVIEW --> SKILL7[sop-architecture-reviewer]
    SHIP --> SKILL8[sop-document-writer]
```

## 使用模式对比

| 场景 | 推荐命令 | 说明 |
|------|----------|------|
| 不确定从哪开始 | `/sop` | Agent 引导，自动分析 |
| 已有明确需求 | `spec` | 直接开始规范阶段 |
| 仅需实现 | `build` | 跳过设计，直接编码 |
| 仅审查代码 | `review` | 直接进入审查阶段 |
| 初始化项目 | `init-spec-tree` | 创建约束树结构 |

## 输出示例

### 启动成功

```
✅ SOP 工作流已启动

📋 任务分析:
─────────────────────────────────
描述: 实现用户认证系统
复杂度: 中等 (6/10)
推荐深度: 3 层 (P0 → P1 → P2 → temp)

🎯 推荐执行路径:
  spec → plan → build → test → review → ship

📊 6 阶段概览:
┌────────┬──────────┬─────────────┬──────────┐
│ 阶段   │ 状态     │ 推荐模型    │ 预估时间 │
├────────┼──────────┼─────────────┼──────────┤
│ spec   │ 待开始   │ glm-5       │ 30min    │
│ plan   │ 未开始   │ glm-5       │ 20min    │
│ build  │ 未开始   │ kimi-k2.5   │ 2h       │
│ test   │ 未开始   │ kimi-k2.5   │ 30min    │
│ review │ 未开始   │ glm-5       │ 30min    │
│ ship   │ 未开始   │ qwen3-coder │ 10min    │
└────────┴──────────┴─────────────┴──────────┘

💡 下一步:
  调用 sop-decision-analyst 进行意图分析...
  
  [输入 'go' 继续] [输入 'skip' 跳过] [输入 'exit' 退出]
```

### 首次使用提示

```
🌟 欢迎使用 SOP 工作流！

首次使用建议:
1. 运行 /init-spec-tree 初始化项目约束树
2. 使用 /sop 启动工作流
3. 根据引导完成各阶段

快速开始:
- 输入任务描述，例如: "添加用户登录功能"
- Agent 会自动分析并推荐最佳路径

帮助:
- 输入 '/sop --help' 查看帮助
- 输入 'exit' 退出工作流
```

## 配置集成

### 与 mumu-model-router 集成

`sop` 命令自动使用 model-router 的配置：

```yaml
# .mumu-model-router.yaml
model_routing:
  complexity_routing:
    low:      # 简单任务
      model: qwen3-coder-next
    medium:   # 中等任务
      model: kimi-k2.5
    high:     # 复杂任务
      model: glm-5
```

### 约束树集成

`sop` 自动检测并使用项目约束树：

```
检查 .sop/constitution/charter.md...
✅ 找到 P0 约束
✅ 找到 P1 约束
⏭️  跳过 P2/P3 (当前深度: 2)

工作流将遵循这些约束...
```

## 快捷键

在工作流执行过程中：

| 输入 | 动作 |
|------|------|
| `go` / `g` | 继续到下一阶段 |
| `skip` / `s` | 跳过当前阶段 |
| `back` / `b` | 返回上一阶段 |
| `help` / `h` | 显示帮助 |
| `exit` / `q` | 退出工作流 |
| `status` | 查看当前状态 |

## 环境变量

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `SOP_DEPTH` | 默认 spec 树深度 | `auto` |
| `SOP_AUTO_CONTINUE` | 是否自动继续 | `false` |
| `SOP_MODEL_PREFERENCE` | 模型偏好 | `balanced` |

## 相关命令

- `spec` - Stage 0: 定义规范
- `plan` - Stage 1: 计划任务
- `build` - Stage 2: 构建实现
- `test` - Stage 3: 测试验证
- `review` - Stage 4: 五轴审查
- `ship` - Stage 5: 发布交付
- `init-spec-tree` - 初始化约束树

## 故障排除

### 问题: 无法启动工作流

```
❌ 未找到约束树

解决:
1. 运行 /init-spec-tree 初始化
2. 或使用 /sop --force 跳过检查
```

### 问题: 模型路由失败

```
⚠️  model-router 未配置

解决:
1. 创建 .mumu-model-router.yaml
2. 或继续使用默认模型
```

---

**版本**: 2.2.0
**最后更新**: 2026-04-08
