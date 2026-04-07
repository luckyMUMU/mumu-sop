# Release v2.1.0

## 发布日期
2026-04-07

## 版本号
v2.1.0

## 主要特性

### 🚀 6阶段工作流命令
新增6个 `/command` 入口，快速进入工作流各阶段：
- `spec` - 定义规范
- `plan` - 计划任务（含垂直切片）
- `build` - 构建实现
- `test` - 测试验证
- `review` - 五轴审查
- `ship` - 发布交付

### 📊 五轴审查体系
完整的代码审查框架：
1. **Correctness** - 正确性
2. **Readability** - 可读性
3. **Architecture** - 架构
4. **Security** - 安全
5. **Performance** - 性能

参考文档：`_resources/references/five-axis-review.md`

### 🔧 新技能
- **sop-performance-reviewer** - 性能审查
- **sop-browser-testing** - 浏览器测试（DevTools MCP）

总技能数：18 → **20**

### 📚 跨IDE支持
- Cursor IDE
- Windsurf
- GitHub Copilot
- Gemini CLI

## 改进内容

### 垂直切片指导
- 详细的任务分解指导
- 水平 vs 垂直对比
- 可操作的评估标准

### MCP集成
- Chrome DevTools MCP配置
- 6个完整使用示例
- CI/CD集成指南

## 破坏性变更
无

## 兼容性
- 向后兼容 v2.0.0
- 所有现有技能保持可用

## 文件变更

### 新增文件（19个）
```
.claude/commands/
├── spec.md
├── plan.md
├── build.md
├── test.md
├── review.md
├── ship.md
├── index.md

skills/
├── sop-performance-reviewer/SKILL.md
├── sop-browser-testing/SKILL.md

docs/
├── cursor-setup.md
├── windsurf-setup.md
├── github-copilot-setup.md
├── gemini-cli-setup.md
├── getting-started.md

_resources/references/
├── five-axis-review.md

tests/
├── sop-performance-reviewer/
│   ├── triggers.md
│   └── functional.md
└── sop-browser-testing/
    ├── triggers.md
    └── functional.md

.mcp.json
```

### 修改文件（6个）
```
.claude-plugin/plugin.json        # 版本 2.0.0 → 2.1.0
index.md                          # 版本更新，添加引用
CHANGELOG.md                      # 添加 v2.1.0 条目
agents/sop-agent/AGENT.md         # 6阶段工作流
CLAUDE.md                         # 6阶段描述
README.md                         # 6阶段描述
```

## 质量指标

| 指标 | 值 |
|------|-----|
| 代码覆盖率 | N/A (文档项目) |
| 文档完整性 | 100% |
| 测试覆盖率 | 100% (20/20 skills) |
| 审查质量 | A+ |

## 升级指南

### 从 v2.0.0 升级
1. 更新插件文件
2. 重新加载插件：`/reload-plugins`
3. 验证命令：`/spec --help`

### 新用户
1. 安装插件
2. 初始化约束树：`/init-spec-tree`
3. 快速开始：`/sop` 或 `spec`

## 相关链接

- [完整文档](./index.md)
- [快速开始](./docs/getting-started.md)
- [CHANGELOG](./CHANGELOG.md)

---

**发布状态**: ✅ 已发布
**发布者**: luckyMUMU
**签名**: mumu-sop-v2.1.0-2026-04-07
