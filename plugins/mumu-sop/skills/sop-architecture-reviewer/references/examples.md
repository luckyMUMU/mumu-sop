# sop-architecture-reviewer 示例

## 输入示例

```
架构设计：
- 分层：表现层、应用层、领域层、基础设施层
- 模块：订单模块、用户模块、商品模块
```

## 输出示例

```json
{
  "review_date": "2026-03-01T10:00:00Z",
  "review_status": "failed",
  "p0_violations": [
    {
      "constraint": "P0-禁止循环依赖",
      "location": "src/order/OrderService.ts",
      "severity": "严重",
      "description": "OrderService 依赖 UserService，UserService 依赖 OrderService"
    }
  ],
  "p1_warnings": [
    {
      "constraint": "P1-API响应时间",
      "location": "src/order/OrderRepository.ts",
      "severity": "警告",
      "description": "订单查询接口响应时间 600ms，超过 500ms 限制"
    }
  ],
  "recommendations": [
    "引入事件机制解耦 OrderService 和 UserService",
    "为订单查询添加缓存层"
  ]
}
```

## P0/P1 约束检查清单

### P0 级约束（必须通过）
- [ ] 无硬编码密钥
- [ ] 无强制解包（unwrap/expect）
- [ ] 无循环依赖
- [ ] 核心模块覆盖率 100%

### P1 级约束（建议通过）
- [ ] API 响应时间 < 500ms
- [ ] 优先使用项目已有库
- [ ] 跨模块接口定义清晰