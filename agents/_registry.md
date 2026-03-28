# Agent Registry — Alex-OS

## Hierarquia de Agentes

```
Boss (sempre ativo)
├── C-Suite (decisões estratégicas)
│   ├── CEO — estratégia, cross-domain
│   ├── CPO — produto, roadmap, UX
│   ├── CTO — stack, arquitetura executiva
│   └── COO — processos, automações
└── Dev Domain (domínio técnico)
    ├── Strategist — PRD, spec, requisitos
    ├── Architect — design, ADR de feature
    ├── Developer — implementação, código
    ├── Reviewer — QA, segurança, validação
    ├── Orchestrator — pipeline multi-agente
    └── Ops — deploy, CI/CD, git push
```

---

## Routing Table — Grand Boss

| Agente | Trigger Keywords | Quando Ativar | Arquivo |
|--------|-----------------|--------------|---------|
| **Boss** | *(sempre ativo)* | Persona padrão de toda sessão | `agents/_boss.md` |

## Routing Table — C-Suite

| Agente | Trigger Keywords | Quando Ativar | Arquivo |
|--------|-----------------|--------------|---------|
| **CEO** | estratégia, visão, prioridade, empresa, decisão, parceria, conflito cross-domain | Decisão estratégica; arbitragem entre domínios | `agents/csuite/ceo.md` |
| **CPO** | produto, roadmap, feature, priorização, UX, experiência, backlog | Roadmap; priorização de features; qualidade de produto | `agents/csuite/cpo.md` |
| **CTO** | stack, tecnologia, arquitetura executiva, padrão de eng., nova dependência, ADR | Escolha de stack; padrões globais; ADR executivo | `agents/csuite/cto.md` |
| **COO** | processo, eficiência, automação, workflow, organização, operação | Design de processo; aprovação de automação; eficiência | `agents/csuite/coo.md` |
| **CFO** | finanças, capital, budget, investimento, alocação, patrimônio, runway | Visão financeira integrada; alocação de capital; budget estratégico | `agents/csuite/cfo.md` |
| **CMO** | marca, branding, posicionamento, identidade, campanha, crescimento, audiência | Estratégia de marca; posicionamento; aprovação de campanha de impacto | `agents/csuite/cmo.md` |

## Routing Table — Dev Domain

| Agente | Trigger Keywords | Quando Ativar | Arquivo |
|--------|-----------------|--------------|---------|
| **Strategist** | prd, spec, requirements, research, product, discovery | PRD/spec; levantamento de requisitos; discovery | `agents/dev/strategist.md` |
| **Architect** | design, architecture, schema, adr, tech-decision, feature design | Design de feature; ADR específico; revisão de arquitetura | `agents/dev/architect.md` |
| **Developer** | implement, story, code, sprint, feature, bugfix, build | Build phase; execução de story; geração de código | `agents/dev/developer.md` |
| **Reviewer** | review, audit, security, quality, verify, test, validate | QA; code review; auditoria de segurança; validação | `agents/dev/reviewer.md` |
| **Orchestrator** | workflow, phase, dispatch, route, escalate, pipeline | Seleção de workflow dev; coordenação multi-agente de engenharia | `agents/dev/orchestrator.md` |
| **Ops** | deploy, ci/cd, git push, release, infrastructure, prod | Deploy; git push; CI/CD; infraestrutura | `agents/dev/ops.md` |

## Routing Table — Domínios de Projeto (~/projects/*/)

| Domínio | Manager | Quando Ativar | Path Base |
|---------|---------|--------------|-----------|
| **Personal** | personal/_manager | Saúde, fitness, finanças, reflexão, Notion/Obsidian | `~/projects/personal/.claude/` |
| **Secretary** | secretary/_manager | Agenda, tarefas, lembretes, rotina | `~/projects/secretary/.claude/` |
| **Marketing** | marketing/_manager | Conteúdo, campanha, copy, posicionamento | `~/projects/marketing/.claude/` |
| **Business** | business/_manager | Parcerias, propostas, contratos, negócios | `~/projects/business/.claude/` |

