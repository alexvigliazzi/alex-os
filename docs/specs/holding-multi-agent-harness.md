# Harness Architecture: Multi-Agent System for a Holding Company

> **Spec Status:** Draft v1.0
> **Author:** Alex-OS Architecture Team
> **Date:** 2026-04-04
> **Related:** `agents/_registry.md`, `skills/orchestration-engine/SKILL.md`, `workflows/_router.md`

---

## 1. Problem Statement

A **holding company** composed of multiple subsidiaries (empresas) and internal sectors needs a structured multi-agent harness that can:

- Represent the corporate hierarchy faithfully (holding → subsidiaries → departments → teams)
- Route requests to the correct organizational level and domain
- Coordinate cross-subsidiary operations without bottlenecks
- Scale from a single enterprise to dozens of subsidiaries
- Maintain governance, memory isolation, and audit trails across boundaries

This document defines the **harness structure** -- the scaffolding that determines how agents, sub-agents, and orchestrators are organized, connected, and governed.

---

## 2. Core Concepts

### 2.1 Harness vs. Squad vs. Pipeline

| Concept | Scope | Analogy |
|---------|-------|---------|
| **Harness** | The full organizational topology of agents across the holding | Corporate org chart |
| **Squad** | A task-specific team of agents assembled for a mission | Project team / task force |
| **Pipeline** | A sequence of steps within a squad execution | Standard operating procedure |

The **harness** is the persistent structure. Squads are ephemeral teams spawned within it. Pipelines are the execution paths within squads.

### 2.2 Agent Tiers

```
Tier 0 — Holding Orchestrator (Grand Boss)
Tier 1 — Subsidiary Orchestrators (Company Bosses)
Tier 2 — Domain Executives (C-Suite per subsidiary)
Tier 3 — Department Heads (Domain Managers)
Tier 4 — Specialists (Execution Agents)
```

Each tier has distinct **authority**, **token budget**, and **escalation rules**.

---

## 3. Harness Topology

### 3.1 Full Hierarchy Diagram

```
                    ┌─────────────────────────┐
                    │   HOLDING ORCHESTRATOR   │
                    │   (Grand Boss / Tier 0)  │
                    └───────────┬─────────────┘
                                │
            ┌───────────────────┼───────────────────┐
            │                   │                   │
    ┌───────▼───────┐   ┌──────▼────────┐   ┌─────▼───────┐
    │  Subsidiary A  │   │ Subsidiary B  │   │ Subsidiary N │
    │  (Tier 1 Boss) │   │ (Tier 1 Boss) │   │ (Tier 1 Boss)│
    └───────┬───────┘   └──────┬────────┘   └─────┬───────┘
            │                  │                   │
    ┌───────┼───────┐          │            ┌──────┼──────┐
    │       │       │          │            │      │      │
  ┌─▼─┐  ┌─▼─┐  ┌─▼─┐     ┌──▼──┐      ┌──▼─┐ ┌─▼─┐ ┌─▼──┐
  │CEO│  │CTO│  │CFO│     │CEO  │      │CEO │ │COO│ │CMO │
  └─┬─┘  └─┬─┘  └─┬─┘     └──┬──┘      └──┬─┘ └─┬─┘ └─┬──┘
    │       │       │          │            │      │      │
  Dept    Dept    Dept       Dept         Dept   Dept   Dept
  Heads   Heads   Heads     Heads        Heads  Heads  Heads
    │       │       │          │            │      │      │
  Specs   Specs   Specs     Specs        Specs  Specs  Specs
```

### 3.2 Holding Orchestrator (Tier 0)

The single entry point for all requests across the holding. Extends the existing `_boss.md` pattern.

**Responsibilities:**
- Identify which subsidiary a request targets
- Route cross-subsidiary requests (dispatching multiple Tier 1 bosses in parallel)
- Synthesize consolidated reports across subsidiaries
- Enforce holding-level governance policies
- Manage shared resource allocation

**Registry File:** `agents/holding/_orchestrator.md`

```yaml
# holding/_orchestrator.md frontmatter
---
name: holding-orchestrator
tier: 0
authority: holding-wide
subsidiaries:
  - subsidiary-a
  - subsidiary-b
  - subsidiary-n
escalation: user  # Tier 0 escalates directly to the human
token_budget: unlimited  # orchestration only, no execution
---
```

