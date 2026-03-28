---
description: Run the Documentation Pipeline (scan gaps → ADRs → PRDs → API docs → README/CHANGELOG → memory)
allowed-tools: [Read, Edit, Write, Glob, Grep, TodoWrite, Agent]
---

# Documentation Pipeline

Integrated generation and persistence workflow.

## Pipeline Stages

### Stage 1: Context Scan
```
Audit: What documentation exists?
├─ README.md
├─ ADRs (decisions/)
├─ PRDs (specs/)
├─ API docs (docs/api/)
├─ CHANGELOG.md
└─ Inline code comments

Output: Gap analysis matrix
```

### Stage 2: ADR Generation (Architect)
**When to generate:** Architecture decisions, significant tradeoffs, tech stack choices

**MADR 3.0:** Title | Context | Decision | Consequences | Alternatives Considered

**Store:** decisions/ADR-NNN.md + seshat (ciam_remember)

### Stage 3: PRD Generation (Architect + Strategist)
**When to generate:** New feature, unclear requirements, scope disputes

**Ralph pattern:** Clarifying questions → Problem | Success Criteria | Scope | Dependencies | Timeline | Open Questions

**Store:** specs/PRD-[date].md + progress.txt

### Stage 4: API Documentation
New endpoints/breaking changes → OpenAPI/Swagger or docs/api/ with per-endpoint schema, examples, status codes

### Stage 5: README/CHANGELOG Updates
```
README: Update if
├─ New setup instructions
├─ New commands/CLI flags
├─ Major architecture change
└─ Breaking API changes

CHANGELOG: Add entry if
├─ Feature release
├─ Bug fix
├─ Breaking change
└─ Deprecation notice
```

**Format (CHANGELOG):**
```
## [Version] - YYYY-MM-DD

### Added
- New feature X

### Changed
- Updated behavior Y

### Fixed
- Bug Z resolved

### Deprecated
- Old API endpoint
```

### Stage 6: Memory Persistence
Store in seshat + progress.txt: documentation decisions, template preferences, knowledge gaps, cross-references (ADR↔PRD)

## Exit Criteria

- ✓ All doc types reviewed
- ✓ Quality gates passed
- ✓ Cross-references checked
- ✓ Memory updated
- ✓ Committed with docs
