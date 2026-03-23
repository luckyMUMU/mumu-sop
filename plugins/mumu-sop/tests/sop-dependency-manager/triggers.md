# sop-dependency-manager 触发测试

## 应该触发

### 英文触发词
- "upgrade dependency"
- "update dependency"
- "dependency upgrade"
- "update package"
- "upgrade package"

### 中文触发词
- "依赖升级"
- "升级依赖"
- "版本升级"
- "更新依赖"
- "依赖管理"

### 改写/同义词
- "把 lodash 升级到最新版"
- "更新 npm 包"
- "检查依赖有没有安全问题"

## 不应触发

### 无关查询
- "写代码"
- "测试功能"
- "部署服务"

### 其他 Skill 的触发词
- "重构代码" (应触发 sop-code-refactor)
- "分析bug" (应触发 sop-bug-analysis)
- "技术债务" (应触发 sop-tech-debt-manager)

## 边界情况

### 可能误触发
- "升级" (可能是系统升级)
- "更新" (可能是内容更新)

### 可能漏触发
- "npm audit 报告有漏洞" (隐含依赖升级)
- "包过时了" (隐含升级需求)

---

**测试日期**: 2026-03-23
**预期结果**: 触发准确率 ≥ 90%