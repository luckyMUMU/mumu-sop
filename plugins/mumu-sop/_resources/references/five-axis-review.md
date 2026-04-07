---
name: five-axis-review
description: |
  五轴代码审查参考文档。
  定义代码审查的五个核心维度：Correctness, Readability, Architecture, Security, Performance。
version: 1.0.0
---

# 五轴代码审查参考

## 概述

五轴代码审查是 mumu-sop 的核心质量保证机制。每个审查必须覆盖以下五个维度：

| 轴 | 英文 | 核心问题 | 对应层级 |
|---|------|---------|---------|
| 1 | **Correctness** | 代码是否按声称的方式工作？ | P2/P3 |
| 2 | **Readability** | 其他工程师能否理解此代码？ | P3 |
| 3 | **Architecture** | 变更是否符合系统设计？ | P2/P1 |
| 4 | **Security** | 变更是否引入漏洞？ | P0 |
| 5 | **Performance** | 变更是否引入性能问题？ | P1 |

---

## Axis 1: Correctness（正确性）

### 核心问题
代码是否按声称的方式工作？

### 检查清单

- [ ] **需求匹配**: 代码是否符合规范或任务需求？
- [ ] **边界处理**: 边界情况是否处理（null、空值、边界值）？
- [ ] **错误路径**: 错误路径是否处理（不只是快乐路径）？
- [ ] **测试覆盖**: 是否通过所有测试？测试是否测试正确内容？
- [ ] **逻辑错误**: 是否存在差一错误、竞态条件或状态不一致？

### 常见陷阱

**陷阱 1: 仅测试快乐路径**
```javascript
// ❌ 错误：只测试正常情况
test('should add two numbers', () => {
  expect(add(2, 3)).toBe(5);
});

// ✅ 正确：测试边界和错误情况
test('add', () => {
  expect(add(2, 3)).toBe(5);           // 正常情况
  expect(add(-1, 1)).toBe(0);          // 负数
  expect(add(0, 0)).toBe(0);           // 零值
  expect(() => add(null, 1)).toThrow(); // null 处理
});
```

**陷阱 2: 忽视并发问题**
```javascript
// ❌ 错误：无锁访问共享状态
let counter = 0;
app.get('/count', () => counter++);

// ✅ 正确：使用原子操作或锁
const counter = new AtomicInteger();
app.get('/count', () => counter.incrementAndGet());
```

### 相关 Skill
- sop-code-reviewer
- sop-test-implementer

---

## Axis 2: Readability & Simplicity（可读性与简洁性）

### 核心问题
其他工程师能否在不解释的情况下理解此代码？

### 检查清单

- [ ] **命名清晰**: 命名是否描述性且符合项目约定？
- [ ] **控制流**: 控制流是否直接（避免嵌套三元、深层回调）？
- [ ] **逻辑组织**: 代码是否逻辑组织（相关代码分组、清晰模块边界）？
- [ ] **避免巧妙**: 是否存在可简化的"巧妙"技巧？
- [ ] **代码长度**: **能否用更少行数完成？**
- [ ] **抽象价值**: **抽象是否值得其复杂性？**（第三次使用才泛化）

### 代码长度标准

| 范围 | 评价 | 行动 |
|------|------|------|
| ~100 行 | ✅ 好 | 可一次审查完成 |
| ~300 行 | ⚠️ 可接受 | 如果是单一逻辑变更 |
| ~1000 行 | ❌ 太大 | 必须拆分 |

### 常见陷阱

**陷阱 1: 过早抽象**
```javascript
// ❌ 错误：只有一次使用就抽象
const calculate = (a, b, operation) => {
  if (operation === 'add') return a + b;
  if (operation === 'sub') return a - b;
};

// ✅ 正确：第三次使用再抽象
const add = (a, b) => a + b;
const sub = (a, b) => a - b;
// 第三次使用时：
// const calculate = (a, b, op) => op(a, b);
```

**陷阱 2: 无意义注释**
```javascript
// ❌ 错误：注释显而易见的内容
// Increment counter
counter++;

// ✅ 正确：解释非显而易见的意图
// Reset counter on date change to prevent overflow
counter = 0;
```

### 相关 Skill
- sop-code-reviewer
- sop-code-simplification (未来)

---

## Axis 3: Architecture（架构）

### 核心问题
变更是否符合系统设计？

### 检查清单

- [ ] **模式遵循**: 是否遵循现有模式或引入新模式？
- [ ] **模块边界**: 是否保持干净模块边界？
- [ ] **代码重复**: 是否存在应共享的代码重复？
- [ ] **依赖方向**: 依赖是否流向正确方向（无循环依赖）？
- [ ] **抽象级别**: 抽象级别是否适当（不过度工程、不过度耦合）？

### 依赖方向原则

```
✅ 正确方向（内层不依赖外层）:
Domain → Application → Infrastructure
  ↑           ↑            ↑
核心业务    应用逻辑     基础设施

❌ 错误方向:
Domain ──X──→ Infrastructure（违反依赖原则）
```

### 常见陷阱

**陷阱 1: 循环依赖**
```javascript
// ❌ 错误：A → B → C → A
import { B } from './B';  // A 依赖 B
// B.js
import { C } from './C';  // B 依赖 C
// C.js
import { A } from './A';  // C 依赖 A（循环！）

// ✅ 正确：依赖关系为 DAG（有向无环图）
// 提取共享依赖到 D
// A → D, B → D, C → D
```

