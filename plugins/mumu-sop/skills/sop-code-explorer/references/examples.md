# sop-code-explorer 示例

## 输入示例

```
规范要求：
- 订单创建功能
- 订单取消功能（仅限未发货订单）
- 订单查询功能
```

## 输出示例

```json
{
  "analysis_date": "2026-03-01T10:00:00Z",
  "spec_document": "specs/order-spec.md",
  "existing_implementations": [
    {
      "feature": "订单创建",
      "location": "src/order/OrderAppService.ts",
      "status": "完整实现",
      "notes": "符合规范要求"
    },
    {
      "feature": "订单查询",
      "location": "src/order/OrderAppService.ts",
      "status": "完整实现",
      "notes": "支持按用户ID查询"
    }
  ],
  "missing_implementations": [
    {
      "feature": "订单取消",
      "reason": "未实现",
      "priority": "高"
    }
  ],
  "constraint_violations": [
    {
      "constraint": "P0-禁止硬编码密钥",
      "location": "src/order/OrderRepository.ts:15",
      "severity": "严重",
      "description": "发现硬编码的数据库连接字符串"
    }
  ]
}
```

## 分析报告格式

```json
{
  "analysis_date": "ISO8601时间戳",
  "spec_document": "规范文档路径",
  "existing_implementations": [
    {
      "feature": "功能名称",
      "location": "代码位置",
      "status": "完整实现|部分实现",
      "notes": "备注"
    }
  ],
  "missing_implementations": [
    {
      "feature": "缺失功能",
      "reason": "原因",
      "priority": "高|中|低"
    }
  ],
  "constraint_violations": [
    {
      "constraint": "约束名称",
      "location": "违反位置",
      "severity": "严重|警告",
      "description": "描述"
    }
  ]
}
```