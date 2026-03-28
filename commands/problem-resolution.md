---
description: Run the Problem Resolution Pipeline (identify → search → root cause → solution → implement → verify)
allowed-tools: [Read, Edit, Write, Bash, Glob, Grep, TodoWrite, Agent]
---

# Problem Resolution & Conflict Pipeline

Structured investigation with checkpoints for long-running tasks.

## Pipeline Stages

### Stage 1: Problem Identification
```
Input: Error message / Conflict description

Parse:
├─ Error type (runtime, type, logical, merge, design)
├─ Affected component(s)
├─ Reproducibility (always / intermittent / once)
├─ User impact (critical / high / medium / low)
├─ Stack trace / Conflict details

Output: Problem statement for seshat search
```

### Stage 2: Context Search (Explore - READ-ONLY)
1. search_memories(pattern) → similar issues
2. ciam_decision_context(component) → decisions
3. ciam_search(keywords) → code patterns
4. Store checkpoint: search_findings.txt

### Stage 3: Root Cause Analysis (Explore - READ-ONLY)
Investigate: code flow, dependencies, state, environment, logic
Techniques: trace path, git history, ADRs, test cases
Output: Root cause hypothesis
Store checkpoint: root_cause_analysis.txt

### Stage 4: Solution Design (Plan/Architect Agent)
```
If architectural impact:
├─ Draft ADR with decision rationale
├─ Document tradeoffs
├─ Plan implementation phases

If code-level fix:
├─ Outline approach
├─ Identify test cases needed
├─ Check for side effects
├─ Plan rollback if deployment

Output: Solution plan + implementation strategy
Store: solution_plan.txt + ADR if needed
```

### Stage 5: Implementation (Developer)
Follow development.md: one story, quality gates, link to analysis, add regression tests

### Stage 6: Verification (Reviewer)
Issue reproducible with fix ✓ | Regression tests ✓ | No new failures ✓ | Solution matches analysis ✓ | Edge cases ✓

### Stage 7: Memory Update
Store: problem signature, root cause, solution applied, lessons learned.
Call: store_memory(topic="[error_pattern]", content="Root cause: ..., Solution: ..., Lessons: ...", tags=["error_type", "component"])

## Escalation Matrix

| Scenario | Action | Owner |
|---|---|---|
| Error unresolved after 2 checkpoints | Escalate to Plan agent | Architect |
| Multiple related issues | Open design review | Architect + Team |
| User-reported regression | Priority investigation | Dev + Reviewer |
| Production critical bug | Direct deploy (test-deploy 5+) | Ops + Reviewer |
| Deployment-related | Ops triage | Ops agent |
| Data corruption risk | Stop, escalate immediately | Team lead |

## Checkpoint System (Long Investigations)

Save every 2-3 stages: time elapsed, stages completed, findings, next steps, blockers.
Format: `[CHECKPOINT-YYYY-MM-DD-HH:MM] Stages: 1-3 | Findings: [X] | Next: Stage 4 | Blockers: None`

## Exit Criteria

- ✓ Root cause documented
- ✓ Solution verified (issue resolved or workaround in place)
- ✓ Regression tests passing
- ✓ Memory updated with pattern
- ✓ Escalation complete (if needed)
- ✓ All checkpoints archived
