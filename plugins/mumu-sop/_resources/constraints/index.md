---
version: v5.0.0
---

# 约束索引

core_principle: 分层约束，P0不可违背

## 约束层级架构

```mermaid
graph TB
    subgraph P0层["P0 工程宪章（不可违背）"]
        P0S[安全约束]
        P0Q[质量约束]
        P0A[架构约束]
        P0C[合规约束]
    end
    
    subgraph P1层["P1 系统规范（警告可接受）"]
        P1P[性能约束]
        P1V[可用性约束]
        P1T[技术约束]
        P1I[接口约束]
    end
    
    subgraph P2层["P2 模块规范（自动化验证）"]
        P2C[代码质量]
        P2D[文档约束]
        P2T[测试约束]
    end
    
    subgraph P3层["P3 实现规范（IDE提示）"]
        P3C[编码规范]
        P3M[注释规范]
        P3G[Git规范]
    end
    
    P0层 --> |"违反即熔断"| FAIL[构建失败]
    P1层 --> |"警告建议"| WARN[警告提示]
    P2层 --> |"自动验证"| AUTO[自动修复]
    P3层 --> |"实时提示"| IDE[IDE提示]
```

## 约束验证流程

```mermaid
flowchart LR
    A[代码提交] --> B{P0检查}
    B --> |"通过"| C{P1检查}
    B --> |"失败"| D[构建失败]
    C --> |"通过"| E{P2检查}
    C --> |"警告"| F[记录警告]
    E --> |"通过"| G{P3检查}
    E --> |"警告"| F
    G --> |"通过"| H[构建成功]
    G --> |"提示"| I[自动格式化]
    I --> H
    F --> E
```

## 约束层级定义

```yaml
P0:
  name: 工程宪章约束
  strength: 不可违背，违反即熔断
  content: [安全红线, 质量红线, 架构红线]
  approval: 技术委员会
  doc: p0-constraints.md

P1:
  name: 系统约束
  strength: 跨模块约束，警告可接受
  content: 系统级质量要求
  approval: 技术负责人
  doc: p1-constraints.md

P2:
  name: 模块约束
  strength: 单模块约束，自动化验证
  content: 模块级质量要求
  approval: 模块负责人
  doc: p2-constraints.md

P3:
  name: 实现约束
  strength: 实现细节，IDE实时提示
  content: [编码规范, 测试规范]
  approval: 自动化工具
  doc: p3-constraints.md
```

## 违反处理流程

```mermaid
stateDiagram-v2
    [*] --> 检测违反
    检测违反 --> 判断级别
    
    判断级别 --> P0处理: P0级
    判断级别 --> P1P3处理: P1-P3级
    
    P0处理 --> 构建失败
    构建失败 --> 记录详情
    记录详情 --> 通知责任人
    通知责任人 --> 修复违规
    修复违规 --> 重新验证
    重新验证 --> [*]: 通过
    
    P1P3处理 --> 记录详情2[记录详情]
    记录详情2 --> 生成报告
    生成报告 --> 通知责任人2[通知责任人]
    通知责任人2 --> 评估影响
    评估影响 --> 决定处理
    决定处理 --> [*]
```

## 目录结构

```yaml
files:
  - index.md: 本文件
  - p0-constraints.md: P0级约束
  - p1-constraints.md: P1级约束
  - p2-constraints.md: P2级约束
  - p3-constraints.md: P3级约束
  - state-dictionary.md: 状态字典
  - command-dictionary.md: 命令字典
```

## 相关文档

- ../constitution/: P0级规范
- ../workflow/: 5阶段流程
- ../../index.md: Skill索引
