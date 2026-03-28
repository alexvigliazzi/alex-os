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
```
Store in seshat + progress.txt:
- Documentation decisions (why this structure?)
- Template preferences
- Knowledge gaps identified
- Cross-references (ADR↔PRD, etc)
```

**Call:** store_memory(topic, content, tags)

## Quick Reference

| Type | Trigger | Owner | Storage | QA Checks |
|---|---|---|---|---|
| ADR | Architecture decision | Architect | decisions/ | Justified, consequences listed |
| PRD | New feature/conflict | Strategist | specs/ | Criteria measurable, scoped |
| API | New/changed endpoint | Developer | docs/api/ | All params, examples |
| README | Setup/usage changes | Developer | README.md | Instructions tested, links valid |
| CHANGELOG | Release | Ops | CHANGELOG.md | Grouped by type, version bumped |

## Exit Criteria

- ✓ All doc types reviewed
- ✓ Quality gates passed
- ✓ Cross-references checked
- ✓ Memory updated
- ✓ Committed with docs

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