### 3.3 Subsidiary Orchestrator (Tier 1)

Each subsidiary gets its own boss agent -- a scoped version of the Grand Boss that knows only about its company's domains.

**Responsibilities:**
- Route requests within its subsidiary
- Manage the subsidiary's C-Suite
- Report upward to the Holding Orchestrator
- Maintain subsidiary-specific memory and context

**Registry File:** `agents/holding/{subsidiary}/boss.md`

```yaml
---
name: subsidiary-a-boss
tier: 1
authority: subsidiary-a
parent: holding-orchestrator
domains:
  - dev
  - marketing
  - finance
  - operations
  - product
escalation: holding-orchestrator
token_budget: from_parent
---
```

### 3.4 Domain Executives (Tier 2) -- C-Suite per Subsidiary

Each subsidiary instantiates the relevant C-Suite agents, scoped to that subsidiary's context.

**Key difference from alex-os base:** Agents are **namespaced** per subsidiary to avoid collision.

```
Agent ID format: {subsidiary}:{role}
Examples:
  subsidiary-a:ceo
  subsidiary-a:cto
  subsidiary-b:cfo
```

### 3.5 Department Heads (Tier 3) and Specialists (Tier 4)

These follow the existing `dev/*` pattern from alex-os, but are scoped per subsidiary and department.

```
Agent ID format: {subsidiary}:{department}:{role}
Examples:
  subsidiary-a:dev:architect
  subsidiary-a:dev:developer
  subsidiary-b:marketing:copywriter
  subsidiary-b:finance:analyst
```

---

## 4. Routing Protocol

### 4.1 Request Classification

Every incoming request goes through a **3-pass classification**:

```
Pass 1: SCOPE — Which subsidiary(ies) does this affect?
  ├── Single subsidiary → Route to Tier 1 Boss
  ├── Multiple subsidiaries → Holding Orchestrator dispatches in parallel
  └── Holding-wide policy → Holding Orchestrator handles directly

Pass 2: DOMAIN — Which domain within the subsidiary?
  ├── Single domain, clear task → Short-circuit to Tier 4 specialist
  ├── Single domain, strategic → Route to Tier 2 C-Suite
  ├── Multi-domain → Tier 1 Boss dispatches multiple C-Suite in parallel
  └── Cross-domain conflict → Tier 2 CEO arbitrates

Pass 3: COMPLEXITY — How complex is the execution?
  ├── SIMPLE (≤8 tokens/subtask) → Direct to specialist
  ├── STANDARD (9-15) → 2-3 agents, one checkpoint
  └── COMPLEX (≥16) → Full pipeline with Socratic Gate
```

### 4.2 Routing Table Template

Each subsidiary maintains its own routing table following this schema:

```yaml
# agents/holding/{subsidiary}/routing.yaml
subsidiary: subsidiary-a
display_name: "Empresa Alpha"

domains:
  dev:
    csuite: cto
    triggers: [codigo, bug, feature, deploy, review, arquitetura]
    specialists:
      - role: architect
        triggers: [design, architecture, schema, adr]
      - role: developer
        triggers: [implement, code, sprint, feature, bugfix]
      - role: reviewer
        triggers: [review, audit, security, quality]
      - role: ops
        triggers: [deploy, ci/cd, release, infrastructure]

  marketing:
    csuite: cmo
    triggers: [conteudo, campanha, copy, marca, social]
    specialists:
      - role: copywriter
        triggers: [texto, copy, headline, script]
      - role: designer
        triggers: [visual, imagem, layout, banner]
      - role: analyst
        triggers: [metricas, kpi, performance, roi]

  finance:
    csuite: cfo
    triggers: [orcamento, investimento, capital, fluxo]
    specialists:
      - role: controller
        triggers: [balanco, dre, contabilidade]
      - role: analyst
        triggers: [projecao, valuation, analise]

  operations:
    csuite: coo
    triggers: [processo, eficiencia, workflow, automacao]
    specialists:
      - role: process-engineer
        triggers: [fluxo, otimizacao, sop]
      - role: project-manager
        triggers: [cronograma, milestone, entrega]

  product:
    csuite: cpo
    triggers: [produto, roadmap, ux, priorizacao]
    specialists:
      - role: product-manager
        triggers: [backlog, feature, sprint-planning]
      - role: ux-researcher
        triggers: [pesquisa, usuario, jornada]
```

