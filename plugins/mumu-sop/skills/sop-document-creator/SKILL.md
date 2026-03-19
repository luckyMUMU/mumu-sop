---
name: sop-document-creator
version: 1.0.0
description: Use when creating new technical documents (specs, designs, APIs, READMEs), generating document structures based on best practices, organizing existing content into standardized documents, or creating SOP-compliant documents. Don't use when syncing existing docs (use sop-document-sync), analyzing requirements (use sop-requirement-analyst), designing architecture (use sop-architecture-design), or reviewing code (use sop-code-review).
---

# sop-document-creator

## 描述

文档创建 Skill 负责根据最佳实践创建各类技术文档。该 Skill 确保文档符合 SOP 体系规范，具有清晰的结构、完整的元数据和良好的可读性。

主要职责：
- 创建符合最佳实践的技术文档
- 应用标准文档模板和结构
- 确保文档元数据完整
- 验证文档质量

## 使用场景

触发此 Skill 的条件：

1. **新文档创建**：需要创建新的技术文档
2. **内容整理**：需要将散乱内容整理为规范文档
3. **文档标准化**：需要将现有文档转换为标准格式
4. **模板应用**：需要根据模板生成文档

## 文档类型支持

| 类型 | 触发词 | 模板 | 输出路径 |
|------|--------|------|----------|
| 规范文档 | spec, specification | specs/{name}-spec.md | specs/ |
| 设计文档 | design, architecture | docs/design/{name}.md | docs/design/ |
| API文档 | api, interface | docs/api/{name}.md | docs/api/ |
| README | readme, intro | README.md | 项目根目录 |
| CHANGELOG | changelog, history | CHANGELOG.md | 项目根目录 |
| 提案文档 | proposal, rfc | docs/proposals/{name}.md | docs/proposals/ |
| 归档文档 | archive, record | archives/{name}-archive.md | archives/ |

## 指令

### 步骤 1: 分析文档需求

1. 确定文档类型
2. 识别目标读者
3. 确定文档范围
4. 收集必要信息

```yaml
analysis_checklist:
  - document_type: 文档类型是否明确
  - target_audience: 目标读者是否清晰
  - scope: 文档范围是否确定
  - required_sections: 必需章节是否识别
  - existing_content: 是否有现有内容可参考
```

### 步骤 2: 选择文档模板

根据文档类型选择合适的模板：

#### 规范文档模板

```markdown
---
version: v1.0.0
created: YYYY-MM-DD
updated: YYYY-MM-DD
status: draft|review|approved
---

# [规范名称]

## 概述

[简要描述规范的目的和范围]

## 背景

[为什么需要这个规范]

## 规范内容

### [核心规则1]

[详细描述]

### [核心规则2]

[详细描述]

## 约束条件

[适用条件和限制]

## 示例

[规范应用示例]

## 相关文档

- [相关文档链接]
```

#### 设计文档模板

```markdown
---
version: v1.0.0
created: YYYY-MM-DD
updated: YYYY-MM-DD
status: draft|review|approved
---

# [设计名称]

## 设计目标

[明确设计要解决的问题]

## 设计方案

### 架构概览

[整体架构描述]

### 核心组件

[组件说明]

### 接口定义

[接口描述]

## 设计决策

| 决策 | 选择 | 原因 |
|------|------|------|
| [决策点] | [选择] | [原因] |

## 风险与缓解

| 风险 | 影响 | 缓解措施 |
|------|------|----------|
| [风险] | [影响] | [措施] |

## 实施计划

[实施步骤]
```

#### API文档模板

```markdown
---
version: v1.0.0
base_url: /api/v1
---

# [API名称]

## 概述

[API功能描述]

## 端点

### [端点名称]

**方法**: `GET|POST|PUT|DELETE`

**路径**: `/api/v1/resource`

**描述**: [端点描述]

#### 请求参数

| 参数 | 类型 | 必需 | 描述 |
|------|------|------|------|
| param1 | string | 是 | 参数描述 |

#### 请求示例

```json
{
  "param1": "value1"
}
```

#### 响应

| 状态码 | 描述 |
|--------|------|
| 200 | 成功 |
| 400 | 参数错误 |

#### 响应示例

```json
{
  "code": 200,
  "data": {}
}
```

## 错误码

| 错误码 | 描述 |
|--------|------|
| E001 | 错误描述 |
```

#### README模板

```markdown
# [项目名称]

[项目简介，一句话描述项目功能]

## 特性

- 特性1
- 特性2

## 快速开始

### 安装

```bash
npm install package-name
```

### 使用

```javascript
const module = require('package-name');
module.doSomething();
```

## 文档

- [API文档](docs/api.md)
- [设计文档](docs/design.md)

## 贡献指南

[贡献指南]

## 许可证

[许可证]
```

#### CHANGELOG模板

```markdown
# 更新日志

本项目的所有重要变更都将记录在此文件中。

格式基于 [Keep a Changelog](https://keepachangelog.com/)，
版本号遵循 [语义化版本](https://semver.org/)。

## [Unreleased]

### 新增
- [待发布的新功能]

## [1.0.0] - YYYY-MM-DD

### 新增
- [新功能]

### 变更
- [变更内容]

### 修复
- [Bug修复]

### 移除
- [移除的功能]

### 安全
- [安全相关变更]
```

