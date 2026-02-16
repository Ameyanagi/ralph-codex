#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <source_prd_path> <claude_review_output_path>" >&2
  exit 1
fi

SOURCE_PRD_PATH="$1"
CLAUDE_REVIEW_OUTPUT_PATH="$2"

if [[ ! -f "$SOURCE_PRD_PATH" ]]; then
  echo "Error: PRD file not found: $SOURCE_PRD_PATH" >&2
  exit 1
fi

if ! command -v claude >/dev/null 2>&1; then
  echo "Error: Claude CLI is not installed or not in PATH." >&2
  exit 1
fi

mkdir -p "$(dirname "$CLAUDE_REVIEW_OUTPUT_PATH")"

{
  cat <<'PROMPT'
You are a senior product engineer reviewing a PRD for autonomous implementation quality.

Review the PRD and return markdown with these sections only:
1. Critical Gaps
2. Medium Improvements
3. Suggested Rewrites
4. Final Verdict (PASS or REVISE)

Rules:
- Focus on clarity, verifiability, and implementation readiness.
- Flag vague acceptance criteria.
- Flag oversized user stories that should be split.
- Keep the review concise and actionable.

PRD:
PROMPT
  cat "$SOURCE_PRD_PATH"
} | claude --dangerously-skip-permissions --print > "$CLAUDE_REVIEW_OUTPUT_PATH"

