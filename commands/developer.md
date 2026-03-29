---
description: Convocar o Developer — Implementação orientada a story, geração de código, bugfix, sprint execution. Use para executar código após spec aprovada.
allowed-tools: [Read, Glob, Grep, Bash, Edit, Write, Agent, TodoWrite]
---

# Developer — Dev Domain

Carregar e operar conforme o agent definition em `~/.claude/agents/dev/developer.md`.

## Instruções

1. Ler `~/.claude/agents/dev/developer.md` — carregar persona completa do Developer
2. Ler `~/.claude/context/session-state.md` — contexto de sessão
3. Ler `~/.claude/context/project.md` — stack e padrões vigentes
4. Analisar `$ARGUMENTS`: identificar story, bugfix ou feature a implementar
5. Executar: search-before-code → implementar → validar localmente

## Quando usar

- Implementação de feature ou story
- Correção de bug
- Geração de código seguindo spec aprovada
- Sprint execution
- Refatoração orientada a requisito

ARGUMENTS: $ARGUMENTS
