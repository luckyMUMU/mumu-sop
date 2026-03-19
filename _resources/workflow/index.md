---
version: v5.0.0
---

# 工作流规范

core_principle: 约束树驱动，设计从根开始，实现从叶子开始

## 5阶段工作流架构

```mermaid
graph TB
    subgraph Stage0["Stage 0: 意图分析与约束识别"]
        S0A[意图分析]
        S0B[头脑风暴]
        S0C[细节确认]
        S0D[约束识别]
    end
    
    subgraph Stage1["Stage 1: 层级设计"]
        S1A[P0 设计<br/>工程宪章]
        S1B[P1 设计<br/>系统规范]
        S1C[P2 设计<br/>模块规范]
        S1D[P3 设计<br/>实现规范]
        S1E[临时子节点<br/>创建]
    end
    
    subgraph Stage2["Stage 2: 执行计划与实现"]
        S2A[临时子节点实现]
        S2B[P3 实现]
        S2C[P2 实现]
        S2D[P1 实现]
        S2E[P0 实现]
    end
    
    subgraph Stage3["Stage 3: 变更审查与确认"]
        S3A[护栏检查]
        S3B[变更审查]
        S3C[用户确认]
    end
    
    subgraph Stage4["Stage 4: 归档与约束树更新"]
        S4A[临时子节点归档]
        S4B[约束树更新]
        S4C[CHANGELOG更新]
    end
    
    Stage0 --> Stage1
    Stage1 --> Stage2
    Stage2 --> Stage3
    Stage3 --> Stage4
```

## 标准工作流（21 步骤）

```mermaid
sequenceDiagram
    participant U as 用户
    participant A as Agent
    participant T as 约束树
    participant G as 护栏
    
    Note over U,G: 阶段 0: 意图分析与约束识别
    U->>A: 1. 提出任务请求
    A->>A: 2. 头脑风暴
    A->>U: 3. 细节确认
    
    Note over U,G: 阶段 1: 层级设计（从根开始）
    A->>T: 4. P0 约束设计
    T->>G: 5. P0 护栏检查
    G->>U: 用户审查 P0
    A->>T: 6. P1 约束设计
    T->>G: 7. P1 护栏检查
    G->>U: 用户审查 P1
    A->>T: 8. P2 约束设计
    T->>G: 9. P2 护栏检查
    G->>U: 用户审查 P2
    A->>T: 10. P3 约束设计
    T->>G: 11. P3 护栏检查
    G->>U: 用户审查 P3
    A->>A: 12. 创建临时子节点
    G->>U: 13. 用户审查临时子节点
    A->>A: 14. 创建执行计划
    A->>A: 15. 最终审查
    U->>A: 16. 确认执行
    
    Note over U,G: 阶段 2: 实现（从叶子开始）
    A->>A: 17. 叶子节点实现
    A->>G: 护栏检查
    A->>A: 18. 逐层向上实现
    A->>G: 护栏检查
    A->>A: 19. 变更审查
    
    Note over U,G: 阶段 3-4: 交付与归档
    U->>A: 20. 确认完成
    A->>T: 21. 归档，解除引用关系
```

## 约束树结构

```mermaid
graph TB
    subgraph 长效约束树
        P0["P0 根节点<br/>工程宪章<br/>不可违背"]
        P1["P1 一级子节点<br/>系统规范<br/>继承 P0"]
        P2["P2 二级子节点<br/>模块规范<br/>继承 P1"]
        P3["P3 三级子节点<br/>实现规范<br/>继承 P2"]
        
        P0 --> P1
        P1 --> P2
        P2 --> P3
    end
    
    subgraph 临时子节点["临时子节点（独立存储）"]
        TEMP["临时子节点<br/>.trae/specs/{change-id}/<br/>spec.md + tasks.md + checklist.md"]
    end
    
    P3 -.->|"引用关联"| TEMP
```

## 临时子节点独立存储架构

```mermaid
flowchart LR
    subgraph 约束树["长效约束树"]
        P3["P3 节点"]
    end
    
    subgraph 独立存储["临时子节点独立存储"]
        SPEC["spec.md<br/>任务规范"]
        TASKS["tasks.md<br/>任务列表"]
        CHECK["checklist.md<br/>检查清单"]
        META[".meta.yaml<br/>元数据"]
    end
    
    P3 -->|"引用"| META
    META --> SPEC
    META --> TASKS
    META --> CHECK
```

## 设计从根开始的流程

