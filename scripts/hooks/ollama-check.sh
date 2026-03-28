#!/bin/bash
# Alex-OS Ollama Status Check
# Retorna o modelo recomendado com base na disponibilidade do Ollama
# Uso: bash ollama-check.sh [score]
# score: 1-10 (complexidade da tarefa) — padrão: 5

SCORE="${1:-5}"
OLLAMA_UP=$(curl -s --connect-timeout 2 http://localhost:11434/api/tags 2>/dev/null | grep -c '"name"' || true)

if [ "${OLLAMA_UP}" -gt 0 ] && [ "${SCORE}" -le 3 ]; then
  echo "model:gemma3:4b endpoint:http://localhost:11434 cost:free status:ok"
elif [ "${SCORE}" -le 3 ]; then
  echo "model:claude-haiku endpoint:anthropic cost:1x status:fallback"
elif [ "${SCORE}" -le 8 ]; then
  echo "model:claude-sonnet endpoint:anthropic cost:10x status:standard"
else
  echo "model:claude-opus endpoint:anthropic cost:30x status:complex"
fi
