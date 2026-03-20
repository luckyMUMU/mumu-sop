# sop-progress-supervisor 示例

## 输入示例

```json
{
  "workflow_state": {
    "current_stage": "stage-1",
    "completed_stages": ["stage-0"],
    "pending_stages": ["stage-2", "stage-3", "stage-4"]
  },
  "active_tasks": [
    { "id": "task-1", "status": "in_progress", "progress": 80 },
    { "id": "task-2", "status": "blocked", "reason": "等待 task-1 完成" }
  ]
}
```

## 输出示例

```json
{
  "report_date": "2026-03-01T10:00:00Z",
  "overall_progress": 35,
  "stage_progress": {
    "stage_0": 100,
    "stage_1": 80,
    "stage_2": 0,
    "stage_3": 0,
    "stage_4": 0
  },
  "blocking_issues": [
    {
      "task_id": "task-2",
      "reason": "等待 task-1 完成",
      "suggested_action": "优先完成 task-1"
    }
  ],
  "estimated_completion": "2026-03-01T18:00:00Z"
}
```

## 进度报告格式

```yaml
progress_report:
  report_date: "2026-03-01T10:00:00Z"
  overall_progress: 35
  stage_progress:
    stage_0: 100
    stage_1: 80
    stage_2: 0
    stage_3: 0
    stage_4: 0
  blocking_issues:
    - task_id: "task-2"
      reason: "等待依赖完成"
      suggested_action: "优先处理依赖任务"
  estimated_completion: "2026-03-01T18:00:00Z"
```