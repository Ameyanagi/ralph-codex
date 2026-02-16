# Ralph Agent Instructions

## Overview

Ralph is an autonomous AI agent loop that runs AI coding tools (Codex CLI, Amp, or Claude Code) repeatedly until all PRD items are complete. Each iteration is a fresh instance with clean context.

## Commands

```bash
# Run the flowchart dev server
cd flowchart && npm run dev

# Build the flowchart
cd flowchart && npm run build

# Run Ralph with Codex CLI (default)
./scripts/ralph/ralph.sh [max_iterations]

# Run Ralph with Amp
./scripts/ralph/ralph.sh --tool amp [max_iterations]

# Run Ralph with Claude Code
./scripts/ralph/ralph.sh --tool claude [max_iterations]

# Run Ralph with Codex CLI
./scripts/ralph/ralph.sh --tool codex [max_iterations]
```

## Key Files

- `scripts/ralph/ralph.sh` - The bash loop that spawns fresh AI instances (supports `--tool codex`, `--tool amp`, or `--tool claude`)
- `scripts/ralph/CODEX.md` - Instructions given to each Codex instance
- `scripts/ralph/prompt.md` - Instructions given to each AMP instance
- `scripts/ralph/CLAUDE.md` - Instructions given to each Claude Code instance
- `skills/prd-improve/` - Skill for improving PRDs with a required Claude second-opinion review
- `prd.json.example` - Example PRD format
- `flowchart/` - Interactive React Flow diagram explaining how Ralph works

## Flowchart

The `flowchart/` directory contains an interactive visualization built with React Flow. It's designed for presentations - click through to reveal each step with animations.

To run locally:
```bash
cd flowchart
npm install
npm run dev
```

## Patterns

- Each iteration spawns a fresh AI instance (Codex, Amp, or Claude Code) with clean context
- Memory persists via git history, `progress.txt`, and `prd.json`
- Stories should be small enough to complete in one context window
- Completion detection must require the final assistant response to equal `<promise>COMPLETE</promise>` exactly; substring matches are invalid
- Always update AGENTS.md with discovered patterns for future iterations
