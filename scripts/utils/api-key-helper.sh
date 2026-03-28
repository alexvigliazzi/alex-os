#!/bin/bash
# api-key-helper.sh — ApiKeyHelper — Alex-OS
# Retorna a Anthropic API key como string simples
# Claude Code usa este script para obter a chave dinamicamente

CREDENTIALS_FILE="$HOME/.claude/.credentials.json"

# Tentativa 1: ler de .credentials.json (gerenciado pelo Claude Code)
if [ -f "$CREDENTIALS_FILE" ]; then
  KEY=$(python3 -c "
import sys, json
with open('$CREDENTIALS_FILE') as f:
    d = json.load(f)
# Suporta formatos: {'primaryApiKey': '...'} ou {'api_key': '...'} ou {'ANTHROPIC_API_KEY': '...'}
key = d.get('primaryApiKey') or d.get('api_key') or d.get('ANTHROPIC_API_KEY') or ''
print(key)
" 2>/dev/null)
  if [ -n "$KEY" ] && [ "$KEY" != "None" ]; then
    echo "$KEY"
    exit 0
  fi
fi

# Tentativa 2: variável de ambiente
if [ -n "$ANTHROPIC_API_KEY" ]; then
  echo "$ANTHROPIC_API_KEY"
  exit 0
fi

# Tentativa 3: arquivo .env na raiz do usuário
ENV_FILE="$HOME/.env"
if [ -f "$ENV_FILE" ]; then
  KEY=$(grep "^ANTHROPIC_API_KEY=" "$ENV_FILE" | cut -d'=' -f2- | tr -d '"'"'" | tr -d '\r')
  if [ -n "$KEY" ]; then
    echo "$KEY"
    exit 0
  fi
fi

# Falha silenciosa — Claude Code usará método padrão
exit 1