### 相关 Skill
- sop-architecture-reviewer
- sop-implementation-designer

---

## Axis 4: Security（安全）

### 核心问题
变更是否引入漏洞？

### 检查清单

- [ ] **输入验证**: 用户输入是否验证和清理？
- [ ] **密钥管理**: 密钥是否远离代码、日志和版本控制？
- [ ] **认证授权**: 认证/授权是否在需要时检查？
- [ ] **SQL注入**: SQL查询是否参数化？
- [ ] **XSS防护**: 输出是否编码以防止 XSS？
- [ ] **依赖安全**: 依赖是否来自可信来源且无已知漏洞？

### OWASP Top 10 对应

| 风险 | 防护措施 | 检查点 |
|------|---------|--------|
| 注入攻击 | 参数化查询 | SQL/NoSQL/命令注入 |
| 失效身份认证 | 强密码策略 | 认证流程安全 |
| 敏感数据暴露 | 加密传输 | HTTPS/TLS |
| XXE | 禁用外部实体 | XML解析器配置 |
| 访问控制 | 最小权限原则 | 授权检查 |
| 安全配置错误 | 安全配置 | 默认配置安全 |
| XSS | 输出编码 | HTML/JS/CSS注入 |
| 反序列化 | 输入验证 | 反序列化安全 |
| 组件漏洞 | 依赖扫描 | 已知 CVE |
| 日志监控 | 安全日志 | 审计日志 |

### 常见陷阱

**陷阱 1: SQL注入**
```javascript
// ❌ 错误：字符串拼接查询
const query = `SELECT * FROM users WHERE id = ${userId}`;

// ✅ 正确：参数化查询
const query = 'SELECT * FROM users WHERE id = ?';
db.query(query, [userId]);
```

**陷阱 2: 硬编码密钥**
```javascript
// ❌ 错误：密钥在代码中
const API_KEY = 'sk-1234567890abcdef';

// ✅ 正确：从环境变量读取
const API_KEY = process.env.API_KEY;
```

### 相关 Skill
- sop-code-reviewer
- sop-security-and-hardening (未来)

---

## Axis 5: Performance（性能）

### 核心问题
变更是否引入性能问题？

### 检查清单

- [ ] **N+1查询**: 是否存在 N+1 查询模式？
- [ ] **无界循环**: 是否存在无界循环或无约束数据获取？
- [ ] **同步阻塞**: 是否存在应改为异步的同步操作？
- [ ] **UI渲染**: UI组件是否存在不必要重渲染？
- [ ] **分页缺失**: 列表端点是否缺少分页？
- [ ] **大对象**: 热路径中是否创建大对象？

### 性能指标（Core Web Vitals）

| 指标 | 目标 | 工具 |
|------|------|------|
| LCP | < 2.5s | Lighthouse |
| FID | < 100ms | Chrome DevTools |
| CLS | < 0.1 | PageSpeed Insights |
| TTFB | < 600ms | WebPageTest |

### 常见陷阱

**陷阱 1: N+1 查询**
```javascript
// ❌ 错误：循环内查询
for (const user of users) {
  const orders = await db.orders.find({ userId: user.id });
}

// ✅ 正确：批量查询
const userIds = users.map(u => u.id);
const orders = await db.orders.find({ userId: { $in: userIds } });
```

**陷阱 2: 缺少分页**
```javascript
// ❌ 错误：获取全部数据
app.get('/users', async () => {
  return await db.users.findAll();
});

// ✅ 正确：分页查询
app.get('/users', async (req) => {
  const { page = 1, limit = 20 } = req.query;
  return await db.users.findAndCountAll({
    offset: (page - 1) * limit,
    limit: parseInt(limit)
  });
});
```

### 相关 Skill
- sop-performance-reviewer
- sop-browser-testing

---

## 审查流程

### 标准审查步骤

```
1. 准备阶段
   ├─ 阅读设计文档
   ├─ 理解变更范围
   └─ 确认审查标准

2. 逐轴审查
   ├─ Correctness（正确性）
   ├─ Readability（可读性）
   ├─ Architecture（架构）
   ├─ Security（安全）
   └─ Performance（性能）

3. 汇总报告
   ├─ 分类问题（blocker/warning/info）
   ├─ 提供改进建议
   └─ 给出审查结论
```

### 审查结论标准

| 结论 | 标准 | 行动 |
|------|------|------|
| ✅ Approve | 改善整体代码健康 | 合并 |
| ⚠️ Approve with comments | 有小问题但不阻止 | 合并后修复 |
| ❌ Request changes | 有 blocker 问题 | 修复后重新审查 |

---

## 与其他插件的对比

### mumu-sop vs agent-skills

| 维度 | mumu-sop | agent-skills |
|------|---------|--------------|
| 审查轴数 | 5轴 | 5轴（相同） |
| 层级映射 | P0-P3 | 无明确层级 |
| 约束集成 | 强 | 弱 |
| 审查报告 | JSON契约 | 文本描述 |

---

## 参考文档

- [sop-code-reviewer](../skills/sop-code-reviewer/SKILL.md)
- [sop-performance-reviewer](../skills/sop-performance-reviewer/SKILL.md)
- [sop-architecture-reviewer](../skills/sop-architecture-reviewer/SKILL.md)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Core Web Vitals](https://web.dev/vitals/)

---

**版本**: 1.0.0
**最后更新**: 2026-04-07
