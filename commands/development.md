---
description: Run the Development Cycle Pipeline (context → spec → story → implement → quality gate → commit)
allowed-tools: [Read, Edit, Write, Bash, Glob, Grep, TodoWrite, Agent]
---

# Development Cycle Pipeline

Combines aiox SDC + ralph iteration pattern. One story per iteration.

## Pipeline Stages

### 1. Context Acquisition
→ Execute context-first.md
Exit: context loaded, budget set, decisions mapped

### 2. Spec/PRD Check
```
Question: Does requirement/spec exist?
├─ YES → Extract story scope
├─ NO → Strategist agent drafts PRD
          Store in progress.txt + memory
└─ UNCLEAR → Raise clarifying questions
```

### 3. Story Draft (Developer)
**Ralph pattern:** one story per iteration

| Aspect | Detail |
|---|---|
| Title | Feature/fix name |
| Acceptance Criteria | 3-5 testable conditions |
| Implementation Notes | Tech stack, dependencies |
| Estimated Effort | S/M/L |
| Scope | Lines changed, files touched |

**Store:** In progress.txt with timestamp

### 4. Implementation (Developer)
```
1. Read spec/story
2. Code implementation
3. Self-review: type safety, patterns, no regressions
4. Run lint → fix issues
5. Run unit tests → achieve target coverage
6. Commit with story ID
```

### 5. Quality Gate Checklist (Reviewer)

| Gate | Criteria | Tool |
|---|---|---|
| Type Safety | No type errors | typescript --noEmit |
| Linting | Zero violations | eslint/pylint |
| Tests Pass | All tests green | jest/pytest |
| Coverage | ≥80% line coverage | coverage report |
| No Regressions | No new failures | test suite |
| Readability | Clear variable/function names | code review |
| Docs Updated | README/ADR if needed | manual check |

**Block merge if any gate fails.**

### 6. Memory Update
```
Store in progress.txt + seshat:
- Decision made (why this approach?)
- Pattern discovered (reusable?)
- Learning (what went wrong/right?)
- Related decisions (link to ADRs)
```

### 7. Commit (Developer)
**Only if ALL gates pass.**

Format:
```
[STORY-ID] Feature/fix title

- Acceptance criteria met: ✓
- Quality gates passed: ✓
- Tests: X new, Y modified
- Files: Z touched

Refs: progress.txt, decisions.md
```

## Escalation Triggers

| Trigger | Action |
|---|---|
| Type errors unresolvable | Escalate to Plan agent (architecture review) |
| Coverage < 70% | Extend story to next iteration |
| Merge conflict | Resolve with prior implementer |
| Scope creep | Split into separate story |

## Exit Criteria

- ✓ All quality gates pass
- ✓ Story marked COMPLETE in progress.txt
- ✓ Commit pushed
- ✓ Learnings stored in memory
- ✓ Dependencies tracked for next story
