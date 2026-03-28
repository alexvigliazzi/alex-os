#!/bin/bash
# pre-tool-use.sh — PreToolUse Hook — Alex-OS Security Guard
# Recebe JSON via stdin, bloqueia comandos perigosos e log de auditoria
# Retornar {"decision":"block","reason":"..."} para abortar a tool call
# Exit 0 (sem output ou output não-JSON) = permitir

AUDIT_LOG="$HOME/.claude/context/tool-audit.log"

# Guard: python3 obrigatório para parsear JSON com segurança
# Se python3 ausente, bloquear — melhor recusar do que permitir sem verificação
if ! command -v python3 &>/dev/null; then
  echo '{"decision":"block","reason":"python3 não encontrado — hook de segurança não pode verificar o comando. Instale python3 no PATH do Git Bash."}'
  exit 0
fi

# Ler stdin completo
INPUT=$(cat)

# Validar JSON mínimo
if ! echo "$INPUT" | python3 -c "import sys,json; json.load(sys.stdin)" 2>/dev/null; then
  exit 0
fi

# Extrair campos do JSON via python
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_name',''))" 2>/dev/null || echo "")

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# --- LOG DE AUDITORIA ---
echo "[$TIMESTAMP] TOOL: $TOOL_NAME" >> "$AUDIT_LOG" 2>/dev/null

# --- BLOCO 1: Comandos Bash perigosos ---
if [ "$TOOL_NAME" = "Bash" ]; then
  COMMAND=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('command',''))" 2>/dev/null || echo "")

  echo "[$TIMESTAMP] BASH: $COMMAND" >> "$AUDIT_LOG" 2>/dev/null

  # Normalizar: colapsar espaços/tabs múltiplos, converter para minúsculas
  # Isso fecha bypasses como "git push  --force" (espaço duplo) ou variações de case
  NORMALIZED=$(echo "$COMMAND" | tr '[:upper:]' '[:lower:]' | tr -s ' \t' ' ')

  # Lista negra — padrões destrutivos (em minúsculas, sem espaço trailing problemático)
  DANGEROUS_PATTERNS=(
    "git push --force"
    "git push -f"
    "git push --force-with-lease"
    "git reset --hard"
    "git checkout -- ."
    "git clean -f"
    "git branch -d main"
    "git branch -d master"
    "rm -rf /"
    "rm -rf ~"
    "rm -rf \$home"
    "drop table"
    "drop database"
    "> /dev/sda"
    "dd if="
    "mkfs"
    "format c:"
  )

  for pattern in "${DANGEROUS_PATTERNS[@]}"; do
    if echo "$NORMALIZED" | grep -q "$pattern"; then
      echo "[$TIMESTAMP] BLOCKED: $pattern" >> "$AUDIT_LOG" 2>/dev/null
      echo "{\"decision\":\"block\",\"reason\":\"Comando bloqueado por segurança (security.md L1): padrão destrutivo detectado ('$pattern'). Confirme explicitamente com o usuário antes de prosseguir.\"}"
      exit 0
    fi
  done
fi

# --- BLOCO 2: SDD Phase Guard ---
# Se SDD_PHASE está definida como número 1, 2 ou 3, bloquear Write/Edit em produção
# Validar que SDD_PHASE é estritamente numérico antes de usar
if [ -n "$SDD_PHASE" ] && [[ "$SDD_PHASE" =~ ^[0-9]+$ ]] && [ "$SDD_PHASE" -le 3 ]; then
  if [ "$TOOL_NAME" = "Write" ] || [ "$TOOL_NAME" = "Edit" ]; then
    FILE_PATH=$(echo "$INPUT" | python3 -c "
import sys,json
d=json.load(sys.stdin)
inp=d.get('tool_input',{})
print(inp.get('file_path','') or inp.get('path',''))
" 2>/dev/null || echo "")

    # Permitir escrita em artefatos SDD (plans, memory, context)
    if echo "$FILE_PATH" | grep -qF ".claude/plans/"; then exit 0; fi
    if echo "$FILE_PATH" | grep -qF ".claude/memory/"; then exit 0; fi
    if echo "$FILE_PATH" | grep -qF ".claude/context/"; then exit 0; fi

    echo "[$TIMESTAMP] SDD_BLOCKED (fase $SDD_PHASE): $FILE_PATH" >> "$AUDIT_LOG" 2>/dev/null
    echo "{\"decision\":\"block\",\"reason\":\"SDD Fase $SDD_PHASE ativa: escrita em código de produção bloqueada. Use /clear e avance para a fase correta antes de implementar.\"}"
    exit 0
  fi
fi

# --- Permitir ---
exit 0
