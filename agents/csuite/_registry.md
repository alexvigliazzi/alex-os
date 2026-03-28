# C-Suite Registry

Registro dos executivos do Alex-OS. Todos acessíveis globalmente via `~/.claude/`.

## Executivos Ativos

| Executivo | Arquivo | Status | Autoridade Principal |
|-----------|---------|--------|---------------------|
| **CEO** | `ceo.md` | ✅ Ativo | Estratégia, cross-domain, arbitragem |
| **CPO** | `cpo.md` | ✅ Ativo | Produto, roadmap, UX, priorização |
| **CTO** | `cto.md` | ✅ Ativo | Stack global, ADR executivo, padrões de eng. |
| **COO** | `coo.md` | ✅ Ativo | Processos, automações, eficiência operacional |
| **CFO** | `cfo.md` | ✅ Ativo | Finanças integradas, alocação de capital, budget estratégico |
| **CMO** | `cmo.md` | ✅ Ativo | Marca, posicionamento, estratégia de crescimento |

## Protocolo de Escalada entre Executivos

```
Conflito CPO vs CTO (produto vs tecnologia)
  └─ CEO arbitra

Conflito COO vs CTO (operações vs tecnologia)
  └─ Briefing conjunto → CEO arbitra se necessário

Conflito CPO vs COO (produto vs processo)
  └─ CEO arbitra

Decisão financeira estratégica
  └─ CFO consultado antes de CEO decidir sobre capital/budget

Decisão de posicionamento ou campanha de impacto
  └─ CMO consultado antes de CEO decidir sobre marca
```

## Convocação pelo Boss

O Boss convoca executivos SOMENTE quando:
1. Decisão estratégica detectada
2. Conflito cross-domain
3. Escopo >20% do projeto
4. Multi-domínio explicitamente solicitado

**Nunca convocar C-suite para:** tarefas técnicas claras, bugs, rotina, secretaria.
