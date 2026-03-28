---
name: adaptive-governance
description: Session lifecycle and memory persistence protocol. Use for onboarding, checkpointing, and session wrap-up.
---

# Adaptive Governance

> **Idioma:** Responder SEMPRE em Português-BR. Processar internamente em inglês. Ver `rules/language.md`.

Session lifecycle and memory persistence protocol.

## Session Lifecycle

1. **Onboard**
   - Load constitution (rules/constitution.md)
   - Check for active session state
   - Restore context from memory/protocol.md

2. **Work**
   - Execute via orchestration-engine
   - Log decisions to session digest
   - Update working memory (L4)

3. **Checkpoint**
   - Validate progress vs plan
   - Assess token burn, quality, alignment
   - Offer pivot or continuation

4. **Handoff**
   - Create session digest (YAML format below)
   - Promote key patterns to persistent memory
   - Archive for next session/agent

## Memory Persistence Protocol

**What to Remember:**
- Explicit user decisions (constraints, preferences, success criteria)
- Proven patterns (code approaches, reasoning shortcuts, API usage)
- Session context (current goals, blockers, constraints)

**What to Forget:**
- Intermediate reasoning (keep conclusions only)
- Repetitive task scaffolds (cache the pattern, discard steps)
- Transient errors (unless they inform patterns)

**TTLs (managed in memory/protocol.md):**
- Decision: 7 days
- Pattern: 30 days
- Preference: 24 hours
- Code: 1 hour
- Conversation: 5 minutes

## Session Digest Format

```yaml
metadata:
  session_id: "uuid"
  agents: ["name1", "name2"]
  duration_minutes: 45
  tokens_used: 12500

corrections:
  - issue: "..."
    fix: "..."

patterns:
  - name: "..."
    description: "..."
    applied: N

axioms:
  - "explicit statement of discovered principle"

context_snapshot:
  active_goals: ["...", "..."]
  open_blockers: ["..."]
  next_steps: ["..."]
```

## Onboarding Ritual

1. Load constitution → establish baseline rules
2. Check memory/protocol.md → restore L1/L2 context
3. Query active session state (agents/_registry.md)
4. Restore previous session digest if exists
5. Confirm user intent before proceeding

## Cross-References

- **memory/protocol.md** – full memory lifecycle, promotion criteria, audit checklist
- **rules/constitution.md** – core governance rules, non-negotiable constraints
