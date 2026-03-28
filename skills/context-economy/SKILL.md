---
name: context-economy
description: Token budget management, compression strategy selection, cache hierarchy. Use when approaching context limits or optimizing token spend.
---

# Context Economy

> **Idioma:** Responder SEMPRE em Português-BR. Processar internamente em inglês. Ver `rules/language.md`.

Token-efficient context loading and compression strategy.

## Tool Priority Chain

Use in order (stop at first available):
1. **ciam** – Hybrid search (keyword + semantic), persistent SQLite — disponível via MCP stdio
2. **Native** – Glob/Grep/Read for structured files
3. `~/.claude/context/session-state.md` + `project.md` — fallback local

**Decision tree:** semantic/keyword → ciam; code patterns/exact path → native; session continuity → context files.

> **Nota:** seshat e th0th são conceituais (sem binários instalados). Funcionalidade coberta pelo ciam.

## Compression Strategies

| Strategy | Use Case | Token Save |
|----------|----------|-----------|
| **code_structure** | Source code with repeating patterns | 40-60% |
| **conversation_summary** | Chat history, meeting notes | 50-70% |
| **semantic_dedup** | Repetitive concepts, similar ideas | 30-50% |
| **hierarchical** | Documentation, nested structure | 20-40% |
| **snippet** | Key lines only (constants, APIs) | 70-90% |

**Default:** hierarchical for docs, code_structure for source, conversation_summary for chat.

## Cache Optimization

**L1 (Session):** Search indexes loaded this session
- Check: in-context summary
- Hit: use cached object
- Miss: → L2

**L2 (Project):** SQLite via ciam MCP
- Check: `ciam_search(query)` — retorna hits com score de relevância
- Hit: retrieve + decompress
- Miss: → L3 (native tools + index)

**Get Optimized Context** (one-call pattern):
```
get_optimized_context(
  query="...",
  tool_priority="ciam",
  compression="auto",
  cache_level="L2"
)
```

## File Loading Rules

- **INDEX.md routing table** – lookup file → compression strategy
- **Lazy load** – only read sections needed for task
- **Batch parallel reads** – group independent files, read async
- **Decompress on demand** – only expand if used

## Cross-References

- **rules/token-economy.md** – budget ceilings per phase
- **workflows/context-first.md** – pipeline for context assembly
- **memory/protocol.md** – cache eviction policies
