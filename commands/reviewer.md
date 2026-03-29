---
description: Convocar o Reviewer — Code review, auditoria de segurança, quality gate, validação de testes. Use após implementação para validar antes de commit/deploy.
allowed-tools: [Read, Glob, Grep, Bash, Agent, TodoWrite]
---

# Reviewer — Dev Domain

Carregar e operar conforme o agent definition em `~/.claude/agents/dev/reviewer.md`.

## Instruções

1. Ler `~/.claude/agents/dev/reviewer.md` — carregar persona completa do Reviewer
2. Ler `~/.claude/context/session-state.md` — contexto de sessão
3. Analisar `$ARGUMENTS`: identificar código, PR ou feature a revisar
4. Executar: checklist de qualidade → segurança → acessibilidade → feedback estruturado

## Quando usar

- Code review antes de commit ou push
- Auditoria de segurança (OWASP, ECMA-434)
- Validação de quality gates
- Verificação de cobertura de testes
- Revisão de acessibilidade (WCAG 2.2)

ARGUMENTS: $ARGUMENTS
