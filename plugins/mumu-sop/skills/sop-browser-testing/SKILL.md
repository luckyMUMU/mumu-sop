---
name: sop-browser-testing
version: 1.0.0
description: |
  浏览器测试 Skill，使用 Chrome DevTools MCP 进行运行时数据检查。
  支持 DOM 检查、控制台日志、网络追踪、性能分析。
  触发词: browser test, 浏览器测试, devtools, chrome test.
license: MIT
compatibility: "Web applications, frontend projects with browser runtime"
metadata:
  author: luckyMUMU
  category: verification
  tags: [browser, testing, devtools, mcp, frontend]
  language_agnostic: false
  requires: ["Chrome DevTools MCP"]
---

# sop-browser-testing

> **MCP 集成**: 本 Skill 需要 Chrome DevTools MCP 服务器支持。

## 描述

浏览器测试 Skill 通过 Chrome DevTools MCP 获取运行时数据，验证前端应用在实际浏览器环境中的行为。

## MCP 配置

### 1. 安装 MCP 服务器

在项目根目录创建 `.mcp.json`：
```json
{
  "servers": {
    "chrome-devtools": {
      "command": "npx @anthropic-ai/mcp-devtools-server",
      "env": {
        "PORT": "9222"
      }
    }
  }
}
```

### 2. 启动 Chrome with DevTools

```bash
# macOS
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/chrome-dev-profile

# Linux
google-chrome \
  --remote-debugging-port=9222 \
  --user-data-dir=/tmp/chrome-dev-profile
```

## 测试能力

### 1. DOM 检查

验证运行时 DOM 结构：
```javascript
// 检查元素存在
const element = await mcp.devtools.querySelector('#app');

// 检查元素属性
const props = await mcp.devtools.getElementProperties(element);

// 截图对比
const screenshot = await mcp.devtools.captureScreenshot();
```

### 2. 控制台日志

捕获和分析 JavaScript 错误：
```javascript
// 获取控制台日志
const logs = await mcp.devtools.getConsoleLogs();

// 过滤错误
const errors = logs.filter(log => log.level === 'error');

// 检查未处理异常
const exceptions = await mcp.devtools.getExceptions();
```

### 3. 网络追踪

验证 API 请求和响应：
```javascript
// 开始网络监控
await mcp.devtools.startNetworkMonitoring();

// 执行操作
await page.click('#submit-btn');

// 获取网络请求
const requests = await mcp.devtools.getNetworkRequests();

// 检查特定请求
const apiRequest = requests.find(r => r.url.includes('/api/users'));
```

### 4. 性能分析

测量 Core Web Vitals：
```javascript
// 开始性能追踪
await mcp.devtools.startPerformanceTracing();

// 导航到页面
await page.navigate('http://localhost:3000');

// 获取性能指标
const metrics = await mcp.devtools.getPerformanceMetrics();
// { LCP, FID, CLS, TTFB, FCP, TTI }
```

## MCP 使用示例

### 完整测试脚本示例

```javascript
// browser-test-example.js
// 使用 Chrome DevTools MCP 进行完整浏览器测试

async function runBrowserTest() {
  // 1. 连接到 Chrome DevTools
  const browser = await mcp.devtools.connect('http://localhost:9222');
  
  // 2. 打开新标签页
  const page = await browser.newPage();
  
  // 3. 导航到测试页面
  await page.navigate('http://localhost:3000');
  
  // 4. 等待页面加载完成
  await page.waitForLoadState('networkidle');
  
  // 5. 检查控制台错误
  const logs = await page.getConsoleLogs();
  const errors = logs.filter(log => log.level === 'error');
  console.log(`控制台错误数: ${errors.length}`);
  
  // 6. 检查关键元素
  const header = await page.querySelector('h1');
  console.log(`标题存在: ${header !== null}`);
  
  // 7. 测量性能指标
  const metrics = await page.getPerformanceMetrics();
  console.log(`LCP: ${metrics.LCP}ms`);
  console.log(`FID: ${metrics.FID}ms`);
  console.log(`CLS: ${metrics.CLS}`);
  
  // 8. 模拟用户交互
  await page.click('#login-btn');
  await page.waitForTimeout(1000);
  
  // 9. 检查网络请求
  const requests = await page.getNetworkRequests();
  const apiRequests = requests.filter(r => r.url.includes('/api'));
  console.log(`API 请求数: ${apiRequests.length}`);
  
  // 10. 截图
  await page.screenshot({ path: 'test-result.png' });
  
  // 11. 关闭浏览器
  await browser.close();
}

runBrowserTest().catch(console.error);
```

