# GitHub Copilot 配置指南

## 安装方法

### 方法1: Copilot Instructions

GitHub Copilot 支持通过 `.github/copilot-instructions.md` 配置。

1. **创建指令文件**
```bash
mkdir -p .github
touch .github/copilot-instructions.md
```

2. **添加 SOP 工作流指令**
```markdown
# SOP 工作流指令

## 开发流程

### 1. Define（定义）
开始新功能前，先：
- 分析需求复杂度
- 创建 SPEC.md 规范文档
- 确定约束层级

### 2. Plan（计划）
将规范分解为垂直切片任务：
- 每个任务可独立完成
- 明确验收标准
- 建立依赖关系

### 3. Build（构建）
增量实现：
- 单切片实现
- 测试驱动
- P3→P0 约束检查

### 4. Verify（验证）
测试验证：
- 单元测试（80%）
- 集成测试（15%）
- E2E测试（5%）
- 核心模块 100% 覆盖

### 5. Review（审查）
五轴审查：
- Correctness
- Readability
- Architecture
- Security
- Performance

### 6. Ship（交付）
发布：
- 预发布检查
- 功能开关
- 监控设置

## 代码规范

### P0 约束（不可违背）
- 不硬编码密钥
- 核心模块测试 100%
- 不强制解包核心路径

### P1 约束（系统级）
- API 响应 < 500ms
- API 包含版本号

### P2 约束（模块级）
- 公共 API 有文档
- 遵循命名规范

### P3 约束（实现级）
- 代码格式化
- Conventional Commits
```

### 方法2: 项目级配置

在 VS Code 的 Copilot 设置中：
1. 打开 Settings (Cmd/Ctrl + ,)
2. 搜索 "copilot instructions"
3. 添加指令文件路径

## 使用方式

Copilot 会自动读取 `.github/copilot-instructions.md`。

### 在代码中触发
```javascript
// 输入注释触发 SOP 流程
// SOP: spec - 分析并实现用户登录功能

function login() {
  // Copilot 会参考 SOP 规范生成代码
}
```

## 与 Agent/Command 对比

| 功能 | Copilot | mumu-sop |
|------|---------|----------|
| 工作流引导 | 通过指令 | 通过 Agent |
| 命令入口 | 不支持 | `/spec`, `/plan` 等 |
| 约束检查 | 提示 | 自动验证 |
| 契约驱动 | 弱 | 强 |

## 推荐配置

### `.vscode/settings.json`
```json
{
  "github.copilot.instructions": [
    ".github/copilot-instructions.md"
  ],
  "github.copilot.enable": {
    "*": true,
    "markdown": true
  }
}
```

## 注意事项

- Copilot 不支持完整的 6 阶段工作流
- 主要提供代码级别的指导
- 建议配合 mumu-sop 插件使用以获得完整功能

---

**相关文档**: [mumu-sop 完整文档](../../index.md)