```mermaid
flowchart TB
    START[开始设计] --> P0[P0 设计<br/>工程宪章]
    P0 --> G0{P0 护栏检查}
    G0 -->|失败| FIX0[返回修复]
    FIX0 --> P0
    G0 -->|通过| U0[用户审查 P0]
    U0 -->|拒绝| P0
    U0 -->|通过| P1[P1 设计<br/>系统规范]
    
    P1 --> G1{P1 护栏检查}
    G1 -->|失败| FIX1[返回修复]
    FIX1 --> P1
    G1 -->|通过| U1[用户审查 P1]
    U1 -->|拒绝| P1
    U1 -->|通过| P2[P2 设计<br/>模块规范]
    
    P2 --> G2{P2 护栏检查}
    G2 -->|失败| FIX2[返回修复]
    FIX2 --> P2
    G2 -->|通过| U2[用户审查 P2]
    U2 -->|拒绝| P2
    U2 -->|通过| P3[P3 设计<br/>实现规范]
    
    P3 --> G3{P3 护栏检查}
    G3 -->|失败| FIX3[返回修复]
    FIX3 --> P3
    G3 -->|通过| U3[用户审查 P3]
    U3 -->|拒绝| P3
    U3 -->|通过| TEMP[创建临时子节点]
    
    TEMP --> END[设计完成]
```

## 实现从叶子开始的流程

```mermaid
flowchart TB
    START[开始实现] --> CHECK{存在临时子节点?}
    CHECK -->|是| TEMP[临时子节点实现]
    CHECK -->|否| P3[P3 实现]
    
    TEMP --> GT{临时子节点护栏检查}
    GT -->|失败| FIXT[返回修复]
    FIXT --> TEMP
    GT -->|通过| P3
    
    P3 --> G3{P3 护栏检查}
    G3 -->|失败| FIX3[返回修复]
    FIX3 --> P3
    G3 -->|通过| P2[P2 实现]
    
    P2 --> G2{P2 护栏检查}
    G2 -->|失败| FIX2[返回修复]
    FIX2 --> P2
    G2 -->|通过| P1[P1 实现]
    
    P1 --> G1{P1 护栏检查}
    G1 -->|失败| FIX1[返回修复]
    FIX1 --> P1
    G1 -->|通过| P0[P0 实现<br/>约束验证]
    
    P0 --> G0{P0 护栏检查}
    G0 -->|失败| FIX0[返回修复]
    FIX0 --> P0
    G0 -->|通过| END[实现完成]
```

## 层级护栏机制

```mermaid
flowchart TB
    subgraph 护栏检查流程
        INPUT[设计/实现完成] --> FIRST[首先进行护栏检查]
        FIRST --> P0G[P0 护栏]
        FIRST --> P1G[P1 护栏]
        FIRST --> P2G[P2 护栏]
        FIRST --> P3G[P3 护栏]
        
        P0G --> |"失败"| FUSE[立即熔断]
        P1G --> |"失败"| APPROVE1[技术负责人审批]
        P2G --> |"失败"| APPROVE2[模块负责人审批]
        P3G --> |"失败"| AUTO[自动化工具验证]
        
        P0G --> |"通过"| OTHER[其他审查]
        P1G --> |"通过"| OTHER
        P2G --> |"通过"| OTHER
        P3G --> |"通过"| OTHER
        
        OTHER --> USER[用户确认]
    end
```

## 护栏优先检查流程

```mermaid
sequenceDiagram
    participant D as 设计/实现
    participant G as 护栏检查
    participant R as 其他审查
    participant U as 用户确认
    
    D->>G: 完成某个层级
    G->>G: 安全护栏检查
    G->>G: 质量护栏检查
    G->>G: 架构护栏检查
    
    alt 护栏检查失败
        G->>D: 立即熔断/返回修复
    else 护栏检查通过
        G->>R: 进入其他审查
        R->>U: 用户确认
    end
```

## 变更范围区分

```mermaid
flowchart TB
    CHANGE[变更请求] --> ANALYZE{分析变更范围}
    
    ANALYZE --> |"仅影响实现规范"| P3C[P3 变更<br/>代码重构、命名调整]
    ANALYZE --> |"影响模块规范"| P2C[P2 变更<br/>模块接口变更、新增功能]
    ANALYZE --> |"影响系统规范"| P1C[P1 变更<br/>架构调整、性能优化]
    ANALYZE --> |"影响工程宪章"| P0C[P0 变更<br/>安全策略、质量红线]
    ANALYZE --> |"无法区分"| ASK[暂停执行<br/>询问用户决策]
    
    ASK --> |"提供分析"| USER[用户选择范围]
    USER --> P3C
    USER --> P2C
    USER --> P1C
    USER --> P0C
```