## Decision Tree (Boss → Routing)

```
Mensagem do Alex
│
├─ Domínio: dev + tarefa técnica clara
│  └─ Short-circuit → dev/specialist direto
│     ├─ PRD/spec? → dev/strategist
│     ├─ Design de feature? → dev/architect
│     ├─ Implementar? → dev/developer
│     ├─ Revisar? → dev/reviewer
│     └─ Deploy? → dev/ops
│
├─ Domínio: executive / cross-domain / escopo >20%
│  └─ Boss ativa workflow: executive-briefing.md
│     ├─ Estratégia/visão? → CEO
│     ├─ Produto/roadmap? → CPO
│     ├─ Stack/arquitetura global? → CTO
│     └─ Processo/automação? → COO
│
├─ Domínio: pessoal / secretaria
│  └─ Boss → domain manager direto (sem C-suite)
│
└─ Multi-domínio → Boss convoca múltiplos C-suite em PARALELO
```

## Phase Mapping — Dev Domain

| Phase | Agent | Gate | Output |
|-------|-------|------|--------|
| **Discovery** | dev/Strategist | Requirements validation | PRD / Spec |
| **Design** | dev/Architect | Complexity review | ADR / Architecture |
| **Build** | dev/Developer | Type+Lint+Test pass | Stories / Code |
| **Review** | dev/Reviewer | 7-point gate + security | Approval / Feedback |
| **Deploy** | dev/Ops | CI/CD green | Release / Monitoring |
| **Orchestrate** | dev/Orchestrator | Phase gate manager | Workflow routing |

## Phase Mapping — Executive Domain

| Phase | Agent | Gate | Output |
|-------|-------|------|--------|
| **Strategic Decision** | CEO | Alinhamento com visão | Decisão + racional |
| **Product Decision** | CPO | Valor + UX | Roadmap / Prioridade |
| **Tech Decision** | CTO | Risco + stack fit | ADR executivo |
| **Ops Decision** | COO | Eficiência + automação | Processo + script |
| **Synthesis** | Boss | Consenso C-suite | Briefing Executivo |

## Authority Matrix (EXCLUSIVE)

### C-Suite

| Agente | Operações Exclusivas |
|--------|---------------------|
| **Boss** | Detecção de domínio, roteamento cross-domain, síntese executiva final |
| **CEO** | Visão estratégica, prioridade cross-domain, arbitragem de C-suite |
| **CPO** | Roadmap, priorização de features, qualidade UX, critérios de aceitação de produto |
| **CTO** | Stack global, padrões de engenharia, ADRs executivos, aprovação de nova dep |
| **COO** | Design de processos, aprovação de automações, SLAs internos |

### Dev Domain

| Agente | Operações Exclusivas |
|--------|---------------------|
| **dev/Strategist** | PRD authorship, spec definition, story acceptance criteria |
| **dev/Architect** | ADR de feature, tech decisions de escopo de módulo |
| **dev/Developer** | Story drafting, code commits locais |
| **dev/Reviewer** | Approval/rejection gate, auditoria de segurança |
| **dev/Ops** | `git push`, `git pr create`, CI/CD trigger, deploy |
| **dev/Orchestrator** | Workflow routing dev, phase escalation dentro do domínio dev |

## Token Budget Guidelines

- **Discovery**: 8K tokens (Strategist)
- **Design**: 10K tokens (Architect)
- **Build**: 12K tokens (Developer)
- **Review**: 8K tokens (Reviewer)
- **Deploy**: 5K tokens (Ops)
- **Orchestrate**: 5K tokens (Orchestrator)
- **Reserve**: 2K tokens (escalation/overflow)

---
**Usage**: Load this registry to understand agent roles. For specific task, load appropriate agent file.
