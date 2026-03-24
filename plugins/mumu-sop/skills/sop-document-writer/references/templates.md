# 文档模板集合

## 规范文档模板

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

## 设计文档模板

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

## API文档模板

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

## README模板

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

## CHANGELOG模板

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

## 元数据规范

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