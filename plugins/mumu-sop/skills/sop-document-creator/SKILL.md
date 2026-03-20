---
name: sop-document-creator
version: 1.1.0
description: |
  Creates technical documents (specs, designs, APIs, READMEs) following best practices.
  触发词: create document, 创建文档, 写文档, 生成README, generate documentation.
license: MIT
compatibility: "Language-agnostic, works with any programming language and framework"
metadata:
  author: luckyMUMU
  category: documentation
  tags: [document, documentation, readme, spec]
  language_agnostic: true
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

> 详细模板参见 [templates.md](references/templates.md)

## 指令

### 步骤 1: 分析文档需求

1. 确定文档类型
2. 识别目标读者
3. 确定文档范围
4. 收集必要信息

### 步骤 2: 选择文档模板

根据文档类型选择合适的模板。所有模板均包含：
- YAML 元数据头（version, created, updated, status）
- 清晰的标题层级
- 标准化章节结构

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

  sop_compliance:
    - 符合 P0 约束（无敏感信息）
    - 符合文档规范
```

### 步骤 5: 生成文档

1. 确定输出路径
2. 创建文档文件
3. 写入内容
4. 验证文件完整性

## 最佳实践

### 结构原则

- **层次分明**：使用清晰的标题层级
- **逻辑有序**：内容按逻辑顺序组织
- **易于导航**：提供目录和锚点

### 内容原则

- **准确性**：信息准确无误
- **完整性**：覆盖所有必要内容
- **简洁性**：避免冗余描述

### 格式原则

- **一致性**：全文档格式统一
- **可读性**：适当使用空行和分段
- **代码块**：指定语言类型

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
      issues: []

postconditions:
  - "文档已创建"
  - "质量检查已通过"

invariants:
  - "文档必须包含元数据头"
  - "敏感信息不得出现在文档中"
```

## 常见坑

| 坑 | 现象 | 解决 |
|---|------|------|
| 元数据缺失 | 难以追踪变更 | 始终使用模板创建 |
| 结构混乱 | 标题层级混乱 | 按模板层级填充 |
| 内容不完整 | 缺少关键章节 | 使用质量检查清单 |
| 敏感信息泄露 | 包含密钥密码 | 创建前检查脱敏 |

## 相关文档

- [文档模板集合](references/templates.md)
- [文档创建示例](references/examples.md)
- [Skill 索引](../../index.md)
- [文档同步 Skill](../sop-document-sync/SKILL.md)