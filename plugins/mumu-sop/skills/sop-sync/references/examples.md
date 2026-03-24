# sop-document-sync 示例

## 输入示例

```
代码变更：
- 新增 Order.cancel() 方法
- 修改 OrderItem 类
```

## 输出示例

```
文档更新：
1. src/order/design.md
   - 新增 Order.cancel() 方法说明
   - 更新 OrderItem 类图

2. docs/api/order-api.md
   - 新增 POST /orders/{id}/cancel 接口文档

3. docs/changelog.md
   - 记录订单取消功能新增
```

## 文档同步检查清单

### 设计文档同步
- [ ] 类结构变更已记录
- [ ] 方法签名已更新
- [ ] 类图/时序图已更新

### API 文档同步
- [ ] 新增接口已记录
- [ ] 参数变更已更新
- [ ] 响应格式已更新

### 变更日志同步
- [ ] 变更日期已记录
- [ ] 变更内容已描述
- [ ] 影响范围已说明

## 代码-文档映射表模板

```yaml
mappings:
  - code_path: "src/order/Order.ts"
    doc_paths:
      - "src/order/design.md"
      - "docs/api/order-api.md"

  - code_path: "src/user/UserService.ts"
    doc_paths:
      - "src/user/design.md"
      - "docs/api/user-api.md"
```