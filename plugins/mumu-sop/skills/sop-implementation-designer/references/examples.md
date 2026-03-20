# sop-implementation-designer 示例

## 输入示例

```
架构设计：
- 聚合根: Order
- 仓储接口: OrderRepository
- 应用服务: OrderAppService
```

## 输出示例

```markdown
# 订单模块实现设计

## 类结构

### Order (聚合根)

```typescript
class Order {
  private orderId: OrderId;
  private userId: UserId;
  private status: OrderStatus;
  private items: OrderItem[];
  private totalPrice: Money;
  private createdAt: Date;

  constructor(orderId: OrderId, userId: UserId): Order;

  addItem(product: Product, quantity: number): void;
  cancel(): Result<void, OrderError>;
  calculateTotal(): Money;

  private validateCanCancel(): boolean;
}
```

### OrderRepository (仓储接口)

```typescript
interface OrderRepository {
  save(order: Order): Promise<void>;
  findById(orderId: OrderId): Promise<Option<Order>>;
  findByUserId(userId: UserId): Promise<Order[]>;
}
```

## 错误处理

### 错误类型

```typescript
type OrderError =
  | { type: 'ORDER_ALREADY_SHIPPED' }
  | { type: 'ORDER_ITEM_NOT_FOUND', productId: ProductId }
  | { type: 'INVALID_QUANTITY', quantity: number };
```

## 测试策略

- 单元测试：覆盖 Order 聚合根的所有业务逻辑
- 集成测试：覆盖 OrderRepository 的持久化逻辑
- E2E 测试：覆盖完整的订单创建和取消流程
```

## 类图模板

```
┌─────────────────────────────────────┐
│           Order (聚合根)             │
├─────────────────────────────────────┤
│ - orderId: OrderId                  │
│ - userId: UserId                    │
│ - status: OrderStatus               │
│ - items: OrderItem[]                │
│ - totalPrice: Money                 │
├─────────────────────────────────────┤
│ + addItem(product, quantity): void  │
│ + cancel(): Result<void, Error>     │
│ + calculateTotal(): Money           │
└─────────────────────────────────────┘
              │ 1
              │
              │ *
              ▼
┌─────────────────────────────────────┐
│           OrderItem                 │
├─────────────────────────────────────┤
│ - productId: ProductId              │
│ - quantity: number                  │
│ - unitPrice: Money                  │
└─────────────────────────────────────┘
```