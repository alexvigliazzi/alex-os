# Reference Catalog

Quick-lookup guide for external resources integrated with .claude/ workstation.
Atualizado: 2026-03-28

## Ferramentas Ativas

| Name | Purpose | Status | Key Files | When to Consult |
|------|---------|--------|-----------|-----------------|
| **context-ia-manager** (ciam) | MCP server em Go — busca semantica hibrida, memoria persistente, ADRs | **ATIVO** (Docker:8080 + MCP stdio) | `cmd/ciam/commands/`, `internal/` | Busca semantica, memoria de longo prazo, decisoes anteriores |
| **seshat** | API de busca semantica com nomic-embed-text | **ATIVO** (Docker:3333) | API REST | Complemento ao ciam para busca local de documentos |
| **Ollama** | LLM local — gemma3:4b (texto) + nomic-embed-text (embeddings) | **ATIVO** (Docker:11434) | `references/ollama-setup.md`, `scripts/utils/ollama-router.sh` | Roteamento gratuito score <= 3, embeddings locais |
| **ralph** | Loop autonomo de iteracao — implementacao iterativa pos-spec | **ATIVO** | Plugin `ralph-loop` (`/ralph-loop`) | Implementacao iterativa APOS PRD/spec aprovada |
| **aiox-core** | Base do Alex-OS — constitution, agents, workflows, governance | **INCORPORADO** | `.claude/rules/`, `.claude/agents/` | Framework ja ativo — nao precisa consulta separada |

## Ferramentas Conceituais / Paradas

| Name | Purpose | Status | Motivo |
|------|---------|--------|--------|
| **alex-bot** | Bot Telegram com FastAPI+CQRS+RAG | **PARADO** | Token Telegram revogado |
| **squidy** | Scaffolding de projeto, audit | **PARCIAL** | Bug UTF-8 no Windows (cp1252) |
| **Claude Agent SDK** | SDK Python oficial para agentes programaticos | **NAO INTEGRADO** | Clonado em `~/claude-agent-sdk-python/` — futuro |
| **CLI-Anything** | Framework para tornar software agent-native | **NAO INTEGRADO** | Clonado em `~/CLI-Anything/` — baixa prioridade |

## Ferramentas Removidas

| Name | Motivo da Remocao |
|------|-------------------|
| ~~th0th~~ | Supersedido integralmente pelo ciam. Sem binario, sem container, sem uso. |
| ~~gemini-skills~~ | Skills Gemini nao aplicaveis ao stack atual |
| ~~claude-code-security-review~~ | Funcionalidade coberta por `rules/security.md` + hook `pre-tool-use.sh` |
| ~~claude-code-system-prompts~~ | Funcionalidade coberta pelos agents do Alex-OS |

**Load order:** Alex-OS bootstrap (constitution + Boss) → ciam (busca semantica) → Ollama (roteamento local) → tools especificas conforme necessidade.

---

## Regulatory Standards — `references/regulamentacao-tecnica-dev/`

Arquivos fonte: copiados de `repoScripts/Antigravity/SisAlmoxIBTEC/.agents/references/regulamentacao-tecnica-dev/`
Backup PDFs: permanecem no diretorio de origem.

### Grupo A — Incorporadas (mudam comportamento de gates)

| Norma | Regra-chave / Proposito | Integracao ao Agent | Arquivo Fonte |
|-------|------------------------|---------------------|---------------|
| ECMA-434 (NLIP Security) | 3 perfis: TLS+auth (P1), enterprise throttling/audit (P2), prompt injection prevention (P3) | `rules/security.md` + `agents/dev/reviewer.md` | `sec-prof-natural-language-interaction-protocol_ECMA-434_1st_edition_december_2025.md` |
| ECMA-430 (NLIP Protocol) | Envelope padrao: MessageType, Format, Subformat, Content | `agents/dev/architect.md` | `natural-language-interaction-protocol_ECMA-430_1st_edition_december_2025.md` |
| ECMA-431 (NLIP/HTTP) | Binding HTTP: POST /nlip, JSON/CBOR, status codes | `agents/dev/architect.md` | `natural-language-interaction-protocol-http-s_ECMA-431_1st_edition_december_2025.md` |
| ECMA-432 (NLIP/WebSocket) | Binding WS: /nlip/ws, frames CBOR/JSON, heartbeat | `agents/dev/architect.md` | `natural-language-interaction-protocol-websocket_ECMA-432_1st_edition_december_2025.md` |
| IEEE 830 (SRS) | Requisitos: unicidade, completude, verificabilidade, rastreabilidade | `agents/dev/strategist.md` | `IEEE830.md` |
| IEEE 830-1993 (SRS) | Versao anterior — contexto historico de traceabilidade | `agents/dev/strategist.md` | `IEEE830-1993.md` |
| IEEE 730.1-1989 (SQA) | SQA Plans: documentacao, revisoes, auditorias | `agents/dev/reviewer.md` | `ieee.p730.1.1989.md` |
| IEEE 829-2008 (Test Docs) | 8 tipos de documento de teste: plan, design, case, procedure, log, summary | `agents/dev/reviewer.md` | `IEEE-Test-Doc-829-2008.md` |
| WCAG 2.2 | Conformidade A/AA/AAA: perceptivel, operavel, compreensivel, robusto | `agents/dev/reviewer.md` + `agents/dev/strategist.md` | `Web Content Accessibility Guidelines (WCAG) 2.2.md` |

### Grupo B — Catalogadas (consulta sob demanda, arquivos em repoScripts)

| Norma | Proposito | Quando Consultar |
|-------|-----------|-----------------|
| ECMA-262 (ECMAScript 2025) | Especificacao completa da linguagem JavaScript | Comportamento de borda JS, semantica de closures, coercao |
| ECMA-402 (Intl API) | Internacionalizacao JS: formatacao de datas, numeros, collation | Features de i18n/l10n, formatacao locale-aware |
| ECMA-419 (Embedded) | API minima para JS em hardware embarcado/IoT | Projetos IoT, microcontroladores |
| ECMA-429 (Min Common API) | API comum minima entre runtimes JS (Deno, Node, Bun) | Portabilidade entre runtimes |
| ECMA-404 (JSON) | Especificacao formal do formato JSON | Parsing edge cases, validacao estrita |
| ECMA-427 (Package URL) | Formato PURL para identificacao de pacotes | SBOM, rastreamento de dependencias |
| ECMA-424 (CycloneDX SBOM) | Software Bill of Materials | Auditoria de dependencias, compliance |
| IEEE 1074-1995 (SDLC) | Ciclo de vida de desenvolvimento de software | Planejamento de projeto |

**Arquivos Grupo B localizados em:** `repoScripts/Antigravity/SisAlmoxIBTEC/.agents/references/regulamentacao-tecnica-dev/`
Copiar para `~/.claude/references/regulamentacao-tecnica-dev/` quando necessario.

### Grupo C — Irrelevantes ao stack JS/TS/GAS (nao copiar)

| Norma | Motivo da exclusao |
|-------|--------------------|
| ECMA-372 (C++/CLI) | Stack .NET/C++ — fora do contexto |
| ECMA-335 (CLI) | Runtime .NET — irrelevante |
| ECMA-428 (CL Enum) | Enumeracao de linguagens CL — sem aplicacao |
| ECMA-262 Corrigendum 2025 | Apenas correcao de copyright |
