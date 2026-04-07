---
name: sop-performance-reviewer
version: 1.0.0
description: |
  性能审查 Skill，五轴审查体系之一。
  测量优先的性能检查，包括常见性能问题检测和 Core Web Vitals 验证。
  触发词: performance review, 性能审查, 优化检查, performance check.
license: MIT
compatibility: "Language-agnostic, works with any programming language and framework"
metadata:
  author: luckyMUMU
  category: verification
  tags: [performance, optimization, five-axis, review]
  language_agnostic: true
---

# sop-performance-reviewer

> **五轴审查**: Performance（性能）是代码审查的五个核心维度之一。

## 描述

性能审查 Skill 专注于检测性能问题和优化机会。遵循"测量优先"原则 —— 不猜测，先测量。

## 审查维度

### 1. 测量优先

**开始优化前，必须先有数据：**
- 是否已识别性能瓶颈？
- 是否有性能基准数据？
- 是否有明确的性能目标？

### 2. 常见性能问题检查清单

| 问题类型 | 检查点 | 严重级别 |
|---------|--------|---------|
| **N+1 查询** | ORM 查询是否存在循环内查询 | blocker |
| **无界循环** | 循环是否有明确的终止条件 | blocker |
| **无约束数据获取** | 列表查询是否缺少分页 | blocker |
| **同步阻塞** | 是否应改为异步操作 | warning |
| **UI 重渲染** | 组件是否存在不必要重渲染 | warning |
| **热路径大对象** | 高频调用路径是否创建大对象 | warning |
| **内存泄漏** | 事件监听器是否未清理 | blocker |

### 3. Core Web Vitals（前端项目）

| 指标 | 目标值 | 检查工具 |
|------|--------|---------|
| LCP (Largest Contentful Paint) | < 2.5s | Lighthouse |
| FID (First Input Delay) | < 100ms | Chrome DevTools |
| CLS (Cumulative Layout Shift) | < 0.1 | PageSpeed Insights |
| TTFB (Time to First Byte) | < 600ms | Network tab |

### 4. 后端性能指标

- **API 响应时间**: P99 < 500ms
- **数据库查询**: 单查询 < 100ms
- **缓存命中率**: > 80%
- **并发处理**: 支持预期峰值

## 审查流程

### 步骤 1: 识别热路径
1. 识别高频调用的代码路径
2. 识别用户直接感知的操作
3. 识别资源密集型操作

### 步骤 2: 检查常见反模式
```markdown
❌ N+1 查询示例:
```javascript
// 错误：循环内查询
for (const user of users) {
  const orders = await db.orders.find({ userId: user.id }); // N+1!
}

// 正确：批量查询
const userIds = users.map(u => u.id);
const orders = await db.orders.find({ userId: { $in: userIds } });
```

❌ 无约束数据获取:
```javascript
// 错误：获取所有记录
const allUsers = await db.users.find({}); // 危险！

// 正确：分页查询
const users = await db.users.find({})
  .limit(20)
  .skip((page - 1) * 20);
```

### 步骤 3: 验证测量数据
- 使用性能分析工具收集数据
- 对比基准数据和目标
- 记录测量结果

### 步骤 4: 生成优化建议
- 按严重程度分类问题
- 提供具体优化方案
- 预估优化效果

## 输出格式

```json
{
  "review_date": "2026-04-07T10:00:00Z",
  "review_status": "passed|warning|failed",
  "metrics": {
    "lcp": 2.1,
    "fid": 45,
    "cls": 0.05,
    "api_p99": 420
  },
  "issues": [
    {
      "severity": "blocker|warning|info",
      "category": "database|rendering|memory|network",
      "location": "src/api/users.ts:45",
      "description": "N+1 query pattern detected",
      "recommendation": "Use batch query with $in operator",
      "estimated_impact": "Reduce queries from N+1 to 2"
    }
  ],
  "optimizations": [
    {
      "priority": "high|medium|low",
      "description": "Add pagination to user list",
      "effort": "small|medium|large"
    }
  ]
}
```

## 常见坑

### 坑 1: 过早优化
- **现象**: 在没有测量的情况下进行优化
- **原因**: 猜测性能瓶颈，而非数据驱动
- **解决**: 始终坚持"测量优先"，使用 profiling 工具

### 坑 2: 忽视移动端
- **现象**: 只在桌面端测试性能
- **原因**: 开发环境通常性能更好
- **解决**: 始终在移动设备和弱网环境测试

### 坑 3: 只看平均值
- **现象**: 只关注平均响应时间
- **原因**: P99/P95 更能反映用户体验
- **解决**: 关注百分位数据，特别是尾部延迟

## 相关文档

- [sop-code-reviewer](../sop-code-reviewer/SKILL.md) - 代码审查（包含五轴审查）
- [sop-browser-testing](../sop-browser-testing/SKILL.md) - 浏览器测试（Core Web Vitals）
- [五轴审查指南](../../_resources/references/five-axis-review.md)