### 步骤 3: 填充文档内容

1. 根据模板结构填充内容
2. 确保内容完整、准确
3. 添加必要的示例和说明
4. 保持语言风格一致

### 步骤 4: 文档质量检查

```yaml
quality_checklist:
  structure:
    - 元数据头完整
    - 标题层级正确
    - 章节顺序合理
  
  content:
    - 内容完整无缺失
    - 描述清晰无歧义
    - 示例可运行
    - 链接有效
  
  style:
    - 语言风格一致
    - 术语使用规范
    - 格式统一
  
  sop_compliance:
    - 符合 P0 约束（无敏感信息）
    - 符合文档规范
    - 引用正确
```

### 步骤 5: 生成文档

1. 确定输出路径
2. 创建文档文件
3. 写入内容
4. 验证文件完整性

## 文档最佳实践

### 结构原则

1. **层次分明**：使用清晰的标题层级
2. **逻辑有序**：内容按逻辑顺序组织
3. **易于导航**：提供目录和锚点
4. **重点突出**：重要信息使用格式强调

### 内容原则

1. **准确性**：信息准确无误
2. **完整性**：覆盖所有必要内容
3. **简洁性**：避免冗余描述
4. **可操作性**：提供具体步骤和示例

### 格式原则

1. **一致性**：全文档格式统一
2. **可读性**：适当使用空行和分段
3. **代码块**：指定语言类型
4. **表格**：用于结构化数据

### 元数据规范

```yaml
required_metadata:
  - version: 文档版本
  - created: 创建日期
  - updated: 更新日期

optional_metadata:
  - author: 作者
  - status: 状态（draft|review|approved）
  - tags: 标签
  - related: 相关文档
```

## 契约

### 输入契约

```yaml
required_inputs:
  - name: "document_type"
    type: string
    validation: "必须是支持的文档类型"
    description: "文档类型"
  
  - name: "content_source"
    type: text|object
    validation: "非空"
    description: "内容来源"

optional_inputs:
  - name: "target_path"
    type: string
    description: "目标路径"
  
  - name: "template_override"
    type: string
    description: "自定义模板路径"
  
  - name: "metadata"
    type: object
    description: "额外元数据"
```

### 输出契约

```yaml
required_outputs:
  - name: "document_file"
    type: file
    format: "Markdown"
    guarantees:
      - "文档结构完整"
      - "元数据正确"
      - "格式规范"

  - name: "quality_report"
    type: json
    path: "contracts/doc-quality-report.json"
    format:
      structure_score: 0-100
      content_score: 0-100
      style_score: 0-100
      issues: []

postconditions:
  - "文档已创建"
  - "质量检查已通过"
  - "文档符合 SOP 规范"

invariants:
  - "文档必须包含元数据头"
  - "文档必须通过质量检查"
  - "敏感信息不得出现在文档中"
```

## 常见坑

### 坑 1: 元数据缺失

- **现象**: 文档缺少版本、日期等元数据，导致难以追踪变更。
- **原因**: 未使用标准模板，或创建时遗漏元数据。
- **解决**: 始终使用模板创建文档，确保元数据完整。

### 坑 2: 结构混乱

- **现象**: 文档标题层级混乱，内容组织无序。
- **原因**: 未遵循文档结构原则，随意添加内容。
- **解决**: 使用模板定义的结构，按层级填充内容。

### 坑 3: 内容不完整

- **现象**: 文档缺少关键章节或信息，读者无法理解。
- **原因**: 创建时未考虑读者需求，遗漏必要内容。
- **解决**: 使用质量检查清单，确保内容完整。

### 坑 4: 敏感信息泄露

- **现象**: 文档包含密钥、密码等敏感信息。
- **原因**: 直接复制代码或配置，未进行脱敏处理。
- **解决**: 创建前检查敏感信息，使用占位符替代。

## 示例

### 输入示例

```json
{
  "document_type": "api",
  "content_source": {
    "name": "用户管理API",
    "endpoints": [
      {
        "method": "GET",
        "path": "/users",
        "description": "获取用户列表"
      },
      {
        "method": "POST",
        "path": "/users",
        "description": "创建用户"
      }
    ]
  },
  "target_path": "docs/api/user-api.md"
}
```

### 输出示例

```markdown
---
version: v1.0.0
base_url: /api/v1
created: 2026-03-17
updated: 2026-03-17
---

# 用户管理API

## 概述

用户管理API提供用户的增删改查功能。

## 端点

### 获取用户列表

**方法**: `GET`

**路径**: `/api/v1/users`

**描述**: 获取系统中的用户列表

#### 请求参数

| 参数 | 类型 | 必需 | 描述 |
|------|------|------|------|
| page | integer | 否 | 页码，默认1 |
| size | integer | 否 | 每页数量，默认10 |

#### 响应示例

```json
{
  "code": 200,
  "data": {
    "users": [...],
    "total": 100
  }
}
```

### 创建用户

**方法**: `POST`

**路径**: `/api/v1/users`

**描述**: 创建新用户

...
```

## 相关文档

- [Skill 索引](../../index.md)
- [文档同步 Skill](../sop-document-sync/SKILL.md)
- [模板资源](../../_resources/templates/index.md)
