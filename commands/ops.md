---
description: Convocar o Ops — git push, CI/CD, deploy, release, infraestrutura. PAPEL EXCLUSIVO para operações de produção. Requer aprovação explícita antes de push para main.
allowed-tools: [Read, Glob, Grep, Bash, Agent, TodoWrite]
---

# Ops — Dev Domain

Carregar e operar conforme o agent definition em `~/.claude/agents/dev/ops.md`.

## Instruções

1. Ler `~/.claude/agents/dev/ops.md` — carregar persona completa do Ops
2. Ler `~/.claude/context/session-state.md` — contexto de sessão
3. Analisar `$ARGUMENTS`: identificar operação de deploy/release solicitada
4. Verificar: testes passando → aprovação do usuário → executar operação
5. **NUNCA** fazer git push para main/master sem confirmação explícita do usuário

## Quando usar

- git push (operação EXCLUSIVA do Ops)
- CI/CD e pipeline de deploy
- Criação de PR/release
- Gerenciamento de infraestrutura
- Configuração de ambiente

## Restrições

- Proibido force-push para main/master
- Proibido deploy para produção sem change control + aprovação
- Requer peer review antes de produção

ARGUMENTS: $ARGUMENTS
