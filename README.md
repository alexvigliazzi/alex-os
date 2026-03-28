# Alex-OS v2.0

Framework multi-agente para Claude Code. Transforma o Claude em uma holding de agentes especializados com C-suite executivo, dominio dev e workflows automatizados.

## O que e o Alex-OS?

Uma camada de configuracao sobre o Claude Code que adiciona:

- **Grand Boss** — Orquestrador que detecta dominio, roteia para o agente certo e sintetiza resultados
- **C-Suite** — CEO, CPO, CTO, COO, CFO e CMO como personas especializadas
- **Dev Domain** — Strategist, Architect, Developer, Reviewer e Ops
- **Workflows** — Pipelines completos para desenvolvimento, debug, deploy e documentacao
- **Rules** — Constituicao, seguranca, autoridade e economia de tokens
- **Skills** — Context economy, model router, orchestration engine e mais

## Instalacao

### Requisitos

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) instalado
- Git Bash (Windows) ou terminal nativo (macOS/Linux)

### Instalar

```bash
git clone https://github.com/alexvigliazzi/alex-os.git
cd alex-os
bash install.sh
```

O installer:
1. Faz backup de arquivos existentes em `~/.claude/backups/`
2. Copia agents, commands, rules, workflows, skills e scripts para `~/.claude/`
3. Gera `CLAUDE.md` a partir do template
4. Preserva `settings.json` e `mcp.json` existentes (nao sobrescreve)
5. Valida a instalacao

### Atualizar

```bash
cd alex-os
git pull
bash install.sh
```

### Desinstalar

Os arquivos ficam em `~/.claude/`. Remover os diretorios criados pelo Alex-OS:

```bash
rm -rf ~/.claude/agents ~/.claude/commands ~/.claude/workflows ~/.claude/rules ~/.claude/skills ~/.claude/scripts ~/.claude/references ~/.claude/context
```

## Comandos disponiveis

### C-Suite (slash commands)

| Comando | Funcao |
|---------|--------|
| `/boss` | Grand Boss — orquestrador prime |
| `/ceo` | Decisoes estrategicas, visao, arbitragem |
| `/cpo` | Produto, roadmap, UX, priorizacao |
| `/cto` | Arquitetura, stack, padroes de engenharia |
| `/coo` | Processos, automacao, eficiencia |
| `/cfo` | Financas, capital, budget |
| `/cmo` | Marca, posicionamento, crescimento |

### Workflows

| Comando | Funcao |
|---------|--------|
| `/development` | Ciclo completo de feature |
| `/problem-resolution` | Investigacao de bug |
| `/test-deploy` | Pipeline de deploy |
| `/documentation` | Geracao de documentacao |
| `/context-first` | Carregamento de contexto |
| `/session-close` | Fechamento de sessao |

## Estrutura

```
alex-os/
├── agents/          # Definicoes de agentes (Boss, C-suite, Dev)
├── commands/        # Slash commands (/)
├── context/         # Estado de sessao e projeto
├── rules/           # Constituicao, seguranca, autoridade
├── skills/          # Skills invocaveis
├── workflows/       # Pipelines automatizados
├── scripts/         # Hooks e utilitarios
├── references/      # Documentacao de ferramentas
├── templates/       # Templates para CLAUDE.md, settings.json
└── install.sh       # Installer
```

## Compatibilidade

| Plataforma | Suporte |
|-----------|---------|
| Claude Code CLI | Completo |
| VS Code (extensao Claude Code) | Completo |
| Antigravity (desktop app) | Completo |
| claude.ai/code (web) | Completo |
| Windsurf | Nao (usa `.codeium/windsurf/`) |

## Licenca

Uso pessoal. Feito por Alex Vigliazzi.
