# SOP 命令索引

## 入口命令

| 命令 | 触发词 | 描述 |
|------|--------|------|
| `sop` | sop, workflow, 开始工作流, propose | **统一入口**：启动 SOP Agent，自动分析任务复杂度并引导完整工作流 |
| `init-spec-tree` | init-spec, init-tree, 初始化约束树 | **初始化**：创建 P0-P3 约束结构，分析代码并同步约束 |

## 6 阶段工作流命令

| 命令 | 阶段 | 对应 Skill | 用途 |
|------|------|-----------|------|
| `spec` | Stage 0: Define | sop-decision-analyst<br>sop-requirement-analyst | 创建结构化规范 |
| `plan` | Stage 1: Plan | sop-implementation-designer | 垂直切片任务分解 |
| `build` | Stage 2: Build | sop-code-implementer<br>sop-code-explorer | 增量实现功能 |
| `test` | Stage 3: Verify | sop-test-implementer<br>sop-bug-analyst | 测试验证 |
| `review` | Stage 4: Review | sop-code-reviewer<br>sop-architecture-reviewer<br>sop-performance-reviewer | 五轴代码审查 |
| `ship` | Stage 5: Ship | sop-document-writer | 发布交付 |

## 使用方式

### 方式1: 完整工作流（推荐用于复杂任务）
```
/sop                    # 启动 Agent，自动引导完整流程
# 或
spec → plan → build → test → review → ship
```

### 方式2: 单阶段快速进入（推荐用于特定阶段）
```
spec    # 仅需规范阶段
build   # 直接进入实现阶段
review  # 直接代码审查
```

### 方式3: Skill 直接触发
```
sop-code-reviewer       # 直接触发代码审查
sop-bug-analyst         # 直接触发 Bug 分析
```

## 工作流对比

### 与 agent-skills 的映射
| agent-skills | mumu-sop | 说明 |
|-------------|----------|------|
| `/spec` | `spec` | 规范阶段 |
| `/plan` | `plan` | 计划阶段 |
| `/build` | `build` | 构建阶段 |
| `/test` | `test` | 测试阶段 |
| `/review` | `review` | 审查阶段 |
| `/ship` | `ship` | 交付阶段 |

## 命令文件位置

```
.claude/commands/
├── sop.md           # 统一入口 [新增]
├── spec.md
├── plan.md
├── build.md
├── test.md
├── review.md
├── ship.md
└── index.md (本文件)
```

commands/
└── init-spec-tree.md  # 初始化命令 [更新]
```

## 触发词

每个命令支持多种触发方式：
- `spec`: spec, define, 规范, 需求分析
- `plan`: plan, 计划, 规划, 任务分解
- `build`: build, 构建, 实现, 开发
- `test`: test, 测试, 验证, 运行测试
- `review`: review, 审查, 评审, code review
- `ship`: ship, 交付, 发布, deploy

---

**版本**: 2.1.0
**最后更新**: 2026-04-07
