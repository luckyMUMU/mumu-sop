# Spring/Java 代码检查要点

## 事务管理检查要点

```java
// ❌ 错误：自调用导致事务失效
public class OrderService {
    public void placeOrder(Order order) {
        this.createOrder(order);  // 自调用，事务不生效
    }

    @Transactional
    public void createOrder(Order order) {
        // ...
    }
}

// ✅ 正确：通过注入自身或提取服务
public class OrderService {
    @Lazy
    @Autowired
    private OrderService self;

    public void placeOrder(Order order) {
        self.createOrder(order);  // 代理调用，事务生效
    }
}
```

## 依赖注入检查要点

```java
// ❌ 错误：字段注入
@Autowired
private UserRepository userRepository;

// ✅ 正确：构造器注入
private final UserRepository userRepository;

public UserService(UserRepository userRepository) {
    this.userRepository = userRepository;
}
```

## N+1 查询检查要点

```java
// ❌ 错误：N+1 查询问题
List<Order> orders = orderRepository.findAll();
for (Order order : orders) {
    List<OrderItem> items = orderItemRepository.findByOrderId(order.getId());  // N 次查询
}

// ✅ 正确：使用 JOIN FETCH 或批量查询
@Query("SELECT o FROM Order o LEFT JOIN FETCH o.items")
List<Order> findAllWithItems();
```

## 集合初始化检查要点

```java
// ❌ 错误：未指定初始容量
List<String> list = new ArrayList<>();
Map<String, String> map = new HashMap<>();

// ✅ 正确：预估容量初始化
List<String> list = new ArrayList<>(expectedSize);
Map<String, String> map = new HashMap<>((int) (expectedSize / 0.75) + 1);
```

## 输入校验检查要点

```java
// ❌ 错误：缺少参数校验
public void createUser(User user) {
    userRepository.save(user);
}

// ✅ 正确：使用 Bean Validation
public void createUser(@Valid @RequestBody User user) {
    userRepository.save(user);
}
```

## 敏感信息检查要点

```java
// ❌ 错误：日志打印敏感信息
log.info("User login: password={}", user.getPassword());

// ✅ 正确：脱敏处理
log.info("User login: phone={}", maskPhone(user.getPhone()));
```