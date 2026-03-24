#!/bin/bash
# Post-Archive Hook Script
# 在 Stage 4 归档完成后自动触发约束树更新

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONTRACTS_DIR="$PROJECT_ROOT/contracts"

echo "=== Post-Archive Hook ==="
echo "Time: $(date -Iseconds)"

# 读取归档记录
ARCHIVE_RECORD="$CONTRACTS_DIR/stage-4-archive.json"

if [ ! -f "$ARCHIVE_RECORD" ]; then
    echo "Error: Archive record not found at $ARCHIVE_RECORD"
    exit 1
fi

# 提取变更 ID
CHANGE_ID=$(grep -o '"source_change_id": *"[^"]*"' "$ARCHIVE_RECORD" | head -1 | cut -d'"' -f4)

if [ -z "$CHANGE_ID" ]; then
    echo "Error: Cannot find change ID in archive record"
    exit 1
fi

echo "Processing change: $CHANGE_ID"

# 检查主存储路径
if [ -d "$PROJECT_ROOT/.sop/specs/$CHANGE_ID" ]; then
    SPEC_PATH="$PROJECT_ROOT/.sop/specs/$CHANGE_ID"
elif [ -d "$PROJECT_ROOT/.trae/specs/$CHANGE_ID" ]; then
    SPEC_PATH="$PROJECT_ROOT/.trae/specs/$CHANGE_ID"
else
    echo "Warning: Temporary node directory not found, may have been archived already"
    SPEC_PATH=""
fi

# 步骤 1: 约束树更新
echo ""
echo "Step 1: Updating constraint tree (P3 -> P2 -> P1 -> P0)..."
# 此步骤由 Agent 执行，此处为日志记录
echo "  - Validating P3 constraints..."
echo "  - Validating P2 constraints..."
echo "  - Validating P1 constraints..."
echo "  - Validating P0 constraints (requires approval if changes)..."

# 步骤 2: 引用关系解除
echo ""
echo "Step 2: Cleaning up temporary node references..."
if [ -n "$SPEC_PATH" ] && [ -f "$SPEC_PATH/.meta.yaml" ]; then
    P3_NODE=$(grep -o 'referenced_p3_node: *[^ ]*' "$SPEC_PATH/.meta.yaml" | cut -d' ' -f2)
    echo "  - Removing reference from P3 node: $P3_NODE"
    echo "  - Writing reference cleanup record..."
else
    echo "  - No meta.yaml found, skipping reference cleanup"
fi

# 步骤 3: CHANGELOG 更新
echo ""
echo "Step 3: Updating CHANGELOG..."
CHANGELOG="$PROJECT_ROOT/CHANGELOG.md"
if [ -f "$CHANGELOG" ]; then
    echo "  - CHANGELOG.md exists, will be updated by Agent"
else
    echo "  - CHANGELOG.md not found, will be created by Agent"
fi

# 步骤 4: 约束树验证
echo ""
echo "Step 4: Validating constraint tree integrity..."
echo "  - Checking tree structure..."
echo "  - Verifying inheritance relationships..."
echo "  - Detecting conflicts..."

# 生成约束更新记录
CONSTRAINT_UPDATE="$CONTRACTS_DIR/stage-4-constraint-update.json"
cat > "$CONSTRAINT_UPDATE" << EOF
{
  "change_id": "$CHANGE_ID",
  "updated_at": "$(date -Iseconds)",
  "updated_nodes": [],
  "new_nodes": [],
  "deprecated_nodes": [],
  "validation_status": "pending_agent_execution"
}
EOF
echo "  - Created constraint update record: $CONSTRAINT_UPDATE"

# 生成引用清理记录
REFERENCE_CLEANUP="$CONTRACTS_DIR/stage-4-reference.json"
cat > "$REFERENCE_CLEANUP" << EOF
{
  "change_id": "$CHANGE_ID",
  "cleaned_at": "$(date -Iseconds)",
  "removed_references": [],
  "cleanup_status": "pending_agent_execution"
}
EOF
echo "  - Created reference cleanup record: $REFERENCE_CLEANUP"

echo ""
echo "=== Post-Archive Hook Completed ==="
echo "Note: Actual constraint tree updates will be executed by Agent"
exit 0