### 4.3 Cross-Subsidiary Routing

When the Holding Orchestrator detects a cross-subsidiary request:

```
CROSS-SUBSIDIARY REQUEST
        │
        ▼
Holding Orchestrator analyzes:
  - Which subsidiaries are involved?
  - Is there a dependency order or can they run in parallel?
  - What is the consolidation format?
        │
        ├── Independent subsidiaries → Dispatch Tier 1 Bosses in PARALLEL
        │   → Each Tier 1 Boss returns structured output
        │   → Holding Orchestrator merges results
        │
        ├── Sequential dependency → Dispatch in ORDER
        │   → Output of Sub A feeds into Sub B's context
        │   → Chain continues until complete
        │
        └── Conflict between subsidiaries → Holding Orchestrator arbitrates
            → Request structured position from each Tier 1 Boss
            → Apply holding-level governance rules
            → Present options to user if needed
```

---

## 5. Governance Model

### 5.1 Authority Matrix

| Tier | Can Create Agents | Can Modify Routing | Can Access Memory | Escalation Target |
|------|------------------|--------------------|-------------------|-------------------|
| 0 - Holding | Yes (any) | Yes (any) | All subsidiaries | Human user |
| 1 - Subsidiary | Yes (own sub) | Yes (own sub) | Own subsidiary only | Tier 0 |
| 2 - C-Suite | No | No | Own domain only | Tier 1 |
| 3 - Dept Head | No | No | Own department only | Tier 2 |
| 4 - Specialist | No | No | Own task context only | Tier 3 |

### 5.2 Memory Isolation

Each subsidiary has isolated memory. Cross-subsidiary memory access requires explicit escalation to Tier 0.

```
memory/
├── holding/                    # Holding-wide decisions, policies
│   ├── governance.md
│   ├── cross-sub-decisions.md
│   └── shared-patterns.md
├── subsidiary-a/               # Subsidiary A isolated memory
│   ├── session-state.md
│   ├── decisions.md
│   ├── patterns.md
│   └── domains/
│       ├── dev/
│       ├── marketing/
│       └── finance/
├── subsidiary-b/
│   └── ...
└── subsidiary-n/
    └── ...
```

### 5.3 Protection Layers (Extension of constitution.md)

| Layer | Scope | Rule |
|-------|-------|------|
| L0 | Holding | Holding-wide policies. Only Tier 0 can modify. |
| L1 | Subsidiary | Subsidiary-level rules. Tier 1 can modify with Tier 0 approval. |
| L2 | Domain | Domain-specific guardrails. Tier 2 manages. |
| L3 | Operational | Day-to-day rules. Tier 3-4 operate within. |

---

## 6. File Structure

The harness manifests as a directory structure within alex-os:

