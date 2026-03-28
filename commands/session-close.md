---
description: Close the current session — write digest to sessions/, update session-state.md, confirm Stop hook will export to Obsidian.
allowed-tools: [Write, Read, Bash]
---

# Session Close

Execute at the end of any significant work session. This is the ONLY step that creates the digest the Stop hook needs to export to Obsidian.

## Step 1 — Collect Session Data

Gather from the current conversation:
- Date: today's date (YYYY-MM-DD format)
- Agents used: which roles were active (Developer, Reviewer, Ops, etc.)
- Tokens used: estimate from context budget
- What was done: concise bullet list of completed actions and results
- Decisions taken: architectural or technical choices made, with rationale
- Patterns discovered: reusable patterns identified this session
- Blockers & deviations: issues encountered and how they were resolved (or "pending: reason")
- Axiom candidates: principles applicable across multiple projects (omit if none)
- Next steps: concrete next actions + dependencies for next session

## Step 2 — Write Session Digest

Write the digest to:
`~/.claude/memory/sessions/YYYY-MM-DD_HHmm_session.md`

Use the template from `~/.claude/memory/templates/session-digest.md`.

Filename format: `2026-03-25_1430_session.md` (date + 24h time, no seconds).

## Step 3 — Update session-state.md

Overwrite `~/.claude/context/session-state.md` with a condensed version:

```markdown
# Session State — Última Sessão
# Atualizado automaticamente pelo session-close em YYYY-MM-DD HH:MM

## Última Sessão
- **Data**: YYYY-MM-DD
- **Agentes usados**: [lista]
- **Tokens usados**: [estimativa]

## O que foi feito
- [item 1]
- [item 2]

## Bloqueadores Abertos
- [bloqueador] ou "Nenhum"

## Próximos Passos Sugeridos
- [passo 1]
- [passo 2]
```

## Step 4 — Confirm

Tell the user:
> "Session digest written to `sessions/YYYY-MM-DD_HHmm_session.md`. When you exit Claude Code, the Stop hook will automatically export it to your Obsidian vault at `02_Relatorios_e_Sessoes/Dev/`."

## Notes

- If the session was trivial (< 5 min, no decisions), skip writing to sessions/ but still update session-state.md
- Never overwrite an existing digest for the same session — append `_v2` to filename if needed
- The Stop hook reads `sessions/*.md` sorted lexicographically — filename prefix YYYY-MM-DD ensures correct ordering
