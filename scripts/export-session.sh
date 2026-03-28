#!/bin/bash
# ~/.claude/scripts/export-session.sh
# Stop hook — exporta latest session digest para Obsidian vault
# Ambiente: Git Bash (Windows). NÃO executar via PowerShell ou WSL.

set -euo pipefail

SESSIONS_DIR="$HOME/.claude/memory/sessions"
VAULT="${ALEX_VAULT:-$HOME/OneDrive/alex-master-brain}"
TARGET="$VAULT/02_Relatorios_e_Sessoes/Dev"
LOG="$HOME/.claude/memory/sessions/export.log"

log() { echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] $*" | tee -a "$LOG"; }

# Validar vault acessível
if [ ! -d "$VAULT" ]; then
  log "ERROR: vault não encontrado em $VAULT — export abortado"
  exit 1
fi

if [ ! -d "$SESSIONS_DIR" ]; then
  log "ERROR: sessions directory not found: $SESSIONS_DIR"
  exit 1
fi

mkdir -p "$TARGET"

if [ ! -w "$TARGET" ]; then
  log "ERROR: target directory not writable: $TARGET"
  exit 1
fi

# Ordenação lexicográfica pelo prefixo YYYY-MM-DD (mais confiável que mtime no OneDrive)
LATEST=$(find "$SESSIONS_DIR" -maxdepth 1 -name "*.md" -type f 2>/dev/null | sort | tail -1 || true)

if [ -z "$LATEST" ]; then
  # Fallback: use session-state.md if updated today
  SESSION_STATE="$HOME/.claude/context/session-state.md"
  TODAY=$(date +%Y-%m-%d)
  if [ -f "$SESSION_STATE" ] && grep -q "$TODAY" "$SESSION_STATE" 2>/dev/null; then
    FALLBACK="$SESSIONS_DIR/${TODAY}_auto_fallback.md"
    cp "$SESSION_STATE" "$FALLBACK"
    LATEST="$FALLBACK"
    log "INFO: digest ausente — usando session-state.md como fallback: $FALLBACK"
  else
    log "INFO: nenhum digest em $SESSIONS_DIR e session-state sem atividade hoje — nada a exportar"
    exit 0
  fi
fi

FILENAME=$(basename "$LATEST")
DEST="$TARGET/$FILENAME"

# Overwrite — permite correção do digest na mesma sessão
if cp "$LATEST" "$DEST"; then
  log "OK: $FILENAME exportado para Obsidian"
else
  log "ERROR: falha ao copiar $FILENAME para $DEST"
  exit 1
fi