### 与测试框架集成

#### Jest 集成示例

```javascript
// __tests__/browser.test.js
describe('Browser Tests', () => {
  let browser;
  let page;

  beforeAll(async () => {
    browser = await mcp.devtools.connect('http://localhost:9222');
    page = await browser.newPage();
  });

  afterAll(async () => {
    await browser.close();
  });

  test('page loads without console errors', async () => {
    await page.navigate('http://localhost:3000');
    const logs = await page.getConsoleLogs();
    const errors = logs.filter(log => log.level === 'error');
    expect(errors).toHaveLength(0);
  });

  test('LCP is within threshold', async () => {
    await page.navigate('http://localhost:3000');
    const metrics = await page.getPerformanceMetrics();
    expect(metrics.LCP).toBeLessThan(2500); // 2.5s threshold
  });

  test('login form submission', async () => {
    await page.navigate('http://localhost:3000/login');
    await page.fill('#username', 'testuser');
    await page.fill('#password', 'testpass');
    await page.click('#submit');
    
    await page.waitForSelector('.dashboard');
    const url = await page.getUrl();
    expect(url).toContain('/dashboard');
  });
});
```

#### Playwright + MCP 混合使用

```javascript
// 使用 Playwright 进行 E2E，MCP 进行深度检查
const { chromium } = require('playwright');

async function hybridTest() {
  // Playwright 控制浏览器
  const browser = await chromium.launch();
  const context = await browser.newContext();
  const page = await context.newPage();
  
  // 打开页面
  await page.goto('http://localhost:3000');
  
  // 使用 MCP 进行 DevTools 检查
  const devtools = await mcp.devtools.connect('http://localhost:9222');
  
  // 检查性能
  const metrics = await devtools.getPerformanceMetrics();
  expect(metrics.LCP).toBeLessThan(2500);
  
  // Playwright 继续交互
  await page.click('#add-to-cart');
  await page.waitForSelector('.cart-count');
  
  // MCP 检查网络
  const requests = await devtools.getNetworkRequests();
  const addToCartRequest = requests.find(r => 
    r.url.includes('/api/cart/add')
  );
  expect(addToCartRequest).toBeDefined();
  
  await browser.close();
}
```

### CI/CD 集成

```yaml
# .github/workflows/browser-test.yml
name: Browser Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '18'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Start application
        run: npm run start &
        
      - name: Wait for app
        run: npx wait-on http://localhost:3000
      
      - name: Start Chrome with DevTools
        run: |
          google-chrome \
            --remote-debugging-port=9222 \
            --headless \
            --disable-gpu \
            --no-sandbox &
      
      - name: Run browser tests
        run: npm run test:browser
        env:
          MCP_DEVTOOLS_URL: http://localhost:9222
```

### 性能监控集成

