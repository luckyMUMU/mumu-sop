---
version: v1.0.0
template_type: scenarios
language_agnostic: true
---

# BDD 场景模板

> **用途**: 定义 BDD (Behavior-Driven Development) 测试场景
> **存储路径**: `.sop/specs/{change-id}/specs/scenarios.md`
> **参考**: Gherkin 语法规范

---

## 基本结构

```gherkin
Feature: [功能名称]

  Scenario: [场景名称]
    Given [前置条件]
    When [操作步骤]
    Then [预期结果]
```

---

## 详细模板

```markdown
---
change_id: CHG-YYYYMMDD-NNN
created: YYYY-MM-DDTHH:MM:SSZ
version: 1.0.0
---

# BDD 场景

## 功能列表索引

| Feature ID | 功能名称 | 场景数 | 状态 |
|------------|---------|--------|------|
| F-001 | [功能名] | 3 | 待验证 |
| F-002 | [功能名] | 5 | 待验证 |

---

## Feature: [功能名称]

**Feature ID**: F-XXX
**优先级**: P0 | P1 | P2
**关联需求**: FR-XXX

### 背景 (Background)

```gherkin
Background:
  Given 用户已登录系统
  And 系统处于正常状态
```

### Scenario 1: [正常场景名称]

```gherkin
Scenario: [场景名称]
  Given [前置条件1]
  And [前置条件2]
  When 用户执行 [操作]
  Then 系统应该 [预期结果1]
  And 系统应该 [预期结果2]
```

**测试数据**:
| 字段 | 值 |
|------|-----|
| [字段名] | [值] |

### Scenario 2: [异常场景名称]

```gherkin
Scenario: [异常场景名称]
  Given [前置条件]
  When 用户执行 [操作] 但 [异常条件]
  Then 系统应该返回错误 "[错误信息]"
  And 系统应该 [异常处理结果]
```

**错误码**:
| 错误码 | 描述 |
|--------|------|
| ERR-001 | [错误描述] |

### Scenario 3: [边界场景名称]

```gherkin
Scenario Outline: [边界场景名称]
  Given 输入值为 <input>
  When 用户执行 [操作]
  Then 系统应该返回 <result>

  Examples:
    | input | result |
    | 0     | 最小值  |
    | 100   | 最大值  |
    | -1    | 错误    |
    | 101   | 错误    |
```

---

## Feature: [下一个功能名称]

### Scenario: [场景名称]

```gherkin
Scenario: [场景名称]
  Given [前置条件]
  When [操作]
  Then [结果]
```

---

## 场景覆盖矩阵

| 功能需求 | 场景ID | 正常 | 异常 | 边界 | 安全 |
|----------|--------|------|------|------|------|
| FR-001 | S-001 | ✓ | | | |
| FR-001 | S-002 | | ✓ | | |
| FR-001 | S-003 | | | ✓ | |
| FR-002 | S-004 | ✓ | | | ✓ |

---

## 场景类型说明

### 1. 正常场景 (Happy Path)

验证功能在正常输入和条件下按预期工作。

```gherkin
Scenario: 用户成功创建订单
  Given 用户已登录
  And 购物车中有商品
  When 用户提交订单
  Then 订单创建成功
  And 订单状态为"待支付"
  And 用户收到订单确认通知
```

### 2. 异常场景 (Error Path)

验证功能在异常输入或条件下能正确处理错误。

```gherkin
Scenario: 支付失败后订单状态正确
  Given 用户已登录
  And 存在待支付订单
  When 支付系统返回失败
  Then 订单状态保持"待支付"
  And 用户收到支付失败通知
  And 用户可以重新发起支付
```

### 3. 边界场景 (Boundary)

验证功能在边界值条件下的行为。

```gherkin
Scenario Outline: 订单金额边界验证
  Given 用户选择 <count> 个商品
  And 商品单价为 <price>
  When 用户提交订单
  Then 订单总金额应为 <total>

  Examples:
    | count | price | total |
    | 1     | 0.01  | 0.01  |
    | 99    | 100   | 9900  |
    | 100   | 100   | 10000 |
```

### 4. 安全场景 (Security)

验证功能的安全相关行为。

```gherkin
Scenario: 未授权用户无法访问敏感数据
  Given 用户未登录
  When 用户请求获取个人信息
  Then 系统返回 401 未授权错误
  And 不返回任何敏感数据
```

### 5. 并发场景 (Concurrency)

验证功能在并发条件下的行为。

```gherkin
Scenario: 并发下单库存正确扣减
  Given 商品库存为 10
  When 10个用户同时下单购买1件
  Then 所有订单创建成功
  And 商品库存为 0
  When 第11个用户尝试下单
  Then 返回库存不足错误
```

---

## 场景优先级

| 优先级 | 描述 | 场景类型 |
|--------|------|---------|
| P0 | 核心功能，必须通过 | 正常场景 + 关键异常 |
| P1 | 重要功能，应该通过 | 异常场景 + 边界场景 |
| P2 | 次要功能，建议通过 | 安全场景 + 并发场景 |

---

## 测试数据准备

### 固定测试数据

```yaml
test_data:
  users:
    - id: user-001
      name: 测试用户A
      role: admin
    - id: user-002
      name: 测试用户B
      role: member
  products:
    - id: prod-001
      name: 测试商品
      price: 99.99
      stock: 100
```

### 动态生成数据

```gherkin
Scenario: 使用动态数据测试
  Given 生成随机用户 "<random_user>"
  When 用户注册
  Then 注册成功
```

---

## 自动化测试映射

| 场景ID | 测试文件 | 测试函数 | 状态 |
|--------|---------|---------|------|
| S-001 | order.test.js | shouldCreateOrderSuccessfully | 待实现 |
| S-002 | order.test.js | shouldHandlePaymentFailure | 待实现 |

---

## 相关文档

- [需求规范](./requirements.md)
- [设计文档](../design.md)
- [检查清单](../checklist.md)