# sop-test-implementation 示例

## 输入示例

```
BDD 场景：创建订单

Given 用户已登录
When 用户提交订单，包含商品 A（单价 100 元，数量 2）
Then 系统创建订单，总价为 200 元
And 订单状态为"待支付"
```

## 输出示例

```typescript
// tests/order/order-test.ts

describe('Order', () => {
  describe('创建订单', () => {
    it('应该创建订单并计算总价', () => {
      // Given
      const user = UserBuilder.create().build();
      const product = ProductBuilder.create()
        .withName('商品 A')
        .withPrice(Money.fromYuan(100))
        .build();

      // When
      const order = Order.create(user.id);
      order.addItem(product, 2);

      // Then
      expect(order.totalPrice).toEqual(Money.fromYuan(200));
      expect(order.status).toEqual(OrderStatus.PENDING_PAYMENT);
    });
  });
});
```

## 测试结构模板

```typescript
describe('模块名', () => {
  describe('功能场景', () => {
    it('测试用例描述', () => {
      // Given - 准备测试数据

      // When - 执行测试操作

      // Then - 验证测试结果
    });
  });
});
```

## 测试最佳实践

1. **AAA 模式**：Arrange, Act, Assert
2. **单一职责**：每个测试只验证一个行为
3. **独立性**：测试之间无依赖
4. **可重复**：多次执行结果一致