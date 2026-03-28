#!/bin/bash
# post-tool-use.sh — PostToolUse Hook — Alex-OS Audit Logger
# Recebe JSON via stdin com resultado da tool call
# Registra em tool-audit.log e marca erros em napkin.md

AUDIT_LOG="$HOME/.claude/context/tool-audit.log"
NAPKIN="$HOME/.claude/memory/napkin.md"

# Guard: python3 obrigatório para parsear JSON com segurança
# Falha silenciosa — log de auditoria perde entradas, mas não bloqueia o fluxo
if ! command -v python3 &>/dev/null; then
  exit 0
fi

# Ler stdin
INPUT=$(cat)

# Validar JSON mínimo
if ! echo "$INPUT" | python3 -c "import sys,json; json.load(sys.stdin)" 2>/dev/null; then
  exit 0
fi

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Extrair campos
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name',''))" 2>/dev/null)
IS_ERROR=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('is_error',False))" 2>/dev/null)

# --- LOG WRITE/EDIT: registrar arquivo modificado ---
if [ "$TOOL_NAME" = "Write" ] || [ "$TOOL_NAME" = "Edit" ]; then
  FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys,json
d=json.load(sys.stdin)
inp=d.get('tool_input',{})
print(inp.get('file_path','') or inp.get('path',''))
" 2>/dev/null)
  echo "[$TIMESTAMP] MODIFIED: $FILE_PATH" >> "$AUDIT_LOG" 2>/dev/null
fi

# --- LOG BASH ERROR: registrar em napkin.md ---
if [ "$TOOL_NAME" = "Bash" ] && [ "$IS_ERROR" = "True" ]; then
  COMMAND=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null)
  OUTPUT=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_response','')[:200])" 2>/dev/null)

  # Append ao napkin.md
  {
    echo ""
    echo "### [$TIMESTAMP] Erro em Bash"
    echo "**Comando:** \`$COMMAND\`"
    echo "**Output:** $OUTPUT"
    echo ""
  } >> "$NAPKIN" 2>/dev/null

  echo "[$TIMESTAMP] BASH_ERROR: $COMMAND" >> "$AUDIT_LOG" 2>/dev/null
fi

exit 0
