---
description: Convocar o Orchestrator — Coordenação multi-agente, roteamento de workflow, phase gate management. Use quando uma tarefa requer múltiplos agentes em sequência.
allowed-tools: [Read, Glob, Grep, Agent, TodoWrite]
---

# Orchestrator — Dev Domain

Carregar e operar conforme o agent definition em `~/.claude/agents/dev/orchestrator.md`.

## Instruções

1. Ler `~/.claude/agents/dev/orchestrator.md` — carregar persona completa do Orchestrator
2. Ler `~/.claude/agents/_registry.md` — roteamento disponível
3. Ler `~/.claude/context/session-state.md` — contexto de sessão
4. Analisar `$ARGUMENTS`: decompor tarefa em fases → atribuir agente por fase → gerenciar gates

## Quando usar

- Tarefas que exigem Strategist → Architect → Developer → Reviewer → Ops em sequência
- Workflows multi-agente complexos
- Roteamento e despacho de agentes especializados
- Gestão de phase gates (aprovação entre fases)
- Escalação cross-domínio

ARGUMENTS: $ARGUMENTS