## 质量门控

```mermaid
flowchart TB
    subgraph 门控检查
        G0["Stage 0 门控<br/>意图清晰<br/>约束识别完成"]
        G1["Stage 1 门控<br/>设计层级完整<br/>护栏检查通过<br/>用户确认"]
        G2["Stage 2 门控<br/>实现层级完整<br/>护栏检查通过<br/>约束验证通过"]
        G3["Stage 3 门控<br/>变更审查通过<br/>用户确认完成"]
        G4["Stage 4 门控<br/>归档记录完整<br/>引用关系解除<br/>CHANGELOG更新"]
    end
    
    G0 --> |"通过"| G1
    G1 --> |"通过"| G2
    G2 --> |"通过"| G3
    G3 --> |"通过"| G4
    
    G0 --> |"失败"| FAIL0[返回意图澄清]
    G1 --> |"失败"| FAIL1[返回设计修正]
    G2 --> |"失败"| FAIL2[返回实现修正]
    G3 --> |"失败"| FAIL3[返回审查修正]
```

## 契约式协作

```mermaid
flowchart LR
    subgraph 契约结构
        PRE["前置条件<br/>Precondition"]
        LOGIC["独立上下文<br/>Logic"]
        POST["后置条件<br/>Postcondition"]
        INV["不变式<br/>Invariant"]
    end
    
    PRE --> LOGIC --> POST
    INV -.-> LOGIC
```

**契约原则**：
- 各环节独立上下文
- 仅通过契约传递（JSON/YAML文件）
- 禁止共享内存/状态/缓存
- 禁止隐式依赖
- 上下文版本化

## 阶段详情

### Stage 0: 意图分析与约束识别

```yaml
actions:
  - 意图分析：理解用户任务目标
  - 头脑风暴：探索可能的方案和约束
  - 细节确认：询问用户确认细节
  - 约束识别：识别约束树中的相关节点
output: 
  - 意图分析记录
  - 约束识别结果
contract: contracts/stage-0-contract.yaml
```

### Stage 1: 层级设计

```yaml
actions:
  - P0 设计：工程宪章设计（根节点）
  - P1 设计：系统架构设计（一级子节点）
  - P2 设计：模块设计（二级子节点）
  - P3 设计：实现设计（三级子节点）
  - 临时子节点创建：spec.md + tasks.md + checklist.md
output:
  - 各层级设计文档
  - 临时子节点文件
  - 护栏检查结果
contract: contracts/stage-1-contract.yaml
```

### Stage 2: 执行计划与实现

```yaml
actions:
  - 临时子节点实现（如果存在）
  - P3 实现：实现规范层
  - P2 实现：模块规范层
  - P1 实现：系统规范层
  - P0 实现：工程宪章层（约束验证）
output:
  - 代码变更
  - 护栏检查结果
  - 审查报告
contract: contracts/stage-2-contract.yaml
```

### Stage 3: 变更审查与确认

```yaml
actions:
  - 护栏检查：所有层级护栏检查
  - 变更审查：审查变更结果
  - 用户确认：用户确认任务完成
output:
  - 审查报告
  - 用户确认记录
contract: contracts/stage-3-contract.yaml
```

### Stage 4: 归档与约束树更新

```yaml
actions:
  - 临时子节点归档：归档到上级节点
  - 引用关系解除：解除临时子节点与 P3 的引用
  - 约束树更新：更新长效约束（如有变更）
  - CHANGELOG 更新
output:
  - 归档记录
  - CHANGELOG
contract: contracts/stage-4-contract.yaml
```

## 契约模板索引

> 契约定义使用持久化约束，详见 `sop/contracts/` 目录

```yaml
contract_templates:
  - stage: 0
    file: ../contracts/stage-0-contract.yaml
    desc: 意图分析与约束识别契约
  - stage: 1
    file: ../contracts/stage-1-contract.yaml
    desc: 层级设计输出契约
  - stage: 2
    file: ../contracts/stage-2-contract.yaml
    desc: 执行计划与实现输出契约
  - stage: 3
    file: ../contracts/stage-3-contract.yaml
    desc: 变更审查与确认输出契约
  - stage: 4
    file: ../contracts/stage-4-contract.yaml
    desc: 归档与约束树更新输出契约
```

## 相关文档

- ../constitution/: P0级规范
- ../specifications/: P1-P2级规范
- ../constraints/: P0-P3约束
- ../../index.md: Skill索引
