---
description: Run the Context-First Acquisition Pipeline. Execute BEFORE any STANDARD/COMPLEX task to load memories, decisions, and set token budget.
allowed-tools: [Read, Glob, Grep, TodoWrite]
---

# Context-First Acquisition Pipeline

**Trigger:** All STANDARD/COMPLEX tasks. Runs BEFORE any other workflow.

## Tool Priority Order

1. **ciam MCP** (primary — available via stdio)
   - `ciam_search(query)` — semantic search across memories + decisions
   - `ciam_decision_context(topic)` — prior ADRs and decisions for a component
   - `ciam_plan_search(query)` — prior plans and specs

2. **Native tools** (fallback)
   - `Glob` → file discovery
   - `Grep` → pattern search in code
   - `Read` → load specific files

3. **Context files** (always load)
   - `~/.claude/context/session-state.md` — last session continuity
   - `~/.claude/context/project.md` — stack, conventions, active work

> **Note:** seshat disponivel via Docker (porta 3333) como complemento ao ciam.
> th0th removido — supersedido pelo ciam.

## Acquisition Steps

### Step 1: Search Existing Context
```
Input: task description + keywords
Call: ciam_search(query) [if MCP available]
Fallback: Grep codebase for task keywords
Output: ranked context snippets + memory references
```

### Step 2: Load Decision Context
```
Call: ciam_decision_context(component/topic) [if MCP available]
Extract: prior decisions, rationale, constraints
Fallback: Read ~/.claude/context/session-state.md
```

### Step 3: Compress if Over Budget
```
If context tokens > 60% of available:
  Summarize loaded context manually (hierarchical compression)
  Keep: dependencies, decisions, API contracts
  Drop: boilerplate, repetitive examples
```

### Step 4: Reference Catalog Check
```
Read: ~/.claude/references/catalog.md (applicable sections)
Load: ADRs, PRDs, patterns relevant to task
```

### Step 5: Token Budget Allocation
```
Available budget - context size = remaining tokens
Allocate: 20% for memory updates, 80% for work
```

## Token Budget Template

```
Total available: [X] tokens
├─ Context loaded: [A] tokens (max 20% of budget)
├─ Work allocation: [B] tokens (80% min)
└─ Memory save: [C] tokens (5% reserve)
```

## Fallback Chain

| Scenario | Action |
|---|---|
| ciam MCP unavailable | Use native Glob/Grep/Read |
| No prior decisions found | Continue; document new decisions at end |
| Context over budget | Compress (hierarchical strategy) then continue |

## Exit Criteria

- ✓ Context budget established
- ✓ Prior decisions documented (or confirmed none exist)
- ✓ Relevant session history loaded
- ✓ Reference catalog checked
- ✓ Ready to proceed to next workflow stage
