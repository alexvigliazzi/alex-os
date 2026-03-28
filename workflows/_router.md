# Workflow Router — Alex-OS

## Decision Tree

```
Request do Alex
│
├─ DOMÍNIO EXECUTIVO (estratégico, cross-domain, escopo >20%)
│  └─ executive-briefing.md (Boss → C-Suite → Boss)
│
├─ DOMÍNIO DEV (técnico, bem definido)
│  ├─ NEW FEATURE → development.md (Plan + Developer)
│  ├─ BUG FIX → problem-resolution.md (Explore + Developer)
│  ├─ REFACTORING → development.md (Developer + Reviewer)
│  ├─ DOCUMENTATION → documentation.md (Architect)
│  ├─ DEPLOYMENT → test-deploy.md (Ops EXCLUSIVO)
│  ├─ RESEARCH → context-first.md + Explore (read-only)
│  ├─ TDD / TEST-FIRST → sdd-tdd.md (Developer + Reviewer)
│  └─ CONFLICT/DECISION → problem-resolution.md (Plan + Explore)
│
├─ DOMÍNIO PESSOAL → ~/projects/personal/.claude/
└─ DOMÍNIO SECRETARIA → ~/projects/secretary/.claude/
```

## Routing Table

| Request Pattern | Workflow | Lead Agent | Complexity Gate |
|---|---|---|---|
| "Quero decidir X" / "Devo priorizar Y?" | executive-briefing | Boss → CEO/CPO/CTO/COO | EXECUTIVE |
| "Estratégia de [qualquer coisa]" | executive-briefing | Boss → CEO | EXECUTIVE |
| "Avalie [técnico] e [financeiro/produto]" | executive-briefing | Boss → múltiplos (paralelo) | EXECUTIVE |
| "Add feature X" | development | Developer | STANDARD/COMPLEX |
| "Fix bug Y" | problem-resolution | Explore → Developer | Auto-detect |
| "Refactor Z" | development | Developer + Reviewer | STANDARD |
| "Document X" | documentation | Architect | SIMPLE |
| "Deploy to prod" | test-deploy | Ops | COMPLEX (requires approval) |
| "Error: X occurs" | problem-resolution | Explore | Auto-detect |
| "TDD / write tests first" | sdd-tdd | Developer + Reviewer | STANDARD |
| "Should we X?" (técnico) | problem-resolution | Plan → Explore | SIMPLE |

## Complexity Gates

### SIMPLE (skip spec, quick loop)
- Bug fixes < 50 LOC
- Documentation updates
- Configuration changes
- One-file refactors

**Skip to:** spec→story→implement→review→commit

### STANDARD (full context + spec check)
- Feature additions
- Multi-file changes
- Cross-module refactors

**Skip to:** context-first→spec check→story→impl→review→commit

### COMPLEX (full pipeline + checkpoints)
- Architecture changes
- New dependencies
- Deployments
- Long investigations

**Skip to:** context-first→research→spec→story→impl→review→memory→commit/deploy

## Entry Point Logic

1. Classify request by keywords
2. Apply complexity gate
3. Load corresponding workflow file
4. Execute lead agent assignment
5. Initialize context budget
