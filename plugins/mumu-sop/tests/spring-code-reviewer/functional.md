# spring-code-reviewer 功能测试

## 测试 1: Spring 事务审查

### 输入
```java
@Service
public class OrderService {
    public void batchCreate(List<OrderDto> orders) {
        for (OrderDto dto : orders) {
            createOrder(dto);
        }
    }

    @Transactional
    public void createOrder(OrderDto dto) {
        // 创建订单逻辑
    }
}
```

### 预期行为
- 识别事务边界问题
- 标记为 High 级别
- 建议事务提升到外层

### 验证点
- [ ] 是否识别了长事务风险
- [ ] 是否提供了重构建议
- [ ] 是否符合 Spring 最佳实践

---

## 测试 2: JPA N+1 检测

### 输入
```java
@Repository
public class OrderRepository {
    public List<Order> findAll() {
        return entityManager.createQuery("SELECT o FROM Order o", Order.class)
            .getResultList();
    }
}

// 使用处
List<Order> orders = orderRepository.findAll();
for (Order order : orders) {
    System.out.println(order.getItems().size()); // N+1 问题
}
```

### 预期行为
- 识别 N+1 查询风险
- 建议 JOIN FETCH 或批量查询

### 验证点
- [ ] 是否识别了 N+1 问题
- [ ] 是否提供了优化方案

---

## 测试 3: 安全漏洞检测

### 输入
```java
@RestController
public class UserController {
    @GetMapping("/users/{id}")
    public User getUser(@PathVariable String id) {
        return userRepository.findById(id).orElse(null);
    }
}
```

### 预期行为
- 检查权限控制
- 检查数据脱敏需求
- 检查输入验证

### 验证点
- [ ] 是否检查了访问控制
- [ ] 是否检查了敏感数据处理

---

**测试日期**: 2026-03-20