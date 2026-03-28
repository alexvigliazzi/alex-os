---
name: orchestration-engine
description: Multi-agent dispatch, workflow phase gates, agent routing. Use to coordinate complex multi-agent tasks.
---

# Orchestration Engine

> **Idioma:** Responder SEMPRE em Português-BR. Processar internamente em inglês. Ver `rules/language.md`.

Multi-agent coordination protocol for phase-gated request handling.

## Core Protocol

**Request Flow:**
1. **Socratic Gate** – Assess complexity & readiness
2. **Phase Gate** – Planning → Checkpoint → Execution → Validation
3. **Multi-agent Dispatch** – Route via agents/_registry.md
4. **Handoff** – Pass context & state between agents

## Complexity Classification

- **SIMPLE** (≤8 tokens/subtask) – Direct execution, single agent
- **STANDARD** (9-15) – 2-3 agents, one checkpoint
- **COMPLEX** (≥16) – 4+ agents, multiple checkpoints, Socratic Gate required

## Socratic Gate

Ask clarifying questions **if**:
- Request has implicit dependencies
- Scope is ambiguous (unclear depth/breadth)
- Risk of misalignment (security, cost, data)
- User appears to need guidance

**Proceed without** if:
- Explicit scope + clear success criteria
- User requests speed over exploration
- Prior session context confirms intent

## Phase Gates

### Planning
- Load agents/_registry.md → identify qualified agents
- Classify request complexity
- Allocate token budget from rules/token-economy.md
- Flag blockers (missing tools, perms, context)

### Checkpoint
- Validate intermediate outputs
- Check token budget vs actual burn
- Escalate if drift detected
- Offer pivot or continuation

### Execution
- **Select model** via skills/model-router scoring before spawning subagent
- Dispatch via workflows/_router.md
- Maintain agent isolation (no state bleed)
- Log handoff events + model used

### Validation
- Verify outputs match request criteria
- Update session digest (memory/protocol.md)
- Archive decision log for next session

## Token Budget Strategy

- Reserve 20% for validation & summary
- Phase allocation: Planning 15% → Checkpoint 10% → Execution 60% → Validation 15%
- Reallocate mid-session if checkpoint detects surplus

## Cross-References

- **agents/_registry.md** – agent capabilities, TTLs, constraints
- **workflows/_router.md** – dispatch logic and handoff protocol
- **rules/token-economy.md** – budget ceilings, compression rules
- **memory/protocol.md** – session digest format for handoff context
- **skills/model-router** – model selection scoring per subagent task
