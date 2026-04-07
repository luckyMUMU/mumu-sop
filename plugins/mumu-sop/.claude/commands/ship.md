---
description: |
  启动 SOP 交付阶段 —— 准备发布。
  对应 Ship 阶段，使用 sop-document-writer skill。
  触发词: ship, 交付, 发布, deploy
---

启动 SOP 交付阶段，将代码发布到生产环境。

## 执行流程

1. **预发布检查清单**
   - [ ] 所有测试通过
   - [ ] 代码审查通过
   - [ ] 文档已更新
   - [ ] 功能开关已配置
   - [ ] 监控已设置
   - [ ] 回滚方案已准备

2. **分阶段发布**
   - Canary（金丝雀）：小流量验证
   - Staged Rollout（分阶段）：逐步扩大
   - Full Rollout（全量）：完整发布

3. **归档与约束树更新**
   - 归档临时节点到约束树
   - 从 P3 向上更新各级约束
   - 生成 CHANGELOG
   - 解除临时节点引用

4. **发布后监控**
   - 观察错误率和性能指标
   - 验证功能按预期工作
   - 准备回滚（如需要）

## 发布原则

### Faster is Safer（快即是安全）
- 小变更频繁发布 > 大变更偶尔发布
- 缩短反馈循环
- 问题更容易定位和修复

### Feature Flags（功能开关）
- 新功能默认关闭
- 可独立开启/关闭
- 出现问题时快速禁用

### Rollback Ready（随时可回滚）
- 每个发布都能回滚
- 回滚时间 < 5 分钟
- 数据变更向前兼容

## Ship Checklist

```markdown
## Pre-launch
- [ ] Feature flag configured
- [ ] Monitoring dashboards ready
- [ ] Alert thresholds set
- [ ] Runbook documented
- [ ] Rollback procedure tested

## Launch
- [ ] Deploy to staging
- [ ] Verify in staging
- [ ] Enable for 1% traffic
- [ ] Monitor for 30 minutes
- [ ] Gradually increase to 100%

## Post-launch
- [ ] Monitor for 24 hours
- [ ] Check error rates
- [ ] Verify performance metrics
- [ ] Update documentation
- [ ] Announce to team
```

## 输出

- 发布记录
- 更新的约束树
- CHANGELOG
