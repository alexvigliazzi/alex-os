#!/bin/bash
# file-suggestion.sh — FileSuggestion — Alex-OS
# Recebe JSON via stdin: {"query": "...", "cwd": "..."}
# Retorna JSON array de file paths relevantes para o contexto atual

# Guard: python3 obrigatório
if ! command -v python3 &>/dev/null; then
  echo "[]"
  exit 0
fi

INPUT=$(cat)

# Validar JSON mínimo
if ! echo "$INPUT" | python3 -c "import sys,json; json.load(sys.stdin)" 2>/dev/null; then
  echo "[]"
  exit 0
fi

QUERY=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('query','') or '')" 2>/dev/null || echo "")
CWD=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('cwd','') or '')" 2>/dev/null || echo "")
CWD="${CWD:-$PWD}"

# --- Prioridades por projeto usando case (mais seguro que grep em $CWD) ---
case "$CWD" in
  *SisAlmoxIBTEC*|*sisalmox*)
    INCLUDE_ARGS="--include=*.gs --include=*.js --include=*.json --include=*.md"
    ;;
  *SisIBTEC*|*sisibtec*)
    INCLUDE_ARGS="--include=*.ts --include=*.tsx --include=*.prisma --include=*.json"
    ;;
  *)
    INCLUDE_ARGS="--include=*.ts --include=*.tsx --include=*.js --include=*.json --include=*.md"
    ;;
esac

# --- Busca por query (grep -F: fixed string, não regex — evita injeção) ---
RESULTS=()

if [ -n "$QUERY" ] && [ -d "$CWD" ]; then
  while IFS= read -r file; do
    [ -f "$file" ] && RESULTS+=("$file")
  done < <(grep -rlF "$QUERY" "$CWD" \
    $INCLUDE_ARGS \
    --exclude-dir=node_modules --exclude-dir=.git \
    2>/dev/null | head -8)
fi

# 2. Arquivos de config sempre relevantes
CONFIG_FILES=(
  "$CWD/package.json"
  "$CWD/tsconfig.json"
  "$CWD/appsscript.json"
  "$CWD/.clasp.json"
  "$CWD/prisma/schema.prisma"
  "$HOME/.claude/context/project.md"
)
for f in "${CONFIG_FILES[@]}"; do
  [ -f "$f" ] && RESULTS+=("$f")
done

# --- Dedup e formatar como JSON array ---
# SEGURANÇA: dados passados ao Python via pipe com null-delimiter,
# não via expansão de subshell dentro do heredoc (evita shell injection)
if [ ${#RESULTS[@]} -eq 0 ]; then
  echo "[]"
  exit 0
fi

printf '%s\0' "${RESULTS[@]}" | python3 -c "
import sys, json

data = sys.stdin.buffer.read()
files = [f.decode('utf-8', errors='replace') for f in data.split(b'\x00') if f]

seen = set()
results = []
for f in files:
    if f and f not in seen:
        seen.add(f)
        results.append(f)

print(json.dumps(results[:12]))
"
