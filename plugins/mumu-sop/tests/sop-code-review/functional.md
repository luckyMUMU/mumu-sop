# sop-code-review 功能测试

## 测试 1: 基础代码审查

### 输入
```typescript
function processOrder(order: Order) {
  const result = order.items.map(item => {
    return item.price * item.quantity
  }).reduce((a, b) => a + b)

  if (result > 10000) {
    return { status: 'high_value', discount: 0.1 }
  }
  return { status: 'normal', discount: 0 }
}
```

### 预期输出
- 生成审查报告
- 识别代码质量问题
- 提供改进建议
- 按严重程度分类

### 验证点
- [ ] 是否识别了潜在问题
- [ ] 是否提供了改进建议
- [ ] 是否按严重程度分类

---

## 测试 2: 安全漏洞检测

### 输入
```typescript
function queryUser(userId: string) {
  const sql = `SELECT * FROM users WHERE id = ${userId}`
  return database.query(sql)
}
```

### 预期行为
- 识别 SQL 注入风险
- 标记为 Critical 级别
- 提供参数化查询建议

### 验证点
- [ ] 是否识别了安全漏洞
- [ ] 是否标记为 Critical
- [ ] 是否提供了修复方案

---

## 测试 3: 性能问题检测

### 输入
```typescript
async function getOrdersWithItems(orderIds: string[]) {
  const orders = []
  for (const id of orderIds) {
    const order = await db.findOrder(id)
    const items = await db.findItemsByOrderId(id)
    orders.push({ ...order, items })
  }
  return orders
}
```

### 预期行为
- 识别 N+1 查询问题
- 标记为 High 级别
- 建议批量查询优化

### 验证点
- [ ] 是否识别了 N+1 问题
- [ ] 是否建议了优化方案

---

**测试日期**: 2026-03-20