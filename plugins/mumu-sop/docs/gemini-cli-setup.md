# Gemini CLI 配置指南

## 安装方法

### 方法1: Native Skills

Gemini CLI 支持原生 skill 安装。

1. **安装 mumu-sop skills**
```bash
# 克隆仓库
git clone https://github.com/luckyMUMU/mumu-sop.git

# 安装 skills
gemini skills install ./mumu-sop/plugins/mumu-sop/skills/sop-code-reviewer
gemini skills install ./mumu-sop/plugins/mumu-sop/skills/sop-bug-analyst
# 安装其他 skills...
```

### 方法2: GEMINI.md

创建项目级 `GEMINI.md`：

```markdown
# SOP 工作流配置

## 6 阶段开发流程

### Stage 0: Define
命令: `spec`
技能: sop-decision-analyst, sop-requirement-analyst

### Stage 1: Plan
命令: `plan`
技能: sop-implementation-designer

### Stage 2: Build
命令: `build`
技能: sop-code-implementer, sop-code-explorer

### Stage 3: Verify
命令: `test`
技能: sop-test-implementer, sop-bug-analyst

### Stage 4: Review
命令: `review`
技能: sop-code-reviewer, sop-architecture-reviewer, sop-performance-reviewer

### Stage 5: Ship
命令: `ship`
技能: sop-document-writer

## 约束层级

- P0: 不可违背（熔断）
- P1: 系统规范（警告）
- P2: 模块规范（自动验证）
- P3: 实现规范（IDE提示）

## 五轴审查

1. Correctness（正确性）
2. Readability（可读性）
3. Architecture（架构）
4. Security（安全）
5. Performance（性能）
```

## 使用方式

### 方式1: Skill 直接调用
```bash
# 列出可用 skills
gemini skills list

# 使用 skill
gemini skill sop-code-reviewer
```

### 方式2: 自然语言触发
```bash
# Gemini 会自动识别并调用相应 skill
gemini "审查这段代码的安全性"
gemini "分析这个 bug 的根因"
```

## 推荐配置

### `.gemini/config.yaml`
```yaml
skills:
  directories:
    - ./mumu-sop/plugins/mumu-sop/skills
  auto_discover: true

context:
  files:
    - GEMINI.md
    - SPEC.md
    - tasks.md
```

## 完整工作流示例

```bash
# 1. 定义规范
gemini "spec: 实现用户登录功能"

# 2. 分解任务
gemini "plan: 将登录功能分解为可执行任务"

# 3. 构建实现
gemini "build: 实现用户认证模块"

# 4. 测试验证
gemini "test: 运行登录功能测试"

# 5. 代码审查
gemini "review: 审查登录功能实现"

# 6. 发布交付
gemini "ship: 准备发布登录功能"
```

## 注意事项

- Gemini CLI 的 skill 系统与 Claude Code 略有不同
- 可能需要适配 SKILL.md 格式
- 建议测试每个 skill 的兼容性

---

**相关文档**: [mumu-sop 完整文档](../../index.md)
