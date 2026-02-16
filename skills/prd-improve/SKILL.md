---
name: prd-improve
description: "Improve an existing PRD before implementation. Use when asked to refine, tighten, review, or polish a PRD. Triggers on: improve this prd, review this prd, tighten requirements, polish spec. Requires a Claude CLI second-opinion pass."
user-invocable: true
---

# PRD Improver

Upgrade an existing PRD so it is implementation-ready for autonomous coding agents.

---

## The Job

1. Read the source PRD markdown file
2. Review for structure, ambiguity, and testability gaps
3. **Run Claude CLI second opinion (required)**
4. Apply improvements while preserving intent
5. Save improved PRD markdown
6. Save Claude review notes for traceability

---

## Inputs

- `source_prd_path`: path to existing PRD markdown
- `output_prd_path` (optional): where to write improved PRD

Default output path:
- same directory as source
- filename suffix: `-improved.md`

Example:
- `tasks/prd-checkout.md` -> `tasks/prd-checkout-improved.md`

---

## Quality Checklist

Before finalizing, ensure the PRD has:

- Clear problem statement and goals
- Explicit scope + non-goals
- Small user stories (one focused implementation chunk each)
- Dependency-safe ordering of stories
- Verifiable acceptance criteria (not vague)
- `Typecheck passes` criterion on every story
- `Tests pass` where behavior is testable
- `Verify in browser using dev-browser skill` for UI stories
- Numbered functional requirements
- Measurable success metrics

---

## Claude Second Opinion (Required)

You MUST run a Claude review before producing the final improved PRD.

Run:

```bash
./scripts/claude_second_opinion.sh "<source_prd_path>" "<claude_review_output_path>"
```

Use the script from this skill's own `scripts/` directory.
Typical locations:
- repo-local skill: `skills/prd-improve/scripts/claude_second_opinion.sh`
- global Codex skill: `~/.codex/skills/prd-improve/scripts/claude_second_opinion.sh`

Use review output path:
- `tasks/prd-<name>-claude-review.md`

If Claude CLI is unavailable or the review command fails:
- Stop and report the issue clearly
- Do not claim the PRD is finalized

---

## Rewrite Rules

- Preserve the original feature intent
- Remove ambiguity and hand-wavy language
- Keep requirements concrete and testable
- Split oversized stories into smaller ones
- Keep naming/terminology consistent
- Do not start implementation work

---

## Output

Produce:

1. Improved PRD markdown file
2. Claude review markdown file
3. Brief summary:
   - major changes made
   - top Claude findings addressed
   - any remaining open questions