```javascript
// performance-monitor.js
// 持续监控性能指标

class PerformanceMonitor {
  constructor(devtoolsUrl) {
    this.devtoolsUrl = devtoolsUrl;
    this.metrics = [];
  }

  async start() {
    this.browser = await mcp.devtools.connect(this.devtoolsUrl);
    this.page = await this.browser.newPage();
  }

  async measurePageLoad(url) {
    await this.page.navigate(url);
    await this.page.waitForLoadState('networkidle');
    
    const metrics = await this.page.getPerformanceMetrics();
    this.metrics.push({
      timestamp: new Date().toISOString(),
      url,
      ...metrics
    });
    
    return metrics;
  }

  async checkThresholds() {
    const latest = this.metrics[this.metrics.length - 1];
    const issues = [];
    
    if (latest.LCP > 2500) {
      issues.push(`LCP ${latest.LCP}ms exceeds threshold 2500ms`);
    }
    if (latest.FID > 100) {
      issues.push(`FID ${latest.FID}ms exceeds threshold 100ms`);
    }
    if (latest.CLS > 0.1) {
      issues.push(`CLS ${latest.CLS} exceeds threshold 0.1`);
    }
    
    return issues;
  }

  generateReport() {
    return {
      summary: {
        totalTests: this.metrics.length,
        avgLCP: this.metrics.reduce((a, m) => a + m.LCP, 0) / this.metrics.length,
        maxLCP: Math.max(...this.metrics.map(m => m.LCP)),
        violations: this.metrics.filter(m => m.LCP > 2500).length
      },
      details: this.metrics
    };
  }
}

// 使用示例
const monitor = new PerformanceMonitor('http://localhost:9222');
await monitor.start();

setInterval(async () => {
  await monitor.measurePageLoad('http://localhost:3000');
  const issues = await monitor.checkThresholds();
  if (issues.length > 0) {
    console.warn('Performance issues detected:', issues);
  }
}, 60000); // 每分钟检查一次
```

### 调试技巧

```javascript
// 1. 慢动作模式
await page.click('#button', { delay: 100 });

// 2. 断点调试
await page.evaluate(() => { debugger; });

// 3. 网络节流模拟
await devtools.setNetworkConditions({
  downloadThroughput: 500 * 1024 / 8,  // 500 Kbps
  uploadThroughput: 500 * 1024 / 8,
  latency: 100
});

// 4. 移动端视口模拟
await page.setViewport({
  width: 375,
  height: 667,
  deviceScaleFactor: 2,
  isMobile: true
});

// 5. 保存 HAR 文件
const har = await devtools.exportHAR();
fs.writeFileSync('network.har', JSON.stringify(har, null, 2));
```

## 测试场景

### 场景 1: 页面加载测试
```markdown
1. 导航到页面
2. 等待 LCP 触发
3. 检查控制台无错误
4. 验证关键元素渲染
5. 记录性能指标
```

### 场景 2: 用户交互测试
```markdown
1. 模拟用户点击
2. 检查 DOM 更新
3. 验证网络请求
4. 检查控制台无错误
5. 截图对比
```

### 场景 3: 表单验证测试
```markdown
1. 填写表单
2. 提交表单
3. 检查 API 请求格式
4. 验证响应处理
5. 检查错误状态显示
```

## 输出格式

```json
{
  "test_date": "2026-04-07T10:00:00Z",
  "test_status": "passed|failed",
  "url": "http://localhost:3000",
  "console": {
    "errors": 0,
    "warnings": 2,
    "logs": [...]
  },
  "network": {
    "requests": 15,
    "failed_requests": 0,
    "slow_requests": ["..."]
  },
  "performance": {
    "LCP": 2.1,
    "FID": 45,
    "CLS": 0.05,
    "TTFB": 120
  },
  "dom": {
    "critical_elements_found": true,
    "accessibility_issues": []
  }
}
```

## 与五轴审查的集成

浏览器测试数据可用于：
- **Correctness**: 验证 UI 行为正确
- **Performance**: 测量 Core Web Vitals
- **Security**: 检查 CSP 违规、混合内容警告

## 常见坑

### 坑 1: DevTools 未连接
- **现象**: MCP 调用失败
- **原因**: Chrome 未以 remote-debugging 模式启动
- **解决**: 使用 `--remote-debugging-port=9222` 启动 Chrome

### 坑 2: 页面未完全加载
- **现象**: 元素检查失败
- **原因**: 在页面完全加载前执行检查
- **解决**: 使用等待策略，如 `waitForSelector`

### 坑 3: 状态不一致
- **现象**: 测试结果不稳定
- **原因**: 依赖外部服务、网络延迟
- **解决**: Mock 外部依赖，使用固定数据

## 相关文档

- [sop-performance-reviewer](../sop-performance-reviewer/SKILL.md) - 性能审查
- [MCP 配置指南](../../docs/mcp-setup.md)