```
agents/
├── _boss.md                          # Existing Grand Boss (becomes Tier 0)
├── _registry.md                      # Global registry (updated for holding)
├── holding/
│   ├── _orchestrator.md              # Tier 0: Holding Orchestrator
│   ├── _registry.yaml                # Holding-wide routing table
│   ├── governance.md                 # Holding governance rules
│   │
│   ├── subsidiary-a/
│   │   ├── boss.md                   # Tier 1: Subsidiary A Boss
│   │   ├── routing.yaml              # Subsidiary A routing table
│   │   ├── csuite/
│   │   │   ├── ceo.md
│   │   │   ├── cto.md
│   │   │   ├── cfo.md
│   │   │   ├── cmo.md
│   │   │   ├── coo.md
│   │   │   └── cpo.md
│   │   ├── dev/
│   │   │   ├── architect.md
│   │   │   ├── developer.md
│   │   │   ├── reviewer.md
│   │   │   └── ops.md
│   │   ├── marketing/
│   │   │   ├── copywriter.md
│   │   │   ├── designer.md
│   │   │   └── analyst.md
│   │   ├── finance/
│   │   │   ├── controller.md
│   │   │   └── analyst.md
│   │   └── operations/
│   │       ├── process-engineer.md
│   │       └── project-manager.md
│   │
│   ├── subsidiary-b/
│   │   ├── boss.md
│   │   ├── routing.yaml
│   │   ├── csuite/
│   │   │   └── ...
│   │   └── ...
│   │
│   └── shared/                       # Shared agent templates
│       ├── csuite-template.md
│       ├── specialist-template.md
│       └── routing-template.yaml

workflows/
├── _router.md                        # Updated with holding-level routing
├── holding-briefing.md               # Cross-subsidiary briefing workflow
├── subsidiary-onboarding.md          # Add new subsidiary workflow
└── cross-subsidiary-sync.md          # Cross-sub coordination workflow

skills/
├── orchestration-engine/SKILL.md     # Updated for multi-tier dispatch
├── holding-governance/SKILL.md       # Holding-level governance skill
└── subsidiary-bootstrap/SKILL.md     # Bootstrap a new subsidiary

memory/
├── holding/
│   └── ...
├── subsidiary-a/
│   └── ...
└── subsidiary-b/
    └── ...
```

---

## 7. Harness Discovery Protocol

To determine the correct harness structure for a specific holding, follow this protocol:

### Step 1: Map the Corporate Structure

```yaml
# Input: holding-map.yaml
holding:
  name: "Holding XYZ"
  subsidiaries:
    - name: "Empresa Alpha"
      code: subsidiary-alpha
      sectors:
        - name: "Tecnologia"
          departments: [backend, frontend, infra, data]
        - name: "Marketing"
          departments: [branding, performance, content]
        - name: "Financeiro"
          departments: [contabilidade, tesouraria, fiscal]
        - name: "Operacoes"
          departments: [logistica, rh, juridico]

    - name: "Empresa Beta"
      code: subsidiary-beta
      sectors:
        - name: "Comercial"
          departments: [vendas, pos-venda, parcerias]
        - name: "Produto"
          departments: [discovery, delivery, analytics]

    - name: "Empresa Gamma"
      code: subsidiary-gamma
      sectors:
        - name: "Industrial"
          departments: [producao, qualidade, manutencao]
```

### Step 2: Identify Interaction Patterns

For each subsidiary pair, map the interaction type:

```yaml
interactions:
  - from: subsidiary-alpha
    to: subsidiary-beta
    type: service-provider       # Alpha provides tech to Beta
    frequency: daily
    shared_domains: [dev, product]

  - from: subsidiary-alpha
    to: subsidiary-gamma
    type: independent            # Minimal interaction
    frequency: monthly
    shared_domains: [finance]    # Only consolidated reporting

  - from: subsidiary-beta
    to: subsidiary-gamma
    type: supply-chain           # Beta sells what Gamma produces
    frequency: daily
    shared_domains: [operations, product]
```

### Step 3: Determine Agent Density

Not every subsidiary needs every C-Suite role or specialist. Use this matrix:

| Subsidiary Size | C-Suite Agents | Specialists per Domain | Total Agents |
|----------------|----------------|----------------------|--------------|
| **Micro** (1-2 sectors) | 2-3 (CEO + domain leads) | 1-2 per sector | 5-10 |
| **Small** (3-4 sectors) | 4-5 (full C-Suite minus CMO/CPO) | 2-3 per sector | 15-25 |
| **Medium** (5-7 sectors) | Full C-Suite (6) | 3-4 per sector | 30-50 |
| **Large** (8+ sectors) | Full C-Suite + VPs | 4-6 per sector | 50-100 |

### Step 4: Define Shared Services

Some functions should be centralized at the holding level rather than duplicated:

```yaml
shared_services:
  # These agents exist at Tier 0 and serve all subsidiaries
  - domain: legal
    reason: "Compliance must be consistent across all subsidiaries"
    agents: [legal-advisor, compliance-officer]

  - domain: it-infrastructure
    reason: "Shared cloud, shared tooling"
    agents: [infra-architect, security-officer]

  - domain: hr-policy
    reason: "Unified hiring and culture standards"
    agents: [hr-policy-advisor]
```

