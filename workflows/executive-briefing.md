# Workflow: Executive Briefing

**Ativado por:** Boss — quando detecta decisão estratégica, multi-domínio ou escopo >20%
**Lead:** Boss → C-Suite → Specialists → Boss
**NÃO ativar para:** tarefas técnicas claras, rotina, secretaria, requests bem definidos

---

## Triggers de Ativação

Ativar este workflow quando o request do Alex:

| Trigger | Exemplo |
|---------|---------|
| Decisão ambígua ou estratégica | "O que devo priorizar agora?" |
| Conflito cross-domain | "Vale mais a pena X ou Y?" |
| Escopo >20% do projeto | "Quero mudar a arquitetura de autenticação" |
| Multi-domínio explícito | "Avalie o técnico e o financeiro de X" |
| Direção/visão | "Para onde devo focar nos próximos 3 meses?" |
| Decisão de alto impacto | "Devemos adotar [nova tecnologia/parceria]?" |

---

## Pipeline

```
BOSS detecta: decisão estratégica / multi-domínio / escopo >20%
      │
      ▼
FASE 1: BRIEFING PREPARATION (Boss)
─────────────────────────────────
• Extrair contexto relevante da mensagem
• Identificar qual(is) executivo(s) convocar (1-3 máximo)
• Formular pergunta específica para cada executivo
• Definir prazo de síntese (1, 2 ou 3 turnos)
      │
      ▼
FASE 2: EXECUTIVE CONSULTATION (C-Suite)
─────────────────────────────────────────
• Se 1 domínio → consultar 1 executivo sequencialmente
• Se 2+ domínios → consultar múltiplos EXECUTIVOS EM PARALELO
• Cada executivo recebe: contexto completo + pergunta específica
• Cada executivo entrega: posição + racional + condições + próximo passo
• Se executivos divergem → CEO arbitra (fase 2b)
      │
      ▼
FASE 3: SPECIALIST EXECUTION (se necessário)
──────────────────────────────────────────────
• Executivo passa spec/decisão para specialist do domínio
• Specialist executa e reporta ao executivo responsável
• Exemplos:
  - CTO → dev/architect (design técnico)
  - CPO → dev/strategist (PRD de produto)
  - COO → dev/ops (implementar automação)
      │
      ▼
FASE 4: CONSOLIDATION (Boss)
──────────────────────────────
• Boss recebe resultados de todos os executivos
• Identifica consensos e divergências
• Se conflito → CEO arbitra antes de sintetizar
• Boss compõe Briefing Executivo final
      │
      ▼
FASE 5: DELIVERY (Boss → Alex)
────────────────────────────────
• Boss apresenta Briefing Executivo ao Alex
• Formato: ver template em assets/templates/executive-summary.md
• Alex responde: aprovar, pedir ajustes ou escalar
```

---

## Tempo Esperado por Complexidade

| Tipo de Decisão | Executivos | Turnos |
|----------------|------------|--------|
| Single-domain, clara | 1 executivo | 1–2 |
| Cross-domain, moderada | 2 executivos (paralelo) | 2–3 |
| Estratégica, empresa/vida | CEO + relevantes | 3–5 |

---

## Formato de Briefing Executivo (Entrega ao Alex)

```markdown
## Briefing Executivo

**Data:** {{DATE}}
**Domínio(s):** {{DOMAINS}}
**Agentes consultados:** {{AGENT_LIST}}

---

**Decisão / Output:**
{{SYNTHESIS — 2-3 linhas concisas}}

**Racional:**
{{WHY — foco em alinhamento com visão do Alex}}

**Alternativa considerada:**
{{ALTERNATIVE — e por que não foi escolhida}}

**Próximos passos:**
1. {{STEP_1 + owner}}
2. {{STEP_2 + owner}}
3. {{STEP_3 + owner — se necessário}}

**Escalação ao Alex necessária:** [Sim — {{motivo}} | Não]
```

---

## Short-Circuit (NÃO Usar Este Workflow Quando)

| Request | Rota correta |
|---------|-------------|
| "Corrija o bug na linha 42" | → dev/developer direto |
| "Lembre-me de reunião amanhã" | → secretary direto |
| "Explique este código" | → contexto direto |
| "Implemente a feature X do PRD" | → workflow: development.md |
| "Deploy para produção" | → workflow: test-deploy.md |

---

## Autoridade neste Workflow

| Papel | Autoridade |
|-------|------------|
| **Boss** | Ativa/encerra o workflow, sintetiza, entrega ao Alex |
| **CEO** | Arbitra divergências, decisão final cross-domain |
| **CPO/CTO/COO** | Posição técnica/de produto/operacional nos seus domínios |
| **Specialists** | Executam decisões dos executivos |
| **Alex** | Aprova ou rejeita o Briefing Executivo |

---
**Carregado por:** Boss quando detecta triggers acima
**Alternativo ao:** workflows de domínio específico (development, problem-resolution, etc.)
