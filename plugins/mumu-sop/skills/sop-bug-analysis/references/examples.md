# sop-bug-analysis 示例

## 示例 1: P0级安全漏洞

### Bug描述
```
用户可以通过修改URL参数查看其他用户的订单信息
```

### 复现测试
```typescript
it('不应允许用户查看其他用户的订单', async () => {
  // Given: 用户A的订单
  const userA = await createUser();
  const order = await createOrder(userA.id);

  // When: 用户B尝试查看
  const userB = await createUser();
  const result = await orderService.getOrder(userB.id, order.id);

  // Then: 应该拒绝访问
  expect(result.isErr()).toBe(true);
  expect(result.error.type).toBe('ACCESS_DENIED');
});
```

### 根因分析
```yaml
根因: 订单查询接口未验证用户归属
位置: src/order/OrderController.ts:45
影响: 所有订单数据可能被越权访问
严重程度: P0
```

---

## 示例 2: P1级功能失效

### Bug描述
```
订单支付超时后，订单状态未更新，用户无法重新支付
```

### 复现测试
```typescript
it('支付超时后订单应更新为支付失败状态', async () => {
  // Given: 待支付订单
  const order = await createOrder({ status: 'PENDING_PAYMENT' });

  // When: 模拟支付超时
  await paymentService.simulateTimeout(order.paymentId);

  // Then: 订单状态应更新
  const updatedOrder = await orderRepository.findById(order.id);
  expect(updatedOrder.status).toBe('PAYMENT_FAILED');
  expect(updatedOrder.canRetryPayment).toBe(true);
});
```

---

## 示例 3: P2级功能缺陷

### Bug描述
```
商品搜索结果分页显示不正确，第二页显示为空
```

### 复现测试
```typescript
it('搜索结果分页应正确显示', async () => {
  // Given: 25个匹配的商品
  await createProducts(25, { name: '测试商品' });

  // When: 查询第二页
  const result = await searchService.search('测试商品', { page: 2, size: 10 });

  // Then: 应返回第11-20个商品
  expect(result.items.length).toBe(10);
  expect(result.total).toBe(25);
});
```

---

## 根因分析模板

```markdown
## 根因分析报告

### 问题现象
[描述用户观察到的问题]

### 根本原因
[经过分析后定位到的根本原因]

### 代码位置
- 文件: `path/to/file.ts`
- 行号: XX
- 函数/方法: `functionName`

### 问题类型
- [ ] 逻辑错误
- [ ] 边界条件遗漏
- [ ] 类型错误
- [ ] 并发问题
- [ ] 性能问题
- [ ] 依赖问题
- [ ] 配置问题

### 修复方案
[描述修复方案]

### 防止复发
- [ ] 增加单元测试
- [ ] 增加集成测试
- [ ] 增加类型检查
- [ ] 增加监控告警
- [ ] 更新文档
```