### Step 5: Configure Escalation Chains

```yaml
escalation_chains:
  # Technical escalation
  tech:
    path: [specialist, dept-head, cto, subsidiary-boss, holding-orchestrator, user]
    timeout_per_level: [0, 5min, 15min, 30min, immediate]

  # Financial escalation
  financial:
    path: [analyst, controller, cfo, subsidiary-boss, holding-orchestrator, user]
    thresholds:
      auto_approve: "<R$10k"
      cfo_approve: "<R$100k"
      subsidiary_boss: "<R$500k"
      holding: ">=R$500k"

  # Strategic escalation
  strategic:
    path: [cpo/cto, ceo, subsidiary-boss, holding-orchestrator, user]
    triggers: ["impacts >30% of resources", "cross-domain conflict", "new partnership"]
```

---

## 8. Orchestration Patterns

### 8.1 Single-Subsidiary Request

```
User → Holding Orchestrator
         │
         ├─ Classify: subsidiary-alpha, domain: dev, task: fix bug
         │
         └─ Route → subsidiary-alpha Boss
                      │
                      ├─ Short-circuit: task is clear
                      │
                      └─ Dispatch → subsidiary-alpha:dev:developer
                                      │
                                      └─ Execute → Return result
                                                     │
                                                     └─ Bubble up → User
```

### 8.2 Cross-Subsidiary Parallel

```
User → Holding Orchestrator
         │
         ├─ Classify: affects alpha + beta + gamma, domain: finance
         │
         └─ Dispatch PARALLEL:
              ├─ subsidiary-alpha Boss → alpha:finance:analyst → Report A
              ├─ subsidiary-beta Boss  → beta:finance:analyst  → Report B
              └─ subsidiary-gamma Boss → gamma:finance:analyst → Report C
                                                                    │
                                                     Holding Orchestrator
                                                           │
                                                     Merge & Synthesize
                                                           │
                                                     Consolidated Report → User
```

### 8.3 Cross-Subsidiary Sequential (Supply Chain)

```
User → Holding Orchestrator
         │
         ├─ Classify: supply chain request (gamma → beta)
         │
         └─ Step 1: subsidiary-gamma Boss
              │
              └─ gamma:operations:process-engineer → Production Plan
                                                          │
              Step 2: subsidiary-beta Boss (receives Production Plan)
              │
              └─ beta:commercial:sales → Sales Strategy aligned to plan
                                              │
              Holding Orchestrator
              │
              └─ Synthesize → Integrated Plan → User
```

### 8.4 Holding-Wide Policy Change

```
User → Holding Orchestrator
         │
         ├─ Classify: holding-wide, governance change
         │
         └─ Holding Orchestrator handles directly:
              │
              ├─ Draft policy change
              ├─ Dispatch impact analysis to ALL subsidiary bosses (parallel)
              │   ├─ subsidiary-alpha Boss → Impact Report A
              │   ├─ subsidiary-beta Boss  → Impact Report B
              │   └─ subsidiary-gamma Boss → Impact Report C
              │
              ├─ Synthesize impact reports
              ├─ Present options to User
              └─ On approval → Propagate to all subsidiaries
```

---

## 9. Token Economy for Holdings

### 9.1 Budget Allocation

```yaml
token_budget:
  holding_orchestrator:
    allocation: 15%     # Routing, synthesis, governance
    reserve: 5%         # Emergency escalation buffer

  per_subsidiary:
    allocation: dynamic # Proportional to request complexity
    breakdown:
      orchestration: 10%   # Tier 1 Boss routing
      csuite: 15%          # Strategic analysis
      execution: 60%       # Specialist work
      validation: 15%      # Review and quality gates
```

### 9.2 Cross-Subsidiary Budget

When a request spans multiple subsidiaries, the Holding Orchestrator allocates from a shared pool:

```
Total Budget = Base + (N_subsidiaries * cross_sub_overhead)
Where cross_sub_overhead = 10% per additional subsidiary
```

---

## 10. Bootstrap Checklist

To instantiate this harness for a real holding:

