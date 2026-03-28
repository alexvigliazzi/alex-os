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

## Story State Tracking

```
[STORY-1] Feature X
  Status: In Progress
  Started: 2026-03-18
  Context: [link to prior decisions]
  Progress: Implementation 60%

  Blockers: None
  Next: Quality gate review
```

## Exit Criteria

- ✓ All quality gates pass
- ✓ Story marked COMPLETE in progress.txt
- ✓ Commit pushed
- ✓ Learnings stored in memory
- ✓ Dependencies tracked for next story

---

## SESSION-CLOSE (obrigatório antes de parar)

**Trigger:** qualquer sessão com código, decisões ou padrões produzidos.

### Passos (nesta ordem):

1. **Gerar digest**
   - Usar template `~/.claude/memory/templates/session-digest.md`
   - Preencher todas as seções com base na sessão atual
   - Ler o ID da database de `~/.claude/memory/notion-db-id.txt`

2. **Salvar arquivo**
   - Path: `~/.claude/memory/sessions/YYYY-MM-DD_{proj}_{session_id}.md`
   - Exemplo: `2026-03-23_SisAlmoxIBTEC_a1b2c3.md`
   - Prefixo de data obrigatório (garante ordenação no export)

3. **ciam store** (via MCP)
   - Se ciam offline: logar no campo Blockers do digest, continuar

4. **Notion — criar página**
   - Tool: `notion-create-pages`
   - Database ID: ler de `~/.claude/memory/notion-db-id.txt` (chave NOTION_DB_ID)
   - Antes de criar: verificar se já existe página com session_id nas Tags
   - Mapeamento frontmatter → propriedades Notion:
     | Campo           | Propriedade Notion | Tipo         |
     |-----------------|--------------------|--------------|
     | `data`          | Data               | date         |
     | `projeto`       | Projeto            | select       |
     | `agentes`       | Agentes            | multi_select |
     | `tags`          | Tags               | multi_select |
     | `tokens_usados` | Tokens             | number       |
     | título H1       | Title              | title        |
     | `session_id`    | Tags               | multi_select |
   - Tipo: `session-digest` | Status: `archived`

5. **Obsidian**
   - Nenhuma ação — Stop hook exporta automaticamente
