# Reference Catalog

Quick-lookup guide for external resources integrated with .claude/ workstation.

| Name | Purpose | Key Files | When to Consult |
|------|---------|-----------|-----------------|
| **th0th** | Semantic search engine, lightweight fallback | `packages/core/src/` | Pattern matching, legacy code search, offline mode |
| **seshat** | Evolved th0th + TOON format, bilingual PT→EN, knowledge graph | `packages/core/src/` | Complex semantic queries, cross-lingual search, graph relations |
| **ralph** | Autonomous iteration loop, PRD generation, story-driven dev | `skills/ralph/SKILL.md`, `skills/prd/SKILL.md`, `ralph.sh` | Feature discovery, PRD drafts, multi-sprint planning |
| **claude-code-security-review** | Security audit, two-stage filtering, vulnerability categories | `claudecode/prompts.py`, `claudecode/findings_filter.py` | Pre-deployment audit, compliance checks, supply-chain risk |
| **claude-code-system-prompts** | 40+ agent prompts, security monitor, BLOCK/ALLOW rules | `system-prompts/` | Agent persona tuning, behavior rules, role definitions |
| **context-ia-manager** (ciam) | Go-based MCP server, 12 tools, hybrid search, persistent SQLite | `cmd/ciam/commands/`, `internal/` | Hybrid keyword+semantic search, long-term memory, tool dispatch |
| **aiox-core** | 10+ agents, constitution, 4 workflows, 4-layer boundary, digests | `.claude/rules/`, `docs/framework/` | Governance baseline, session lifecycle, framework architecture |
| **gemini-skills** | Gemini API dev patterns, current models/SDKs | `skills/gemini-api-dev/SKILL.md` | Gemini-specific code, API usage, model selection |
| **ollama-setup** | Ollama local LLM — install, models, integration with .claude agents and SisIBTEC | `references/ollama-setup.md` | When routing tasks locally, saving API tokens, embedding generation |

**Load order:** aiox-core (constitution) → context-ia-manager (tool dispatch) → seshat (search) → tool-specific skills as needed.

---

## Regulatory Standards — `regulamentacao-tecnica-dev/`

### Grupo A — Incorporadas (mudam comportamento de gates)

| Norma | Regra-chave / Propósito | Integração ao Agent | Arquivo Fonte |
|-------|------------------------|---------------------|---------------|
| ECMA-434 (NLIP Security) | 3 perfis: TLS+auth (P1), enterprise throttling/audit (P2), prompt injection prevention (P3) | `rules/security.md` + `agents/reviewer.md` | `sec-prof-natural-language-interaction-protocol_ECMA-434_1st_edition_december_2025.md` |
| ECMA-430 (NLIP Protocol) | Envelope padrão: MessageType, Format, Subformat, Content | `agents/architect.md` | `natural-language-interaction-protocol_ECMA-430_2nd_edition_june_2025.md` |
| ECMA-431 (NLIP/HTTP) | Binding HTTP: POST /nlip, JSON/CBOR, status codes | `agents/architect.md` | `natural-language-interaction-protocol-http-s_ECMA-431_2nd_edition_june_2025.md` |
| ECMA-432 (NLIP/WebSocket) | Binding WS: /nlip/ws, frames CBOR/JSON, heartbeat | `agents/architect.md` | `natural-language-interaction-protocol-websocket_ECMA-432_2nd_edition_june_2025.md` |
| IEEE 830 (SRS) | Requisitos: unicidade, completude, verificabilidade, rastreabilidade | `agents/strategist.md` | `IEEE830.md` |
| IEEE 830-1993 (SRS) | Versão anterior do IEEE 830 — contexto histórico de traceabilidade | `agents/strategist.md` | `IEEE830-1993.md` |
| IEEE 730.1-1989 (SQA) | SQA Plans: documentação, revisões, auditorias | `agents/reviewer.md` | `ieee.p730.1.1989.md` |
| IEEE 829-2008 (Test Docs) | 8 tipos de documento de teste: plan, design, case, procedure, log, summary | `agents/reviewer.md` | `IEEE-Test-Doc-829-2008.md` |
| WCAG 2.2 | Conformidade A/AA/AAA: perceptível, operável, compreensível, robusto | `agents/reviewer.md` + `agents/strategist.md` | `Web Content Accessibility Guidelines (WCAG) 2.2.md` |

### Grupo B — Catalogadas (consulta sob demanda)

| Norma | Propósito | Quando Consultar | Arquivo Fonte |
|-------|-----------|-----------------|---------------|
| ECMA-262 (ECMAScript) | Especificação completa da linguagem JavaScript | Comportamento de borda JS, semântica de closures, coerção | `ECMA-262_15th_edition_june_2024.md` |
| ECMA-402 (Intl API) | Internacionalização JS: formatação de datas, números, collation | Features de i18n/l10n, formatação locale-aware | `ECMA-402_11th_edition_june_2024.md` |
| ECMA-419 (Embedded) | API mínima para JS em hardware embarcado/IoT | Projetos IoT, microcontroladores, JS fora do browser | `ECMA-419_2nd_edition_june_2023.md` |
| ECMA-429 (Min Common API) | API comum mínima entre runtimes JS (Deno, Node, Bun) | Portabilidade entre runtimes, APIs cross-runtime | `ECMA-429_1st_edition_june_2024.md` |
| ECMA-404 (JSON) | Especificação formal do formato JSON | Parsing edge cases, validação estrita de JSON | `ECMA-404_2nd_edition_december_2017.md` |
| ECMA-427 (Package URL) | Formato PURL para identificação de pacotes de software | SBOM, rastreamento de dependências, supply chain | `ECMA-427_1st_edition_december_2024.md` |
| ECMA-424 (CycloneDX SBOM) | Software Bill of Materials — formato de inventário de componentes | Auditoria de dependências, compliance de segurança | `ECMA-424_2nd_edition_december_2024.md` |
| IEEE 1074-1995 (SDLC) | Ciclo de vida de desenvolvimento de software — processos e fases | Planejamento de projeto, definição de fases SDLC | `IEEE-1074-1995.md` |
| WCAG 2.0 | Versão original das diretrizes de acessibilidade web (2008) | Referência histórica; usar WCAG 2.2 para projetos novos | `Web Content Accessibility Guidelines (WCAG) 2.0.md` |
| WCAG 2.1 | Versão intermediária com critérios mobile e cognitivos (2018) | Projetos com requisito explícito de conformidade 2.1 | `Web Content Accessibility Guidelines (WCAG) 2.1.md` |

### Grupo C — Sem ação (irrelevantes ao stack JS/TS/GAS)

| Norma | Motivo da exclusão |
|-------|--------------------|
| ECMA-372 (C++/CLI) | Stack .NET/C++ — fora do contexto JS/TS/GAS |
| ECMA-335 (Common Language Infrastructure) | Runtime .NET — irrelevante ao stack |
| ECMA-428 (CL Enum) | Enumeração de linguagens CL — sem aplicação prática |
| ECMA-262 Corrigendum 2025 | Apenas correção de copyright — sem mudança técnica |