- [ ] Map the corporate structure (Step 1 of Discovery Protocol)
- [ ] Identify interaction patterns between subsidiaries (Step 2)
- [ ] Determine agent density per subsidiary (Step 3)
- [ ] Define shared services at holding level (Step 4)
- [ ] Configure escalation chains (Step 5)
- [ ] Create the file structure under `agents/holding/`
- [ ] Write each subsidiary's `routing.yaml`
- [ ] Instantiate agent files from templates in `agents/holding/shared/`
- [ ] Configure memory isolation per subsidiary
- [ ] Update `workflows/_router.md` with holding-level routing
- [ ] Create the `holding-briefing.md` workflow
- [ ] Test with a single-subsidiary request
- [ ] Test with a cross-subsidiary parallel request
- [ ] Test with a cross-subsidiary sequential request
- [ ] Test holding-wide policy propagation

---

## 11. Integration with Existing Systems

### 11.1 Alex-OS Compatibility

This harness extends the existing alex-os patterns:

| Existing Pattern | Harness Extension |
|-----------------|-------------------|
| `_boss.md` (Grand Boss) | Becomes Tier 0 Holding Orchestrator |
| `agents/csuite/*` | Replicated per subsidiary with namespace |
| `agents/dev/*` | Replicated per subsidiary per domain |
| `workflows/_router.md` | Extended with holding-level routing tree |
| `skills/orchestration-engine` | Extended with multi-tier dispatch |
| `rules/constitution.md` | Extended with L0 holding governance layer |

### 11.2 Opensquad Compatibility

Squads can be spawned at any tier level:

- **Holding Squad**: spawned by Tier 0 for cross-subsidiary missions
- **Subsidiary Squad**: spawned by Tier 1 for complex subsidiary tasks
- **Domain Squad**: spawned by Tier 2-3 for domain-specific projects

Each squad follows the existing opensquad pipeline format (`squad.yaml`, `pipeline.yaml`, agent files).

### 11.3 Psters AI Workflow Compatibility

The multi-agent orchestration skill from Psters applies at every tier:

- **Namespace format**: `{subsidiary}:{domain}:{agent-name}`
- **Parallel lanes**: independent subsidiaries or domains
- **Merge protocol**: Holding Orchestrator or Subsidiary Boss owns final merge
- **Anti-patterns**: same as Psters (no parallelizing dependent tasks, no state bleed)

---

## 12. Example: Holding with 3 Subsidiaries

```yaml
# Real-world example: Tech Holding
holding:
  name: "Alex Holding"
  code: alex-holding

  shared_services:
    - legal-compliance
    - it-security
    - brand-identity

  subsidiaries:
    - name: "SaaS Product Co"
      code: saas-co
      sectors: [dev, product, marketing, customer-success]
      agent_density: medium
      csuite: [ceo, cto, cpo, cmo]
      specialists: 18

    - name: "Consulting Services"
      code: consulting
      sectors: [delivery, sales, training]
      agent_density: small
      csuite: [ceo, coo]
      specialists: 8

    - name: "Investment Arm"
      code: invest-co
      sectors: [portfolio, due-diligence, reporting]
      agent_density: micro
      csuite: [ceo, cfo]
      specialists: 5

  total_agents: 41  # 1 holding + 3 tier-1 + 8 csuite + 31 specialists
  interactions:
    - [saas-co, consulting, service-provider, daily]
    - [saas-co, invest-co, independent, monthly]
    - [consulting, invest-co, advisory, weekly]
```

---

## 13. Decision Log

| Decision | Rationale | Alternative Considered |
|----------|-----------|----------------------|
| Namespace agents with `{subsidiary}:{role}` | Prevents collision; enables parallel dispatch | Flat registry with prefixes -- harder to route |
| Memory isolation per subsidiary | Data privacy; prevents context pollution | Shared memory with ACLs -- too complex |
| Tier 0 handles cross-subsidiary merge | Single source of truth for consolidated reports | Let subsidiaries negotiate directly -- loses audit trail |
| Short-circuit for clear single-domain tasks | Token efficiency; faster response | Always route through full hierarchy -- wasteful |
| Shared services at holding level | Consistency for legal/compliance/security | Duplicate per subsidiary -- inconsistent policies |
