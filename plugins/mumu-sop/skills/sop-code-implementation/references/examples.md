# sop-code-implementation 示例

## 输入示例

```
设计文档：
class Order {
  addItem(product: Product, quantity: number): void;
  cancel(): Result<void, OrderError>;
}
```

## 输出示例

```typescript
// src/order/Order.ts

export class Order {
  private items: OrderItem[] = [];

  addItem(product: Product, quantity: number): void {
    if (quantity <= 0) {
      throw new Error('数量必须大于 0');
    }

    const existingItem = this.items.find(
      item => item.productId === product.id
    );

    if (existingItem) {
      existingItem.quantity += quantity;
    } else {
      this.items.push(new OrderItem(product, quantity));
    }

    this.calculateTotal();
  }

  cancel(): Result<void, OrderError> {
    if (this.status === OrderStatus.SHIPPED) {
      return Err({ type: 'ORDER_ALREADY_SHIPPED' });
    }

    this.status = OrderStatus.CANCELLED;
    return Ok(undefined);
  }
}
```

## 实现顺序原则

1. **从依赖方到被依赖方**：先实现被其他模块依赖的基础模块
2. **依赖来源必须准确**：依赖关系应基于设计文档或架构文档
3. **无法确定依赖时提问**：不得假设依赖关系

## 实现顺序示例

```
正确的实现顺序：
1. 数据模型
2. 仓储接口
3. 业务逻辑
4. 应用服务
5. 控制器

错误示例：先实现 Controller，发现缺少 Service，再回头实现
```