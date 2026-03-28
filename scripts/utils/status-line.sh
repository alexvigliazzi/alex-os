#!/bin/bash
# status-line.sh — StatusLine — Alex-OS
# Exibido na status bar do Claude Code
# Saída: string de texto plano (sem newlines extras)

# --- Detectar domínio via case em $PWD (mais seguro que grep com regex) ---
DOMAIN="GLOBAL"
case "$PWD" in
  *SisAlmoxIBTEC*|*sisalmox*) DOMAIN="GAS"        ;;
  *SisIBTEC*|*sisibtec*)      DOMAIN="NEXT"       ;;
  *projects/business*)        DOMAIN="BUSINESS"   ;;
  *projects/marketing*)       DOMAIN="MARKETING"  ;;
  *projects/personal*)        DOMAIN="PERSONAL"   ;;
  *projects/secretary*)       DOMAIN="SECRETARY"  ;;
  */.claude)                  DOMAIN="CONFIG"     ;;
esac

# --- Checar Ollama ---
OLLAMA_STATUS="offline"
if curl -s --max-time 1 http://localhost:11434/api/tags 2>/dev/null | grep -q "name"; then
  OLLAMA_STATUS="up"
fi

# --- SDD Phase ---
SDD_INFO=""
if [ -n "$SDD_PHASE" ] && [[ "$SDD_PHASE" =~ ^[0-9]+$ ]]; then
  PHASE_NAMES=("" "Pesquisa" "Spec" "Testes" "Impl")
  SDD_INFO=" | SDD:${PHASE_NAMES[$SDD_PHASE]:-F$SDD_PHASE}"
fi

# --- Modelo ativo (leitura de env ou default) ---
MODEL="${CLAUDE_MODEL:-sonnet}"

# Saída final
printf "[%s] %s | Ollama:%s%s" "$DOMAIN" "$MODEL" "$OLLAMA_STATUS" "$SDD_INFO"
