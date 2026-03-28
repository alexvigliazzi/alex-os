# CLAUDE WORKSPACE INDEX
# Load ONLY what's needed. Never load all files at once.

## Quick Routing Table
| Need | Load |
|------|------|
| Start session | `rules/constitution.md` |
| Pick agent | `agents/_registry.md` |
| Choose workflow | `workflows/_router.md` |
| Token budget | `rules/token-economy.md` |
| Security check | `rules/security.md` |
| Authority question | `rules/authority.md` |
| Memory ops | `memory/protocol.md` |
| Find reference | `references/catalog.md` |
| Skill details | `skills/{name}/SKILL.md` |

## File Budget Guide
- **Micro task** (<5 min): constitution + registry = ~800 tokens
- **Standard task**: + workflow + 1 agent = ~2000 tokens
- **Complex task**: + authority + token-economy + skill = ~3500 tokens
- **Full context**: all files = ~6000 tokens (avoid unless necessary)

## Directory Map
```
.claude/
├── INDEX.md              ← YOU ARE HERE
├── agents/
│   ├── _registry.md      ← Agent roster + triggers (load first)
│   ├── strategist.md     ← Planning, specs, PRDs
│   ├── architect.md      ← System design, complexity
│   ├── developer.md      ← Implementation, code
│   ├── reviewer.md       ← QA, security, tests
│   ├── orchestrator.md   ← Workflow coordination
│   └── ops.md            ← DevOps, deploy, CI/CD
├── rules/
│   ├── constitution.md   ← IMMUTABLE core rules
│   ├── security.md       ← Block/allow conditions
│   ├── authority.md      ← Who does what (exclusive ops)
│   └── token-economy.md  ← Budget, compression, caching
├── workflows/
│   ├── _router.md        ← Workflow selector (load first)
│   ├── context-first.md  ← Context acquisition pipeline
│   ├── development.md    ← Dev cycle (story→code→review)
│   ├── test-deploy.md    ← Testing + deployment pipeline
│   ├── documentation.md  ← Doc generation pipeline
│   └── problem-resolution.md ← Debug + conflict resolution
├── skills/
│   ├── orchestration-engine/SKILL.md
│   ├── context-economy/SKILL.md
│   └── adaptive-governance/SKILL.md
├── memory/
│   ├── protocol.md       ← Memory lifecycle rules
│   └── sessions/         ← Session digest storage
└── references/
    └── catalog.md        ← What's in references/ folder
```
