# fast-responder 功能测试

## 测试用例 1: 简单事实查询

**Given**:
- 用户请求: "What is the capital of Japan?"
- 任务类型: 事实查询

**When**:
执行 fast-responder

**Then**:
- [ ] 响应时间 < 5 秒
- [ ] 答案准确 (Tokyo)
- [ ] 回答简洁，无多余解释

## 测试用例 2: 格式转换

**Given**:
- 用户请求: 将 JSON 转换为 YAML
- 输入数据: 有效的 JSON 对象

**When**:
执行 fast-responder

**Then**:
- [ ] 成功转换为 YAML 格式
- [ ] 保留所有数据字段
- [ ] 格式正确，可解析

## 测试用例 3: 状态检查

**Given**:
- 用户请求: "检查当前目录的文件数量"
- 权限: 正常读取权限

**When**:
执行 fast-responder

**Then**:
- [ ] 返回准确的文件数量
- [ ] 响应时间 < 3 秒
- [ ] 不执行写操作

## 测试用例 4: 拒绝复杂任务

**Given**:
- 用户请求: "帮我实现一个完整的电商系统"
- 任务复杂度: 高

**When**:
执行 fast-responder

**Then**:
- [ ] 识别任务超出能力范围
- [ ] 建议转交给 code-implementer-router
- [ ] 不提供部分实现

---

**测试日期**: 2026-04-07
**预期结果**: 功能测试通过率 100%
