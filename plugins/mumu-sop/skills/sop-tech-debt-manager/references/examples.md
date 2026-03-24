# 技术债务管理示例

本文档提供技术债务识别、评估和偿还的常见场景和示例。

---

## 技术债务分类

### 1. 代码债务 (Code Debt)

**识别信号**:
- 代码重复（DRY 违反）
- 过长的方法/类
- 复杂的条件逻辑
- 魔法数字/字符串
- 缺少测试覆盖

**示例**:
```java
// 技术债务：重复的验证逻辑
public void processOrder(Order order) {
    if (order == null) throw new IllegalArgumentException("Order cannot be null");
    if (order.getItems() == null) throw new IllegalArgumentException("Items cannot be null");
    if (order.getItems().isEmpty()) throw new IllegalArgumentException("Items cannot be empty");
    // ... 处理订单
}

public void processRefund(Refund refund) {
    if (refund == null) throw new IllegalArgumentException("Refund cannot be null");
    if (refund.getItems() == null) throw new IllegalArgumentException("Items cannot be null");
    if (refund.getItems().isEmpty()) throw new IllegalArgumentException("Items cannot be empty");
    // ... 处理退款
}
```

**偿还方案**:
```java
// 提取通用验证器
public class Validator {
    public static <T> void requireNonNull(T obj, String name) {
        if (obj == null) throw new IllegalArgumentException(name + " cannot be null");
    }
    public static void requireNonEmpty(Collection<?> collection, String name) {
        requireNonNull(collection, name);
        if (collection.isEmpty()) throw new IllegalArgumentException(name + " cannot be empty");
    }
}
```

---

### 2. 架构债务 (Architecture Debt)

**识别信号**:
- 循环依赖
- 分层违规
- 紧耦合
- 缺少抽象层

**示例 - 循环依赖**:
```
Module A → Module B → Module C → Module A
```

**偿还方案**:
```
1. 识别共同依赖
2. 提取到新模块 D
3. 重构依赖方向

Module A → Module D ← Module B
                ↑
Module C ────────┘
```

---

### 3. 测试债务 (Test Debt)

**识别信号**:
- 低测试覆盖率
- 测试不稳定（flaky tests）
- 缺少集成测试
- 测试运行缓慢

**评估模板**:
```yaml
module: user-service
test_coverage: 45%
target_coverage: 80%
missing_areas:
  - path: src/main/java/com/example/service/UserService.java
    coverage: 32%
    priority: HIGH
  - path: src/main/java/com/example/repository/UserRepository.java
    coverage: 78%
    priority: LOW
flaky_tests: 3
estimated_effort: "2 周"
```

---

### 4. 文档债务 (Documentation Debt)

**识别信号**:
- 过时的文档
- 缺少 API 文档
- 缺少架构决策记录 (ADR)
- 缺少入职文档

---

## 技术债务评估矩阵

| 影响程度 | 还债成本 | 优先级 | 处理策略 |
|----------|----------|--------|----------|
| 高 | 低 | P0 | 立即处理 |
| 高 | 高 | P1 | 纳入计划 |
| 低 | 低 | P2 | 机会性处理 |
| 低 | 高 | P3 | 监控但不主动处理 |

---

## 债务偿还计划模板

```yaml
debt_id: TD-2024-001
title: 重构用户认证模块
category: 架构债务
impact: 高
effort: 中
priority: P1

current_state:
  issues:
    - 认证逻辑散落在多个类中
    - 缺少单元测试
    - 硬编码的配置

target_state:
  - 统一的认证服务
  - 90% 测试覆盖率
  - 配置外部化

repayment_plan:
  - phase: 1
    task: 提取认证服务接口
    effort: "2 天"
    status: pending
  - phase: 2
    task: 实现新认证服务
    effort: "3 天"
    status: pending
  - phase: 3
    task: 迁移现有调用
    effort: "2 天"
    status: pending
  - phase: 4
    task: 添加测试覆盖
    effort: "2 天"
    status: pending

metrics:
  before:
    code_coverage: 35%
    cyclomatic_complexity: 25
  target:
    code_coverage: 90%
    cyclomatic_complexity: 10
```

---

## 技术债务检查清单

- [ ] 是否识别了所有债务类型？
- [ ] 是否评估了影响和成本？
- [ ] 是否创建了偿还计划？
- [ ] 是否设置了跟踪指标？
- [ ] 是否定期审查债务状态？