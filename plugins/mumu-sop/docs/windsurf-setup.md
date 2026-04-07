# Windsurf IDE 配置指南

## 安装方法

### 方法1: Cascade Rules

Windsurf 使用 Cascade 作为 AI 助手，可通过规则文件配置。

1. **创建 Windsurf 规则目录**
```bash
mkdir -p .windsurf/rules
```

2. **复制 Skill 内容**
```bash
# 将 SKILL.md 内容复制到规则文件
cp plugins/mumu-sop/skills/sop-code-reviewer/SKILL.md .windsurf/rules/code-review.md
```

3. **创建工作流规则**
创建 `.windsurf/rules/sop-workflow.md`：
```markdown
# SOP 工作流

## 使用方式
在 Cascade 中输入：
- "spec" - 启动规范阶段
- "plan" - 启动计划阶段
- "build" - 启动构建阶段
- "test" - 启动测试阶段
- "review" - 启动审查阶段
- "ship" - 启动交付阶段

## 约束层级
P0 > P1 > P2 > P3

## 五轴审查
Correctness, Readability, Architecture, Security, Performance
```

### 方法2: 全局配置

1. 打开 Windsurf Settings
2. 找到 **AI Rules** 或 **Cascade Rules**
3. 添加 SOP 工作流规则

## 使用方式

在 Windsurf 的 Cascade 输入框中：

```
spec: 实现用户登录功能
# 或
build: 按照 tasks.md 实现任务
# 或
review: 审查刚才提交的代码
```

## 推荐配置

### `.windsurf/config.json`
```json
{
  "ai": {
    "rulesDirectory": ".windsurf/rules",
    "enableContextualRules": true
  },
  "editor": {
    "formatOnSave": true
  }
}
```

## 注意事项

- Windsurf 的 Cascade 会自动读取项目中的规则文件
- 规则文件应为 Markdown 格式
- 建议每个 Skill 一个规则文件

---

**相关文档**: [mumu-sop 完整文档](../../index.md)
