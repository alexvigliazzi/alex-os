#!/bin/bash
# Alex-OS Pre-Session Bootstrap
# Executa no início de cada sessão Claude Code
# Configurar em settings.json → hooks → SessionStart

set -euo pipefail

CLAUDE_HOME="${HOME}/.claude"
SESSION_STATE="${CLAUDE_HOME}/context/session-state.md"
PROJECT_CONTEXT="${CLAUDE_HOME}/context/project.md"

echo "[alex-os] iniciando bootstrap..."

# 1. Verificar Ollama (modelo local gratuito)
OLLAMA_STATUS=$(curl -s --connect-timeout 2 http://localhost:11434/api/tags 2>/dev/null | grep -c '"name"' || true)
if [ "${OLLAMA_STATUS}" -gt 0 ]; then
  echo "[alex-os] ollama:up — score ≤ 3 → gemma3:4b (gratuito)"
else
  echo "[alex-os] ollama:down — usar Claude API (haiku/sonnet/opus por score)"
fi

# 2. Verificar sessão anterior
if [ -f "${SESSION_STATE}" ]; then
  LAST_DATE=$(head -10 "${SESSION_STATE}" | grep -i "data\|date\|sessão\|session" | head -1 | cut -c1-60 || echo "data não encontrada")
  echo "[alex-os] sessão anterior: ${LAST_DATE}"
else
  echo "[alex-os] nova sessão — sem estado anterior"
fi

# 3. Verificar projeto ativo
if [ -f "${PROJECT_CONTEXT}" ]; then
  PROJECT_LINE=$(head -5 "${PROJECT_CONTEXT}" | grep -v "^#\|^$" | head -1 | cut -c1-80 || echo "não identificado")
  echo "[alex-os] contexto: ${PROJECT_LINE}"
fi

# 4. Verificar ciam MCP
CIAM_BIN="${HOME}/go/bin/ciam.exe"
if [ -f "${CIAM_BIN}" ]; then
  echo "[alex-os] ciam:disponível — busca semântica ativa"
else
  echo "[alex-os] ciam:não encontrado — busca semântica indisponível"
fi

echo "[alex-os] Boss ativo — Alex-OS pronto"
