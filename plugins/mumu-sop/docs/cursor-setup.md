# Cursor IDE 配置指南

## 安装方法

### 方法1: 使用项目级规则

1. **复制 Skill 文件到项目**
```bash
# 在项目根目录执行
mkdir -p .cursor/rules

cp plugins/mumu-sop/skills/sop-code-reviewer/SKILL.md .cursor/rules/sop-code-reviewer.md
cp plugins/mumu-sop/skills/sop-bug-analyst/SKILL.md .cursor/rules/sop-bug-analyst.md
# 复制其他需要的 skills...
```

2. **创建 Cursor 规则文件**
创建 `.cursor/rules/sop-workflow.md`：
```markdown
# SOP 工作流规则

## 6 阶段工作流
1. **Define** - 使用 `spec` 命令创建规范
2. **Plan** - 使用 `plan` 命令分解任务
3. **Build** - 使用 `build` 命令增量实现
4. **Verify** - 使用 `test` 命令验证
5. **Review** - 使用 `review` 命令审查
6. **Ship** - 使用 `ship` 命令交付

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

### 方法2: 使用全局规则

1. 打开 Cursor Settings (Cmd/Ctrl + ,)
2. 导航到 **Rules** 标签
3. 添加 SOP 规则内容

## 使用方式

在 Cursor 中，AI 会自动读取 `.cursor/rules/` 下的文件。

### 触发工作流
```
# 在 Cursor Chat 中输入
spec    # 启动规范阶段
build   # 启动构建阶段
review  # 启动审查阶段
```

## 推荐配置

### `.cursor/settings.json`
```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll": true
  },
  "cursor.rules.enabled": true,
  "cursor.rules.directories": [".cursor/rules"]
}
```

## 注意事项

- Cursor 不支持完整的 Agent/Command 系统
- 通过规则文件提供 SOP 工作流指导
- 建议配合 mumu-sop 插件使用以获得完整功能

---

**相关文档**: [mumu-sop 完整文档](../../index.md)
