# 文档创建示例

## 输入示例

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

## 输出示例

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