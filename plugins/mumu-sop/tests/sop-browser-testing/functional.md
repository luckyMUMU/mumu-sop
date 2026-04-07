# sop-browser-testing 功能测试

## 测试用例 1: DOM 元素检查

**Given**:
- 页面已加载
- 需要验证元素存在

**When**:
执行 sop-browser-testing

**Then**:
- [ ] 成功连接到 Chrome DevTools
- [ ] 定位指定元素
- [ ] 验证元素属性
- [ ] 返回检查结果

## 测试用例 2: 控制台错误捕获

**Given**:
- 页面有 JavaScript 错误
- 控制台有警告信息

**When**:
执行 sop-browser-testing

**Then**:
- [ ] 捕获所有控制台日志
- [ ] 分类错误和警告
- [ ] 报告错误详情
- [ ] 测试状态标记为 failed

## 测试用例 3: 网络请求验证

**Given**:
- 页面发起 API 请求
- 需要验证请求格式

**When**:
执行 sop-browser-testing

**Then**:
- [ ] 监控网络请求
- [ ] 验证请求 URL
- [ ] 验证请求参数
- [ ] 验证响应状态

## 测试用例 4: Core Web Vitals 测量

**Given**:
- 前端项目
- 需要性能指标

**When**:
执行 sop-browser-testing

**Then**:
- [ ] 测量 LCP
- [ ] 测量 FID
- [ ] 测量 CLS
- [ ] 对比目标阈值

## 测试用例 5: 用户交互模拟

**Given**:
- 需要测试按钮点击
- 验证交互后 DOM 变化

**When**:
执行 sop-browser-testing

**Then**:
- [ ] 模拟用户点击
- [ ] 等待 DOM 更新
- [ ] 验证元素变化
- [ ] 截图对比（可选）

## 测试用例 6: MCP 连接失败处理

**Given**:
- Chrome 未以 debug 模式启动
- MCP 服务器未运行

**When**:
执行 sop-browser-testing

**Then**:
- [ ] 检测连接失败
- [ ] 提供错误信息
- [ ] 给出启动指南
- [ ] 优雅降级

---

**测试日期**: 2026-04-07
**预期结果**: 功能测试通过率 ≥ 90%
