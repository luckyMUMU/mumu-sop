# Spring/Java 代码审查示例

## 输入示例

```
代码变更：添加订单取消功能
分支：feature/order-cancel
变更文件：
- OrderService.java
- OrderRepository.java
- OrderController.java
```

## 输出示例

```json
{
  "review_date": "2026-03-18T10:00:00Z",
  "review_status": "conditional",
  "summary": "代码整体结构清晰，但存在事务边界问题和潜在的 N+1 查询风险，建议修复后再合并。",
  "statistics": {
    "critical": 0,
    "high": 2,
    "medium": 1,
    "low": 1
  },
  "issues": [
    {
      "id": "ISSUE-001",
      "title": "循环内调用事务方法导致长事务",
      "location": "OrderService.java:45",
      "type": "性能",
      "severity": "High",
      "analysis": "在 for 循环中调用 @Transactional 方法，每次迭代都会开启新事务，在大数据量下会导致数据库连接池耗尽。",
      "suggestion": "// 将事务提升到循环外层\n@Transactional\npublic void batchCancelOrders(List<Long> orderIds) {\n    for (Long orderId : orderIds) {\n        cancelOrder(orderId);\n    }\n}"
    },
    {
      "id": "ISSUE-002",
      "title": "N+1 查询问题",
      "location": "OrderRepository.java:30",
      "type": "性能",
      "severity": "High",
      "analysis": "查询订单后遍历获取订单项，会产生 N+1 次数据库查询。",
      "suggestion": "@Query(\"SELECT o FROM Order o LEFT JOIN FETCH o.items WHERE o.id IN :ids\")\nList<Order> findByIdsWithItems(@Param(\"ids\") List<Long> ids);"
    }
  ]
}
```

## 审查报告输出格式

```json
{
  "review_date": "ISO8601 时间戳",
  "review_status": "passed|failed|conditional",
  "summary": "评审综述",
  "statistics": {
    "critical": 0,
    "high": 0,
    "medium": 0,
    "low": 0
  },
  "issues": [
    {
      "id": "问题编号",
      "title": "简洁明了的标题",
      "location": "文件名:行号",
      "type": "功能/性能/安全/规范/可维护性",
      "severity": "Critical/High/Medium/Low",
      "analysis": "深度解析：为什么这是个问题，以及在高负载/特定场景下的潜在影响",
      "suggestion": "重构建议代码片段"
    }
  ]
}
```

## 获取代码变更的 git 命令

```bash
# 获取最近一次提交的变更
git diff HEAD~1 HEAD

# 获取特定分支相对于 main 的变更
git diff main...feature-branch

# 获取特定文件的变更
git diff HEAD~1 HEAD -- path/to/file.java

# 查看提交历史
git log --oneline -10
```