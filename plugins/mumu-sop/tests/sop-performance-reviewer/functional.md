# sop-performance-reviewer 功能测试

## 测试用例 1: N+1 查询检测

**Given**:
- 代码包含 ORM 循环查询
- 代码位置: `src/services/user.ts`

**When**:
执行 sop-performance-reviewer

**Then**:
- [ ] 检测到 N+1 查询模式
- [ ] 定位到具体代码行
- [ ] 提供优化建议（批量查询）
- [ ] 估计优化效果

## 测试用例 2: 缺少分页检测

**Given**:
- API 端点返回全部数据
- 无分页参数

**When**:
执行 sop-performance-reviewer

**Then**:
- [ ] 检测到无约束数据获取
- [ ] 标记严重程度为 blocker
- [ ] 建议添加分页

## 测试用例 3: Core Web Vitals 测量

**Given**:
- 前端项目
- 页面已部署

**When**:
执行 sop-performance-reviewer

**Then**:
- [ ] 测量 LCP、FID、CLS
- [ ] 对比目标值
- [ ] 标记未达标的指标
- [ ] 提供优化建议

## 测试用例 4: 内存泄漏检测

**Given**:
- 组件未清理事件监听
- 存在内存泄漏风险

**When**:
执行 sop-performance-reviewer

**Then**:
- [ ] 检测到未清理的资源
- [ ] 提供修复建议
- [ ] 严重程度标记为 blocker

## 测试用例 5: 热路径优化建议

**Given**:
- 高频调用函数
- 函数内创建大对象

**When**:
执行 sop-performance-reviewer

**Then**:
- [ ] 识别热路径
- [ ] 检测大对象创建
- [ ] 建议对象池或缓存

---

**测试日期**: 2026-04-07
**预期结果**: 功能测试通过率 ≥ 90%
