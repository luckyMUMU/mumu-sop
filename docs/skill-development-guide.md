# Claude Code Skill 开发完全指南

> 本文档整合自 Anthropic 官方文档《The Complete Guide to Building Skills for Claude》及社区最佳实践，结合 mumu-sop 项目实践经验编写。

---

## 目录

1. [概述](#1-概述)
2. [核心概念](#2-核心概念)
3. [技术规范](#3-技术规范)
4. [规划与设计](#4-规划与设计)
5. [编写最佳实践](#5-编写最佳实践)
6. [常用模式](#6-常用模式)
7. [测试与迭代](#7-测试与迭代)
8. [分发与部署](#8-分发与部署)
9. [故障排除](#9-故障排除)
10. [快速检查清单](#10-快速检查清单)
11. [附录：完整示例](#11-附录完整示例)

---

## 1. 概述

### 1.1 什么是 Skill？

Skill 是一组指令的集合——打包成简单的文件夹——教 Claude 如何处理特定任务或工作流。Skills 是自定义 Claude 以满足特定需求最强大的方式之一。

**核心价值**：
- 无需在每次对话中重复解释偏好、流程和领域知识
- 一次教学，终身受益
- 跨 Claude.ai、Claude Code 和 API 平台通用

**适用场景**：
- 从规范生成前端设计
- 使用一致的方法论进行研究
- 创建遵循团队风格指南的文档
- 编排多步骤流程
- 与 MCP 集成配合使用

### 1.2 Skill 的价值

| 场景 | 没有 Skill | 有 Skill |
|------|------------|----------|
| 工作流指导 | 用户每次重复说明 | 自动激活 |
| 结果一致性 | 因提示词差异而不一致 | 嵌入最佳实践 |
| 学习曲线 | 高，需要探索 | 低，开箱即用 |
| Token 消耗 | 高，需多轮澄清 | 低，直接执行 |

### 1.3 学习目标

阅读本文档后，您将能够：
- 理解 Skill 的技术要求和最佳实践
- 设计独立 Skill 和 MCP 增强工作流
- 测试、迭代和分发您的 Skill
- 在 15-30 分钟内构建一个可工作的 Skill

---

## 2. 核心概念

### 2.1 文件结构

```
your-skill-name/
├── SKILL.md              # 必需 - 主技能文件
├── scripts/              # 可选 - 可执行代码
│   ├── process_data.py
│   └── validate.sh
├── references/           # 可选 - 参考文档
│   ├── api-guide.md
│   └── examples/
└── assets/               # 可选 - 模板、资源
    └── report-template.md
```

### 2.2 核心设计原则

#### 渐进式披露（Progressive Disclosure）

Skill 使用三层系统：

| 层级 | 内容 | 加载时机 |
|------|------|----------|
| **第一层** | YAML frontmatter | 始终加载到系统提示词 |
| **第二层** | SKILL.md 正文 | Claude 认为相关时加载 |
| **第三层** | 链接文件 | 按需加载 |

**优势**：最小化 Token 使用，同时保持专业化能力。

#### 可组合性（Composability）

Claude 可以同时加载多个 Skill。您的 Skill 应该：
- 与其他 Skill 协同工作
- 不假设自己是唯一可用的能力

#### 可移植性（Portability）

Skill 在 Claude.ai、Claude Code 和 API 间通用，前提是环境支持所需依赖。

### 2.3 Skill 与 MCP 的关系

**厨房比喻**：
- **MCP 提供厨房**：工具、食材、设备的访问权限
- **Skill 提供食谱**：如何创造价值的步骤说明

| MCP（连接性） | Skill（知识） |
|---------------|---------------|
| 连接 Claude 到服务（Notion、Asana、Linear 等） | 教 Claude 如何有效使用服务 |
| 提供实时数据访问和工具调用 | 捕获工作流和最佳实践 |
| 定义 Claude 能做什么 | 定义 Claude 应该怎么做 |

---

## 3. 技术规范

### 3.1 关键规则

#### 命名规范

| 项目 | 规则 | 正确示例 | 错误示例 |
|------|------|----------|----------|
| 文件名 | 必须是 `SKILL.md`（区分大小写） | `SKILL.md` | `skill.md`, `SKILL.MD` |
| 文件夹名 | kebab-case | `notion-project-setup` | `Notion Project Setup` |
| Skill name | kebab-case，无空格/大写 | `my-cool-skill` | `MyCoolSkill`, `my_cool_skill` |

#### 安全限制

```yaml
# ❌ 禁止
name: claude-helper        # "claude" 为保留字
name: anthropic-tool       # "anthropic" 为保留字
description: Use <tag>     # 禁止 XML 标签
```

### 3.2 YAML Frontmatter

#### 最小必需格式

```yaml
---
name: your-skill-name
description: What it does. Use when user asks to [specific phrases].
---
```

#### 完整格式

```yaml
---
name: skill-name
description: |
  What it does and when to use it.
  Include specific trigger phrases.
license: MIT                           # 可选
compatibility: "Requires Python 3.8+"  # 可选
metadata:                              # 可选
  author: Your Name
  version: 1.0.0
  mcp-server: server-name
  category: productivity
  tags: [project-management, automation]
  documentation: https://example.com/docs
---
```

#### 字段说明

| 字段 | 必需 | 说明 |
|------|------|------|
| `name` | ✅ | kebab-case，匹配文件夹名 |
| `description` | ✅ | 包含「做什么」+「何时使用」，<1024字符 |
| `license` | ❌ | 开源许可证：MIT、Apache-2.0 |
| `compatibility` | ❌ | 环境要求说明，1-500字符 |
| `metadata` | ❌ | 自定义键值对 |

### 3.3 Description 字段编写指南

Description 是 Skill 最重要的部分——它决定了 Claude 何时加载您的 Skill。

#### 结构公式

```
[做什么] + [何时使用] + [关键能力]
```

#### 优秀示例

```yaml
# ✅ 具体、可操作
description: |
  Analyzes Figma design files and generates developer handoff documentation.
  Use when user uploads .fig files, asks for "design specs",
  "component documentation", or "design-to-code handoff".

# ✅ 包含触发词
description: |
  Manages Linear project workflows including sprint planning,
  task creation, and status tracking. Use when user mentions
  "sprint", "Linear tasks", "project planning", or asks to "create tickets".

# ✅ 明确价值主张
description: |
  End-to-end customer onboarding workflow for PayFlow.
  Handles account creation, payment setup, and subscription management.
  Use when user says "onboard new customer", "set up subscription",
  or "create PayFlow account".
```

#### 错误示例

```yaml
# ❌ 太模糊
description: Helps with projects.

# ❌ 缺少触发条件
description: Creates sophisticated multi-page documentation systems.

# ❌ 太技术化，无用户触发词
description: Implements the Project entity model with hierarchical relationships.
```

---

## 4. 规划与设计

### 4.1 从用例开始

在编写任何代码之前，确定 2-3 个具体用例。

#### 用例模板

```markdown
Use Case: Project Sprint Planning

Trigger: User says "help me plan this sprint" or "create sprint tasks"

Steps:
1. Fetch current project status from Linear (via MCP)
2. Analyze team velocity and capacity
3. Suggest task prioritization
4. Create tasks in Linear with proper labels and estimates

Result: Fully planned sprint with tasks created
```

#### 自问问题

- 用户想要完成什么？
- 这需要哪些多步骤工作流？
- 需要哪些工具（内置或 MCP）？
- 应该嵌入哪些领域知识或最佳实践？

### 4.2 Skill 用例分类

| 类别 | 用途 | 示例 |
|------|------|------|
| **类别1：文档与资产创建** | 创建一致的输出 | `frontend-design`, `docx`, `pptx` |
| **类别2：工作流自动化** | 多步骤流程 | `skill-creator` |
| **类别3：MCP 增强** | 增强 MCP 工具访问 | `sentry-code-review` |

### 4.3 定义成功标准

#### 定量指标

| 指标 | 目标 | 测量方法 |
|------|------|----------|
| 触发准确率 | 90% 相关查询触发 | 运行 10-20 个测试查询 |
| 工具调用效率 | 减少 X 次调用 | 对比有无 Skill 的调用次数 |
| API 失败率 | 0 次/工作流 | 监控 MCP 服务器日志 |

#### 定性指标

- 用户无需提示 Claude 下一步
- 工作流无需用户纠正即可完成
- 新用户首次尝试即可完成任务

---

## 5. 编写最佳实践

### 5.1 SKILL.md 结构模板

```markdown
---
name: your-skill
description: [What and When]
---

# Your Skill Name

## 指令

### 步骤 1: [第一步]
清晰解释发生什么。

示例：
```bash
python scripts/fetch_data.py --project-id PROJECT_ID
```

预期输出：[描述成功状态]

### 步骤 2: [第二步]
...

## 示例

### 示例 1: [常见场景]
用户说: "Set up a new marketing campaign"
动作:
1. Fetch existing campaigns via MCP
2. Create new campaign with provided parameters
结果: Campaign created with confirmation link

## 故障排除

### 错误: [常见错误消息]
原因: [为什么发生]
解决: [如何修复]
```

### 5.2 指令编写原则

#### 具体且可操作

```markdown
# ✅ 好的写法
Run `python scripts/validate.py --input {filename}` to check data format.
If validation fails, common issues include:
- Missing required fields (add them to the CSV)
- Invalid date formats (use YYYY-MM-DD)

# ❌ 差的写法
Validate the data before proceeding.
```

#### 包含错误处理

```markdown
## 常见问题

### MCP 连接失败
如果看到 "Connection refused":
1. 验证 MCP 服务器运行中: 检查 Settings > Extensions
2. 确认 API 密钥有效
3. 尝试重新连接: Settings > Extensions > [Your Service] > Reconnect
```

#### 清晰引用捆绑资源

```markdown
Before writing queries, consult `references/api-patterns.md` for:
- Rate limiting guidance
- Pagination patterns
- Error codes and handling
```

#### 使用渐进式披露

- 保持 SKILL.md 专注于核心指令
- 详细文档移至 `references/`
- 链接而非内联

---

## 6. 常用模式

### 6.1 模式一：顺序工作流编排

**适用场景**：用户需要按特定顺序执行多步骤流程。

```markdown
## 工作流: 客户入职

### 步骤 1: 创建账户
调用 MCP 工具: `create_customer`
参数: name, email, company

### 步骤 2: 设置支付
调用 MCP 工具: `setup_payment_method`
等待: 支付方式验证

### 步骤 3: 创建订阅
调用 MCP 工具: `create_subscription`
参数: plan_id, customer_id (来自步骤1)

### 步骤 4: 发送欢迎邮件
调用 MCP 工具: `send_email`
模板: welcome_email_template
```

**关键技术**：
- 明确步骤顺序
- 步骤间依赖关系
- 每阶段验证
- 失败回滚指令

### 6.2 模式二：多 MCP 协调

**适用场景**：工作流跨越多个服务。

```markdown
## 设计到开发交接

### 阶段 1: 设计导出 (Figma MCP)
1. 从 Figma 导出设计资产
2. 生成设计规范
3. 创建资产清单

### 阶段 2: 资产存储 (Drive MCP)
1. 在 Drive 创建项目文件夹
2. 上传所有资产
3. 生成分享链接

### 阶段 3: 任务创建 (Linear MCP)
1. 创建开发任务
2. 附加资产链接
3. 分配给工程团队

### 阶段 4: 通知 (Slack MCP)
1. 向 #engineering 发布交接摘要
2. 包含资产链接和任务引用
```

**关键技术**：
- 清晰的阶段划分
- MCP 间数据传递
- 进入下一阶段前验证
- 集中错误处理

### 6.3 模式三：迭代优化

**适用场景**：输出质量随迭代提升。

```markdown
## 迭代报告创建

### 初始草稿
1. 通过 MCP 获取数据
2. 生成初版报告
3. 保存到临时文件

### 质量检查
1. 运行验证脚本: `scripts/check_report.py`
2. 识别问题:
   - 缺失章节
   - 格式不一致
   - 数据验证错误

### 优化循环
1. 解决每个识别的问题
2. 重新生成受影响的章节
3. 重新验证
4. 重复直到满足质量阈值

### 最终化
1. 应用最终格式
2. 生成摘要
3. 保存最终版本
```

**关键技术**：
- 明确质量标准
- 迭代改进
- 验证脚本
- 知道何时停止迭代

### 6.4 模式四：上下文感知工具选择

**适用场景**：相同结果，不同上下文使用不同工具。

```markdown
## 智能文件存储

### 决策树
1. 检查文件类型和大小
2. 确定最佳存储位置:
   - 大文件 (>10MB): 使用云存储 MCP
   - 协作文档: 使用 Notion/Docs MCP
   - 代码文件: 使用 GitHub MCP
   - 临时文件: 使用本地存储

### 执行存储
根据决策:
- 调用适当的 MCP 工具
- 应用服务特定的元数据
- 生成访问链接

### 向用户提供上下文
解释为什么选择该存储方式
```

### 6.5 模式五：领域特定智能

**适用场景**：Skill 添加超出工具访问的专业知识。

```markdown
## 支付处理与合规

### 处理前（合规检查）
1. 通过 MCP 获取交易详情
2. 应用合规规则:
   - 检查制裁名单
   - 验证司法管辖区允许
   - 评估风险级别
3. 记录合规决策

### 处理
IF 合规通过:
  - 调用支付处理 MCP 工具
  - 应用适当的欺诈检查
  - 处理交易
ELSE:
  - 标记审查
  - 创建合规案例

### 审计追踪
- 记录所有合规检查
- 记录处理决策
- 生成审计报告
```

---

## 7. 测试与迭代

### 7.1 测试层级

| 层级 | 方法 | 适用场景 |
|------|------|----------|
| 手动测试 | Claude.ai 直接查询 | 快速迭代，无需设置 |
| 脚本测试 | Claude Code 自动化 | 可重复验证 |
| API 测试 | Skills API | 系统化评估套件 |

### 7.2 触发测试

**目标**：确保 Skill 在正确时机加载。

```markdown
### 应该触发
- "Help me set up a new ProjectHub workspace"
- "I need to create a project in ProjectHub"
- "Initialize a ProjectHub project for Q4 planning"

### 不应触发
- "What's the weather in San Francisco?"
- "Help me write Python code"
- "Create a spreadsheet" (除非 ProjectHub skill 处理表格)
```

### 7.3 功能测试

```markdown
Test: Create project with 5 tasks
Given: Project name "Q4 Planning", 5 task descriptions
When: Skill executes workflow
Then:
  - Project created in ProjectHub
  - 5 tasks created with correct properties
  - All tasks linked to project
  - No API errors
```

### 7.4 迭代反馈

| 问题信号 | 解决方案 |
|----------|----------|
| **触发不足**：Skill 不在应该加载时加载 | 添加更多触发词，特别是技术术语 |
| **过度触发**：Skill 在无关查询时加载 | 添加负面触发词，更具体描述 |
| **执行问题**：结果不一致、API 失败 | 改进指令，添加错误处理 |

### 7.5 使用 skill-creator

```markdown
# 创建 Skill
"Use the skill-creator skill to help me build a skill for [your use case]"

# 审查 Skill
"Review this skill and suggest improvements"

# 迭代改进
"Use the issues & solution identified in this chat to improve how the skill handles [specific edge case]"
```

---

## 8. 分发与部署

### 8.1 当前分发模型（2026年1月）

**个人用户获取 Skill**：
1. 下载 Skill 文件夹
2. 压缩文件夹（如需要）
3. 上传到 Claude.ai: Settings > Capabilities > Skills
4. 或放置到 Claude Code skills 目录

**组织级 Skill**：
- 管理员可部署工作区范围
- 自动更新
- 集中管理

### 8.2 推荐分发方式

```markdown
1. 在 GitHub 托管
   - 公开仓库用于开源 Skill
   - 清晰的 README 和安装说明
   - 示例用法和截图

2. 在 MCP 文档中记录
   - 从 MCP 文档链接到 Skill
   - 解释同时使用两者的价值
   - 提供快速入门指南

3. 创建安装指南
   ## 安装 [Your Service] Skill
   1. 下载 Skill:
      - 克隆仓库: `git clone https://github.com/yourcompany/skills`
      - 或从 Releases 下载 ZIP
   2. 安装到 Claude:
      - 打开 Claude.ai > Settings > Skills
      - 点击 "Upload skill"
      - 选择 Skill 文件夹（压缩）
   3. 启用 Skill:
      - 开启 [Your Service] Skill
      - 确保 MCP 服务器已连接
   4. 测试:
      - 询问 Claude: "Set up a new project in [Your Service]"
```

### 8.3 Skill 定位

**关注结果，而非功能**：

```markdown
# ✅ 好的定位
"The ProjectHub skill enables teams to set up complete project workspaces
in seconds — including pages, databases, and templates — instead of
spending 30 minutes on manual setup."

# ❌ 差的定位
"The ProjectHub skill is a folder containing YAML frontmatter and
Markdown instructions that calls our MCP server tools."
```

**强调 MCP + Skill 故事**：

```markdown
"Our MCP server gives Claude access to your Linear projects.
Our skills teach Claude your team's sprint planning workflow.
Together, they enable AI-powered project management."
```

---

## 9. 故障排除

### 9.1 Skill 无法上传

| 错误 | 原因 | 解决方案 |
|------|------|----------|
| "Could not find SKILL.md" | 文件名不正确 | 重命名为 `SKILL.md`（区分大小写） |
| "Invalid frontmatter" | YAML 格式错误 | 检查 `---` 分隔符、引号闭合 |
| "Invalid skill name" | 名称包含空格或大写 | 使用 kebab-case |

### 9.2 Skill 不触发

**诊断步骤**：
1. 检查 description 是否太泛化
2. 是否包含用户实际会说的触发词
3. 是否提及相关文件类型

**调试方法**：
```
询问 Claude: "When would you use the [skill name] skill?"
Claude 会引用 description 回复，据此调整。
```

### 9.3 Skill 过度触发

**解决方案**：

1. **添加负面触发词**：
```yaml
description: |
  Advanced data analysis for CSV files. Use for statistical modeling,
  regression, clustering. Do NOT use for simple data exploration
  (use data-viz skill instead).
```

2. **更具体**：
```yaml
# 太宽泛
description: Processes documents

# 更具体
description: Processes PDF legal documents for contract review
```

### 9.4 MCP 连接问题

**检查清单**：
1. 验证 MCP 服务器已连接（Settings > Extensions）
2. 检查认证（API 密钥有效、权限正确）
3. 独立测试 MCP（不使用 Skill）
4. 验证工具名称正确（区分大小写）

### 9.5 指令未被遵循

| 原因 | 解决方案 |
|------|----------|
| 指令太冗长 | 保持简洁，使用项目符号和编号列表 |
| 关键指令被埋没 | 将关键指令放在顶部，使用 `## Important` 标题 |
| 语言模糊 | 使用 CRITICAL 标记，明确验证步骤 |

**高级技巧**：对于关键验证，考虑捆绑脚本以编程方式执行检查。

---

## 10. 快速检查清单

### 开发前

- [ ] 确定 2-3 个具体用例
- [ ] 识别所需工具（内置或 MCP）
- [ ] 阅读本指南和示例 Skill
- [ ] 规划文件夹结构

### 开发中

- [ ] 文件夹使用 kebab-case 命名
- [ ] SKILL.md 文件存在（精确拼写）
- [ ] YAML frontmatter 有 `---` 分隔符
- [ ] name 字段：kebab-case，无空格，无大写
- [ ] description 包含「做什么」和「何时使用」
- [ ] 无 XML 标签（`< >`）
- [ ] 指令清晰可操作
- [ ] 包含错误处理
- [ ] 提供示例
- [ ] 清晰链接参考文件

### 上传前

- [ ] 测试明显任务触发
- [ ] 测试改写请求触发
- [ ] 验证不触发无关主题
- [ ] 功能测试通过
- [ ] 工具集成正常（如适用）
- [ ] 压缩为 .zip 文件

### 上传后

- [ ] 在真实对话中测试
- [ ] 监控触发不足/过度触发
- [ ] 收集用户反馈
- [ ] 迭代 description 和指令
- [ ] 更新 metadata 中的版本

---

## 11. 附录：完整示例

### 11.1 简单 Skill 示例

```markdown
---
name: code-review-checklist
description: |
  Provides comprehensive code review checklists for different programming
  languages. Use when reviewing code, conducting PR reviews, or when user
  asks for "code review checklist", "PR review guidelines", or "review criteria".
---

# Code Review Checklist

## 触发条件
Use this skill when:
- User asks to review code
- User mentions "PR review", "code review", "pull request"
- User uploads code files for review

## 通用检查项

### 代码质量
- [ ] 命名清晰有意义
- [ ] 函数单一职责
- [ ] 无重复代码
- [ ] 适当的注释

### 安全检查
- [ ] 无硬编码密钥
- [ ] 输入验证完整
- [ ] 无 SQL 注入风险
- [ ] 无 XSS 漏洞

### 性能考虑
- [ ] 无 N+1 查询
- [ ] 适当的缓存
- [ ] 资源正确释放

## 语言特定检查

### Python
- [ ] 类型提示完整
- [ ] 文档字符串规范
- [ ] 异常处理适当

### JavaScript/TypeScript
- [ ] TypeScript 类型完整
- [ ] 异步错误处理
- [ ] 依赖项安全

## 输出格式

Review Report:
- 总体评分: [1-10]
- 关键问题: [列表]
- 建议改进: [列表]
- 详细评论: [按文件]
```

### 11.2 MCP 增强 Skill 示例

```markdown
---
name: linear-sprint-planning
description: |
  Automates Linear sprint planning workflow including capacity analysis,
  task prioritization, and sprint creation. Use when user mentions
  "sprint planning", "plan sprint", "Linear sprint", or asks to
  "create sprint tasks".
metadata:
  author: Engineering Team
  version: 1.0.0
  mcp-server: linear
  category: project-management
---

# Linear Sprint Planning

## 概述
此 Skill 自动化 Linear 冲刺规划工作流，包括容量分析、任务优先级排序和冲刺创建。

## 前提条件
- Linear MCP 服务器已连接
- 用户有项目访问权限

## 工作流

### 步骤 1: 收集当前状态
通过 Linear MCP 获取：
```javascript
// 调用 MCP 工具
linear.listProjects()
linear.listTeams()
linear.listIssues({ status: "backlog" })
```

### 步骤 2: 分析容量
1. 获取团队成员
2. 计算可用工时
3. 考虑假期和会议

### 步骤 3: 任务优先级
基于以下因素排序：
- 业务价值
- 依赖关系
- 风险级别
- 工时估算

### 步骤 4: 创建冲刺
```javascript
// 创建新冲刺
linear.createCycle({
  name: "Sprint XX",
  startDate: "YYYY-MM-DD",
  endDate: "YYYY-MM-DD"
})

// 分配任务到冲刺
linear.updateIssue({
  id: issueId,
  cycleId: cycleId
})
```

### 步骤 5: 通知团队
通过 Slack MCP 发送冲刺摘要。

## 错误处理

### Linear 连接失败
1. 检查 Settings > Extensions > Linear 状态
2. 验证 API 密钥有效
3. 确认权限范围正确

### 无可用容量
- 建议调整冲刺范围
- 识别可延期的任务
- 提供权衡建议

## 示例交互

**用户**: "帮我规划下个冲刺"

**响应**:
1. 获取当前待办任务
2. 分析团队容量
3. 推荐冲刺内容
4. 等待确认后创建

## 输出模板

```
📋 Sprint Planning Report

Team: [Team Name]
Sprint: [Sprint Name]
Duration: [Start] - [End]

Capacity:
- Total: X person-days
- Available: Y person-days
- Committed: Z person-days

Tasks Selected:
| Priority | Task | Effort | Assignee |
|----------|------|--------|----------|
| 1 | ... | 2d | @user1 |
| 2 | ... | 1d | @user2 |

Risks & Notes:
- [风险1]
- [注意事项]
```
```

---

## 参考资源

### 官方文档
- [Best Practices Guide](https://docs.anthropic.com)
- [Skills Documentation](https://docs.anthropic.com/skills)
- [API Reference](https://docs.anthropic.com/api)
- [MCP Documentation](https://modelcontextprotocol.io)

### 示例仓库
- [anthropics/skills](https://github.com/anthropics/skills) - 官方 Skill 示例
- [Document Skills](https://github.com/anthropics/skills) - PDF, DOCX, PPTX, XLSX

### 工具
- **skill-creator**: 内置于 Claude.ai，可生成和审查 Skill

### 支持
- 技术问题：Claude Developers Discord
- Bug 报告：[GitHub Issues](https://github.com/anthropics/skills/issues)

---

**文档版本**: v1.0.0
**最后更新**: 2026-03-20
**来源**: Anthropic 官方文档 + mumu-sop 实践经验