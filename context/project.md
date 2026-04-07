# Project Context — SisAlmoxIBTEC / SisIBTEC
# Atualizar manualmente quando mudar stack ou foco ativo.

## Projetos Ativos

### SisAlmoxIBTEC (principal)
- **Stack**: Google Apps Script + Clasp + Node.js (debug local)
- **Deploy**: clasp push → Google Workspace
- **Padrão de branch**: feature/* → dev → main
- **Testes**: Node.js local via clasp run
- **Convenções**: camelCase, JSDoc para funções públicas

### SisIBTEC (referência)
- **Stack**: Next.js 16, TypeScript 5.9, Prisma 6, Supabase, pnpm 10
- **Deploy**: Vercel (prod), staging branch
- **Padrão de branch**: feature/* → dev → main
- **Testes**: Jest + Playwright
- **Convenções**: PascalCase components, camelCase utils, absolute imports

## Decisões Vigentes
- ORM: Prisma (não mudar para Drizzle sem ADR)
- Auth: Supabase Auth (não implementar JWT próprio)
- Deploy: exclusivo via Ops agent (nunca force-push em main)

## Padrões de Código
- Imports: absolutos sempre (sem `../`)
- Commits: `[TIPO] descrição curta` (sem ID obrigatório em chat interativo)
- Testes: escrever junto com o código, não depois
- Cobertura mínima: 80%

## Ferramentas Disponíveis
- ciam (MCP): busca semântica, memórias, ADRs
- Ollama (local): gemma3:4b em localhost:11434 — para tarefas score ≤ 3
- ralph: loop autônomo para PRD multi-sprint (scripts/ralph/ralph.sh)
- squidy: scaffolding (workaround: PYTHONIOENCODING=utf-8)
- gcloud CLI: `/opt/google-cloud-sdk/bin/gcloud` (v502.0.0) — Google Cloud Console
- clasp: `clasp` (v3.3.0) — deploy Google Apps Script → `cd ~/SisAlmoxIBTEC && clasp push`
- google-generativeai: `pip3` (v0.8.6) + google-cloud-aiplatform — Gemini API Python SDK
- Gemini API Key: configurar em `~/.env` como `GEMINI_API_KEY=...` (gerar em aistudio.google.com)
- Setup script: `bash ~/alex-os/scripts/setup-google-auth.sh` — guia autenticação interativa

## Trabalho Ativo
<!-- Atualizado: 2026-03-25 -->
- [x] Fix sistema de agentes e hooks (sessão 2026-03-25)
  - python3 wrapper criado em ~/bin/python3
  - ollama-host.env corrigido para localhost:11434
  - litellm_init.pth (malware) — REMOVIDO
  - /session-close command criado
  - context-first.md corrigido (seshat→ciam)
  - napkin.md inicializado
  - _router.md com rota sdd-tdd
- [x] Pipeline de idioma PT-BR implementado (sessão 2026-03-25)
  - Hook UserPromptSubmit: language-protocol.sh injetando protocolo em cada prompt
  - CLAUDE.md: seção PROTOCOLO DE IDIOMA adicionada no topo
  - rules/language.md: criado com regras detalhadas
  - 6 agentes: nota de idioma adicionada (developer, reviewer, strategist, architect, ops, orchestrator)
  - 7 skills: nota de idioma adicionada (adaptive-governance, context-economy, model-router, napkin, orchestration-engine, senior-fullstack, uiux-promax)
  - context-economy/SKILL.md: removidas refs seshat/th0th, substituído por ciam
- [x] Varredura de segurança (sessão 2026-03-25)
  - litellm_init.pth: malware C2 com chave RSA — removido do site-packages
  - Backup em ~/.claude/security/litellm_init.pth.MALWARE.bak
  - Outros .pth verificados: a1_coverage (legítimo), distutils-precedence (legítimo)
  - Processos e portas verificados: nenhum malware ativo em rede
- [x] Fix Windsurf Python (sessão 2026-03-25)
  - Causa: pet.exe ausente (ms-python.python-2026.4.0 instalado incompleto)
  - python.defaultInterpreterPath fixado em settings.json do Windsurf
  - Ação pendente: reinstalar extensão ms-python.python no Windsurf
- [x] Setup Google Cloud + Gemini + Clasp (sessão 2026-04-07)
  - gcloud SDK 502.0.0 instalado em /opt/google-cloud-sdk
  - clasp 3.3.0 instalado via npm global
  - google-generativeai 0.8.6 + google-cloud-aiplatform instalados via pip
  - PATH configurado em /etc/profile.d/gcloud.sh e ~/.bashrc
  - Script de autenticação: ~/alex-os/scripts/setup-google-auth.sh
  - Pendente (requer navegador): gcloud auth login, ADC login, clasp login, Gemini API Key
- [ ] Próxima feature SisAlmoxIBTEC — a definir na próxima sessão
