# sop-code-review 示例

## 输入示例

```
代码变更：
- 新增 Order.cancel() 方法
- 新增 OrderItem 类
- 新增单元测试
```

## 输出示例

```json
{
  "review_date": "2026-03-01T10:00:00Z",
  "review_status": "passed",
  "coverage": {
    "overall": 95,
    "core_modules": 100,
    "details": {
      "Order": 100,
      "OrderItem": 100,
      "OrderRepository": 90
    }
  },
  "issues": [
    {
      "severity": "警告",
      "location": "src/order/OrderRepository.ts:45",
      "description": "缺少错误日志记录"
    }
  ],
  "security_scan": {
    "status": "passed",
    "vulnerabilities": []
  }
}
```

## 审查检查清单

### 代码规范
- [ ] 命名清晰有意义
- [ ] 函数单一职责
- [ ] 无重复代码
- [ ] 适当的注释

### 安全检查
- [ ] 无硬编码密钥
- [ ] 输入验证完整
- [ ] 无 SQL 注入风险
- [ ] 无 XSS 漏洞

### 性能考虑
- [ ] 无 N+1 查询
- [ ] 适当的缓存
- [ ] 资源正确释放

### 测试覆盖
- [ ] 核心模块 100%
- [ ] 边界条件测试
- [ ] 异常场景测试