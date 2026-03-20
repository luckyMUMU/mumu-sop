# sop-document-creator 触发测试

## 应该触发

### 英文触发词
- "create document"
- "write doc"
- "generate documentation"
- "new README"
- "create spec document"

### 中文触发词
- "创建文档"
- "写文档"
- "生成README"
- "新建文档"
- "文档创建"

### 改写/同义词
- "帮我写一个README"
- "生成技术文档"
- "创建规范文档"

## 不应触发

- "同步文档" (应触发 sop-document-sync)
- "分析需求" (应触发 sop-requirement-analyst)
- "设计架构" (应触发 sop-architecture-design)

---

**测试日期**: 2026-03-20