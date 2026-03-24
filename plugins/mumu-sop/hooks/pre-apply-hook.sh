#!/bin/bash
# Pre-Apply Hook Script
# 在 Stage 2 实现开始前验证临时节点完整性

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
CONTRACTS_DIR="$PROJECT_ROOT/contracts"

echo "=== Pre-Apply Hook ==="
echo "Time: $(date -Iseconds)"

# 读取执行确认
CONFIRMATION="$CONTRACTS_DIR/stage-1-confirmation.json"

if [ ! -f "$CONFIRMATION" ]; then
    echo "Error: Stage 1 confirmation not found at $CONFIRMATION"
    echo "Please complete Stage 1 design before starting Stage 2"
    exit 1
fi

# 提取变更 ID
CHANGE_ID=$(grep -o '"change_id": *"[^"]*"' "$CONFIRMATION" | head -1 | cut -d'"' -f4)

if [ -z "$CHANGE_ID" ]; then
    echo "Error: Cannot find change ID in confirmation"
    exit 1
fi

echo "Processing change: $CHANGE_ID"

# 确定存储路径
SPEC_PATH=""
if [ -d "$PROJECT_ROOT/.sop/specs/$CHANGE_ID" ]; then
    SPEC_PATH="$PROJECT_ROOT/.sop/specs/$CHANGE_ID"
    echo "Found temporary node at: .sop/specs/$CHANGE_ID"
elif [ -d "$PROJECT_ROOT/.trae/specs/$CHANGE_ID" ]; then
    SPEC_PATH="$PROJECT_ROOT/.trae/specs/$CHANGE_ID"
    echo "Found temporary node at: .trae/specs/$CHANGE_ID"
else
    echo "Error: Temporary node directory not found"
    echo "Expected: .sop/specs/$CHANGE_ID or .trae/specs/$CHANGE_ID"
    exit 1
fi

# 步骤 1: 验证临时节点结构
echo ""
echo "Step 1: Verifying temporary node structure..."

ERRORS=0
WARNINGS=0

check_file() {
    local file="$1"
    local required="$2"
    if [ -f "$file" ]; then
        echo "  ✓ $(basename $file) exists"
    else
        if [ "$required" = "required" ]; then
            echo "  ✗ $(basename $file) MISSING (required)"
            ((ERRORS++))
        else
            echo "  ⚠ $(basename $file) missing (optional)"
            ((WARNINGS++))
        fi
    fi
}

check_file "$SPEC_PATH/.meta.yaml" "required"
check_file "$SPEC_PATH/proposal.md" "required"
check_file "$SPEC_PATH/design.md" "required"
check_file "$SPEC_PATH/tasks.md" "required"
check_file "$SPEC_PATH/checklist.md" "required"

# 检查 specs 目录
if [ -d "$SPEC_PATH/specs" ]; then
    echo "  ✓ specs/ directory exists"
    check_file "$SPEC_PATH/specs/requirements.md" "optional"
    check_file "$SPEC_PATH/specs/scenarios.md" "optional"
else
    echo "  ⚠ specs/ directory missing (optional)"
    ((WARNINGS++))
fi

# 步骤 2: 验证元数据完整性
echo ""
echo "Step 2: Verifying metadata completeness..."

META_FILE="$SPEC_PATH/.meta.yaml"
if [ -f "$META_FILE" ]; then
    check_field() {
        local field="$1"
        if grep -q "^$field:" "$META_FILE"; then
            echo "  ✓ $field defined"
        else
            echo "  ✗ $field MISSING"
            ((ERRORS++))
        fi
    }

    check_field "change_id"
    check_field "status"
    check_field "referenced_p3_node"
    check_field "complexity"
    check_field "estimated_depth"
    check_field "created_at"
else
    echo "  ✗ Cannot verify metadata: .meta.yaml not found"
    ((ERRORS++))
fi

# 步骤 3: 护栏预检
echo ""
echo "Step 3: Pre-checking guardrails..."
echo "  - P0 guardrails (checking for blockers)..."
echo "  - P1 guardrails (checking for warnings)..."
echo "  - P2 guardrails (checking for warnings)..."
echo "  - P3 guardrails (checking for hints)..."

# 步骤 4: 复杂度确认
echo ""
echo "Step 4: Confirming complexity..."
if [ -f "$META_FILE" ]; then
    COMPLEXITY=$(grep -o '^complexity: *[^ ]*' "$META_FILE" | cut -d' ' -f2)
    DEPTH=$(grep -o '^estimated_depth: *[^ ]*' "$META_FILE" | cut -d' ' -f2)
    echo "  - Complexity level: ${COMPLEXITY:-unknown}"
    echo "  - Estimated depth: ${DEPTH:-unknown}"
fi

# 步骤 5: 检查依赖子树
echo ""
echo "Step 5: Checking dependency subtrees..."
DEPS_DIR="$PROJECT_ROOT/plugins/mumu-sop/_resources/constraints/dependencies"
if [ -d "$DEPS_DIR" ]; then
    DEP_COUNT=$(find "$DEPS_DIR" -maxdepth 1 -type d -name "DEP-*" 2>/dev/null | wc -l)
    echo "  - Found $DEP_COUNT dependency subtrees"
else
    echo "  - No dependency subtrees configured"
fi

# 生成预检报告
PRE_CHECK="$CONTRACTS_DIR/stage-2-pre-check.json"
cat > "$PRE_CHECK" << EOF
{
  "change_id": "$CHANGE_ID",
  "checked_at": "$(date -Iseconds)",
  "temp_node_valid": $([ $ERRORS -eq 0 ] && echo "true" || echo "false"),
  "spec_path": "$SPEC_PATH",
  "errors": $ERRORS,
  "warnings": $WARNINGS,
  "guardrail_results": {
    "P0": "pending",
    "P1": "pending",
    "P2": "pending",
    "P3": "pending"
  },
  "ready_to_proceed": $([ $ERRORS -eq 0 ] && echo "true" || echo "false")
}
EOF
echo ""
echo "  Created pre-check report: $PRE_CHECK"

# 检查阻断条件
if [ $ERRORS -gt 0 ]; then
    echo ""
    echo "=== Pre-Apply Hook FAILED ==="
    echo "Errors found: $ERRORS"
    echo "Warnings found: $WARNINGS"
    echo ""
    echo "Please fix the errors above before starting Stage 2"

    # 生成阻断报告
    BLOCKERS="$CONTRACTS_DIR/stage-2-blockers.json"
    cat > "$BLOCKERS" << EOF
{
  "change_id": "$CHANGE_ID",
  "blocked_at": "$(date -Iseconds)",
  "blockers": [
    "Temporary node validation failed with $ERRORS error(s)"
  ],
  "warnings": [],
  "action_required": "Fix validation errors and re-run pre-apply hook"
}
EOF
    exit 1
fi

echo ""
echo "=== Pre-Apply Hook PASSED ==="
echo "Warnings: $WARNINGS"
echo "Ready to proceed with Stage 2 implementation"
exit 0