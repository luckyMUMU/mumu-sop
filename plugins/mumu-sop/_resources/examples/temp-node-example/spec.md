---
change_id: CHG-20260320-001
parent_constraint: P3-USER-001
status: in_progress
created: 2026-03-20T10:00:00Z
---

# 用户头像上传功能规范

> **规范类型**: 临时子节点（实现规范）
> **引用节点**: P3-USER-001 用户模块实现规范
> **存储路径**: `.trae/specs/CHG-20260320-001/`

---

## 需求概述

实现用户头像上传功能，支持以下能力：
- 上传头像图片
- 裁剪头像
- 显示头像

---

## 功能规范

### 上传头像

| 属性 | 要求 |
|------|------|
| 支持格式 | JPEG, PNG, WebP |
| 最大文件大小 | 5MB |
| 推荐尺寸 | 200x200 ~ 500x500 |
| 存储位置 | 对象存储（S3/OSS） |

### 图片处理

| 处理项 | 说明 |
|--------|------|
| 格式转换 | 统一转换为 WebP 格式存储 |
| 尺寸压缩 | 生成 50x50, 100x100, 200x200 三种尺寸 |
| 质量压缩 | 保持 80% 质量 |

### 接口设计

```
POST /api/v1/users/{userId}/avatar
Content-Type: multipart/form-data

Request:
  - file: 图片文件

Response:
  {
    "code": 0,
    "message": "success",
    "data": {
      "avatarUrl": "https://cdn.example.com/avatars/{userId}.webp",
      "thumbnails": {
        "small": "https://cdn.example.com/avatars/{userId}_50.webp",
        "medium": "https://cdn.example.com/avatars/{userId}_100.webp",
        "large": "https://cdn.example.com/avatars/{userId}_200.webp"
      }
    }
  }
```

---

## 约束继承

### P0 约束遵循

```yaml
- P0-SEC-001: 禁止硬编码密钥
  实现: 使用环境变量配置 S3 密钥

- P0-SEC-003: 禁止关闭安全校验
  实现: 上传前验证文件类型和大小
```

### P1 约束遵循

```yaml
- P1-PERF-001: 接口响应时间
  实现: 异步处理图片，立即返回上传成功

- P1-STOR-001: 存储安全
  实现: 图片存储使用私有桶，通过签名 URL 访问
```

---

## 安全要求

| 要求 | 实现方式 |
|------|----------|
| 文件类型验证 | 检查文件魔数，不仅依赖扩展名 |
| 文件大小限制 | 服务端强制限制 5MB |
| 访问控制 | 仅用户本人可上传自己的头像 |
| 内容安全 | 集成图片审核服务（可选） |

---

## 性能要求

| 指标 | 目标 |
|------|------|
| 上传响应时间 | P95 < 500ms（不含图片处理） |
| 图片处理时间 | < 3s（异步处理） |
| 并发上传 | 支持 100 QPS |

---

## 验收标准

- [ ] 支持上传 JPEG/PNG/WebP 格式图片
- [ ] 拒绝超过 5MB 的文件
- [ ] 正确生成三种尺寸缩略图
- [ ] 上传后可通过 URL 访问头像
- [ ] 单元测试覆盖率 >= 90%
- [ ] 通过安全扫描

---

## 相关文档

- [用户模块规范](../../../specifications/module-spec.md)
- [P3 实现约束](../../../constraints/p3-constraints.md)
- [API 契约](../../../specifications/api-contract.yaml)