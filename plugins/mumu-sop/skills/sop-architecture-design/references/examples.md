# sop-architecture-design 示例

## 输入示例

```
系统需求：订单管理系统
- 支持创建、查询、取消订单
- 订单包含商品、数量、总价
- 用户只能取消未发货订单
```

## 输出示例

```markdown
# 订单系统架构设计

## 分层架构

┌─────────────────────────────────────┐
│         表现层 (Presentation)        │
│   REST API / GraphQL / gRPC         │
└─────────────────────────────────────┘
                  ▼
┌─────────────────────────────────────┐
│         应用层 (Application)         │
│   OrderAppService / QueryService    │
└─────────────────────────────────────┘
                  ▼
┌─────────────────────────────────────┐
│          领域层 (Domain)             │
│   Order / OrderItem / OrderService  │
└─────────────────────────────────────┘
                  ▼
┌─────────────────────────────────────┐
│       基础设施层 (Infrastructure)     │
│   OrderRepository / MessageQueue    │
└─────────────────────────────────────┘

## 领域模型

### 聚合根: Order

- 属性: orderId, userId, status, totalPrice, items
- 行为: create(), addItem(), cancel(), calculateTotal()

### 实体: OrderItem

- 属性: productId, quantity, unitPrice, subtotal

## 仓储接口

interface OrderRepository {
  save(order: Order): void
  findById(orderId: OrderId): Order
  findByUserId(userId: UserId): List<Order>
}
```

## DDD 设计原则

1. **分层清晰**：表现层 → 应用层 → 领域层 → 基础设施层
2. **依赖方向**：外层依赖内层，内层不依赖外层
3. **聚合边界**：小聚合原则，仅保持强一致性
4. **领域事件**：跨聚合使用事件实现最终一致性