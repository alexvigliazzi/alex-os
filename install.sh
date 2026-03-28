#!/usr/bin/env bash
# Alex-OS Installer — Deploys Alex-OS files to ~/.claude/
# Compatible with: Git Bash (Windows), macOS, Linux
# Usage: bash install.sh [--force]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$CLAUDE_DIR/backups/alex-os-$(date +%Y%m%d-%H%M%S)"
FORCE="${1:-}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()   { echo -e "${GREEN}[alex-os]${NC} $1"; }
warn()  { echo -e "${YELLOW}[alex-os]${NC} $1"; }
error() { echo -e "${RED}[alex-os]${NC} $1" >&2; }

# --- Pre-checks ---
if ! command -v claude &>/dev/null; then
  warn "Claude Code CLI nao encontrado. O Alex-OS sera instalado, mas voce precisara do CLI para usa-lo."
fi

# --- Create ~/.claude if needed ---
mkdir -p "$CLAUDE_DIR"

# --- Directories to install (order matters) ---
DIRS=(agents commands context rules workflows scripts references skills)

# --- Backup existing files ---
backup_if_exists() {
  local target="$1"
  if [[ -e "$target" ]]; then
    mkdir -p "$BACKUP_DIR"
    local rel="${target#$CLAUDE_DIR/}"
    local backup_path="$BACKUP_DIR/$rel"
    mkdir -p "$(dirname "$backup_path")"
    cp -r "$target" "$backup_path"
  fi
}

# --- Install directories ---
log "Instalando Alex-OS em $CLAUDE_DIR..."

for dir in "${DIRS[@]}"; do
  if [[ -d "$SCRIPT_DIR/$dir" ]]; then
    # Backup existing
    if [[ -d "$CLAUDE_DIR/$dir" && "$FORCE" != "--force" ]]; then
      backup_if_exists "$CLAUDE_DIR/$dir"
      log "Backup de $dir criado em $BACKUP_DIR/"
    fi

    # Copy with merge (don't delete existing files, just overwrite matching ones)
    cp -r "$SCRIPT_DIR/$dir/." "$CLAUDE_DIR/$dir/" 2>/dev/null || \
    cp -r "$SCRIPT_DIR/$dir/"* "$CLAUDE_DIR/$dir/" 2>/dev/null || true

    log "Instalado: $dir/"
  fi
done

# --- Install CLAUDE.md from template ---
if [[ -f "$SCRIPT_DIR/templates/CLAUDE.md.template" ]]; then
  if [[ -f "$CLAUDE_DIR/CLAUDE.md" && "$FORCE" != "--force" ]]; then
    backup_if_exists "$CLAUDE_DIR/CLAUDE.md"
    warn "CLAUDE.md existente. Backup criado. Sobrescrevendo com template."
  fi

  # Replace USERNAME placeholder with actual username
  USERNAME="$(whoami)"
  HOMEDIR="$HOME"
  sed -e "s|{{USERNAME}}|$USERNAME|g" \
      -e "s|{{HOMEDIR}}|$HOMEDIR|g" \
      "$SCRIPT_DIR/templates/CLAUDE.md.template" > "$CLAUDE_DIR/CLAUDE.md"

  log "CLAUDE.md instalado (usuario: $USERNAME)"
fi

# --- Install INDEX.md ---
if [[ -f "$SCRIPT_DIR/INDEX.md" ]]; then
  backup_if_exists "$CLAUDE_DIR/INDEX.md"
  cp "$SCRIPT_DIR/INDEX.md" "$CLAUDE_DIR/INDEX.md"
  log "INDEX.md instalado"
fi

# --- Install settings.json (only if not exists) ---
if [[ ! -f "$CLAUDE_DIR/settings.json" ]]; then
  if [[ -f "$SCRIPT_DIR/templates/settings.json.template" ]]; then
    USERNAME="$(whoami)"
    HOMEDIR_ESCAPED="${HOME//\\/\\\\}"
    sed -e "s|{{USERNAME}}|$USERNAME|g" \
        -e "s|{{HOMEDIR}}|$HOMEDIR_ESCAPED|g" \
        "$SCRIPT_DIR/templates/settings.json.template" > "$CLAUDE_DIR/settings.json"
    log "settings.json criado a partir do template"
  fi
else
  log "settings.json ja existe — nao sobrescrito (use --force para sobrescrever)"
fi

# --- Install mcp.json (only if not exists) ---
if [[ ! -f "$CLAUDE_DIR/mcp.json" ]]; then
  if [[ -f "$SCRIPT_DIR/templates/mcp.json.template" ]]; then
    cp "$SCRIPT_DIR/templates/mcp.json.template" "$CLAUDE_DIR/mcp.json"
    log "mcp.json criado a partir do template"
  fi
else
  log "mcp.json ja existe — nao sobrescrito"
fi

# --- Create memory directory ---
mkdir -p "$CLAUDE_DIR/memory"

# --- Make scripts executable ---
find "$CLAUDE_DIR/scripts" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
log "Scripts marcados como executaveis"

# --- Validation ---
ERRORS=0

check_file() {
  if [[ ! -f "$1" ]]; then
    error "FALTANDO: $1"
    ((ERRORS++))
  fi
}

check_dir() {
  if [[ ! -d "$1" ]]; then
    error "FALTANDO: $1"
    ((ERRORS++))
  fi
}

check_file "$CLAUDE_DIR/CLAUDE.md"
check_dir "$CLAUDE_DIR/agents"
check_dir "$CLAUDE_DIR/agents/csuite"
check_dir "$CLAUDE_DIR/commands"
check_dir "$CLAUDE_DIR/rules"
check_dir "$CLAUDE_DIR/workflows"
check_dir "$CLAUDE_DIR/scripts/hooks"
check_file "$CLAUDE_DIR/agents/_boss.md"
check_file "$CLAUDE_DIR/rules/constitution.md"
check_file "$CLAUDE_DIR/commands/boss.md"

if [[ $ERRORS -eq 0 ]]; then
  echo ""
  log "====================================="
  log "Alex-OS instalado com sucesso!"
  log "====================================="
  echo ""
  log "Comandos disponiveis:"
  log "  /boss  — Grand Boss (orquestrador)"
  log "  /ceo   — Chief Executive Officer"
  log "  /cpo   — Chief Product Officer"
  log "  /cto   — Chief Technology Officer"
  log "  /coo   — Chief Operating Officer"
  log "  /cfo   — Chief Financial Officer"
  log "  /cmo   — Chief Marketing Officer"
  echo ""
  log "Workflows:"
  log "  /development        — Ciclo completo de feature"
  log "  /problem-resolution — Investigacao de bug"
  log "  /test-deploy        — Pipeline de deploy"
  log "  /documentation      — Geracao de documentacao"
  log "  /context-first      — Carregamento de contexto"
  echo ""
  log "Proximo passo: abra o Claude Code e teste com '/boss'"
else
  error "$ERRORS arquivo(s) faltando. Verifique a instalacao."
  exit 1
fi
