# sop-workflow-orchestrator 示例

## 输入示例

```json
{
  "weight_decision": {
    "complexity": "high",
    "path": "deep",
    "stages": ["stage-0", "stage-1", "stage-2", "stage-3", "stage-4"]
  }
}
```

## 输出示例

```json
{
  "workflow_id": "wf-20260301-001",
  "current_stage": "stage-1",
  "completed_stages": ["stage-0"],
  "pending_stages": ["stage-2", "stage-3", "stage-4"],
  "stage_details": {
    "stage-0": {
      "status": "completed",
      "completed_at": "2026-03-01T09:00:00Z",
      "decision": "deep"
    },
    "stage-1": {
      "status": "in_progress",
      "started_at": "2026-03-01T09:05:00Z"
    }
  }
}
```

## 工作流状态格式

```yaml
workflow_state:
  workflow_id: "wf-20260301-001"
  current_stage: "stage-N"
  completed_stages: ["stage-0", "stage-1"]
  pending_stages: ["stage-2", "stage-3", "stage-4"]
  stage_details:
    stage-0:
      status: "completed"
      completed_at: "2026-03-01T09:00:00Z"
    stage-1:
      status: "in_progress"
      started_at: "2026-03-01T09:05:00Z"
```

## Compaction 配置

```yaml
compaction:
  trigger:
    type: token_threshold
    threshold: 100000
  strategy:
    current_stage: full_context
    completed_stages: summary_only
    preserve:
      - key_decisions
      - artifact_references
      - constraint_violations
```