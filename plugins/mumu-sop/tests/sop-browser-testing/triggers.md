# sop-browser-testing 触发测试

## 应该触发

### 英文触发词
- "browser test"
- "chrome test"
- "devtools test"
- "ui test"
- "frontend test"
- "e2e test"
- "dom check"

### 中文触发词
- "浏览器测试"
- "前端测试"
- "UI测试"
- "页面测试"
- "Chrome测试"
- "DevTools测试"

### 改写/同义词
- "测试页面"
- "检查UI"
- "验证前端"
- "浏览器验证"

## 不应触发

### 后端相关
- "api test" (应触发 api testing)
- "unit test" (应触发 test)
- "integration test" (应触发 integration testing)

### 其他
- "安全测试" (应触发 security test)
- "性能测试" (应触发 performance test)

## 边界情况

### 可能误触发
- "界面设计" (可能混淆设计和测试)
- "用户体验" (可能混淆体验和测试)

### 可能漏触发
- "检查页面元素" (需要识别为 DOM 检查)
- "看看控制台报错" (需要识别为 console log 检查)

---

**测试日期**: 2026-04-07
**预期结果**: 触发准确率 ≥ 90%
