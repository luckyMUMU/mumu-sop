# batch-processor 触发测试

## 应该触发

### 英文触发词
- "batch process"
- "bulk operation"
- "process all files"
- "generate 100 files"
- "convert all JSON to YAML"
- "batch update"
- "mass import"
- "process in bulk"

### 中文触发词
- "批量处理"
- "批量操作"
- "处理所有文件"
- "生成100个文件"
- "批量转换"
- "批量导入"
- "批量更新"
- "全部处理"

### 改写/同义词
- "把这些都处理一下"
- "批量生成"
- "全部转换"
- "统一处理这些数据"
- "批量修改"

## 不应触发

### 单个操作
- "处理这个文件" (应触发 code-implementer-router)
- "转换这个JSON" (应触发 fast-responder)
- "修改这行代码"

### 复杂设计
- "设计批量处理架构" (应触发 architect-decider)
- "批量处理方案设计"

### 其他 Agent 的触发词
- "快速回答" (应触发 fast-responder)
- "实现功能" (应触发 code-implementer-router)

## 边界情况

### 可能误触发
- "处理这批数据" (数量不明确，需询问)
- "全部做完" (范围不明确)

### 可能漏触发
- "把这几个都转一下" (需要识别为批量)
- "统一修改这些配置" (需要识别为批量更新)

---

**测试日期**: 2026-04-07
**预期结果**: 触发准确率 ≥ 90%
