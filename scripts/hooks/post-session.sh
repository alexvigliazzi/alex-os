#!/bin/bash
# post-session.sh — Stop Hook (fase 1) — Alex-OS Auto-Digest
# Executa ao encerrar sessão Claude Code (antes de export-session.sh)
# FUNÇÃO: Gerar digest automático de sessão se /session-close não foi invocado

CLAUDE_HOME="${HOME}/.claude"
SESSIONS_DIR="${CLAUDE_HOME}/memory/sessions"
SESSION_STATE="${CLAUDE_HOME}/context/session-state.md"
AUDIT_LOG="${CLAUDE_HOME}/context/tool-audit.log"
DATE=$(date +%Y-%m-%d)
TIMESTAMP_FILE=$(date +%Y-%m-%d_%H%M)

# Criar diretório de sessões se não existir
mkdir -p "$SESSIONS_DIR" 2>/dev/null || true

# --- Verificar se já existe digest para hoje (manual via /session-close) ---
EXISTING=$(find "$SESSIONS_DIR" -maxdepth 1 -name "${DATE}_*.md" -not -name "*auto*" -type f 2>/dev/null | head -1)

if [ -n "$EXISTING" ]; then
  echo "[alex-os] digest manual encontrado: $(basename "$EXISTING") — auto-digest ignorado"
  exit 0
fi

# --- Verificar se já existe auto-digest para hoje ---
EXISTING_AUTO=$(find "$SESSIONS_DIR" -maxdepth 1 -name "${DATE}_*_auto.md" -type f 2>/dev/null | head -1)
if [ -n "$EXISTING_AUTO" ]; then
  echo "[alex-os] auto-digest já existe para hoje — nada a fazer"
  exit 0
fi

# --- Gerar auto-digest a partir do tool-audit.log ---
DIGEST_FILE="${SESSIONS_DIR}/${TIMESTAMP_FILE}_auto.md"

# Extrair arquivos modificados e erros do log de auditoria de hoje
MODIFIED_FILES=""
BASH_ERRORS=""

if [ -f "$AUDIT_LOG" ]; then
  MODIFIED_FILES=$(grep "\[$DATE" "$AUDIT_LOG" | grep "MODIFIED:" | sed 's/.*MODIFIED: //' | sort -u | head -20 || echo "")
  BASH_ERRORS=$(grep "\[$DATE" "$AUDIT_LOG" | grep "BASH_ERROR:" | sed 's/.*BASH_ERROR: //' | head -10 || echo "")
  BLOCKED=$(grep "\[$DATE" "$AUDIT_LOG" | grep "BLOCKED:" | sed 's/.*BLOCKED: //' | head -5 || echo "")
fi

# Contar ferramentas usadas hoje
TOOLS_COUNT=$(grep "\[$DATE" "$AUDIT_LOG" 2>/dev/null | grep "TOOL:" | wc -l | tr -d ' ' || echo "0")

{
  echo "# Session Digest — $DATE [auto-gerado]"
  echo ""
  echo "> Este digest foi gerado automaticamente ao encerrar a sessão."
  echo "> Para um digest completo, use \`/session-close\` antes de encerrar."
  echo ""
  echo "## Resumo"
  echo "- **Data**: $DATE"
  echo "- **Ferramentas usadas**: $TOOLS_COUNT calls"
  echo "- **Digest**: automático (session-close não foi invocado)"
  echo ""

  if [ -n "$MODIFIED_FILES" ]; then
    echo "## Arquivos Modificados"
    echo "$MODIFIED_FILES" | while IFS= read -r f; do
      [ -n "$f" ] && echo "- \`$f\`"
    done
    echo ""
  fi

  if [ -n "$BASH_ERRORS" ]; then
    echo "## Erros Registrados"
    echo "$BASH_ERRORS" | while IFS= read -r e; do
      [ -n "$e" ] && echo "- \`$e\`"
    done
    echo ""
  fi

  if [ -n "$BLOCKED" ]; then
    echo "## Comandos Bloqueados"
    echo "$BLOCKED" | while IFS= read -r b; do
      [ -n "$b" ] && echo "- \`$b\`"
    done
    echo ""
  fi

  echo "## Contexto (session-state.md)"
  if [ -f "$SESSION_STATE" ]; then
    echo ""
    cat "$SESSION_STATE"
  fi
} > "$DIGEST_FILE" 2>/dev/null

echo "[alex-os] auto-digest gerado: $(basename "$DIGEST_FILE") ($TOOLS_COUNT tool calls registrados)"

# Manter apenas os 5 backups mais recentes de session-state
ls -t "${CLAUDE_HOME}/context"/session-state.backup.*.md 2>/dev/null | tail -n +6 | xargs rm -f 2>/dev/null || true

exit 0
