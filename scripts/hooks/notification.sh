#!/bin/bash
# notification.sh — Notification Hook — Alex-OS
# Recebe JSON de notificação via stdin
# Loga em session-state.md e opcionalmente notifica o sistema

SESSION_STATE="$HOME/.claude/context/session-state.md"

# Guard: python3 obrigatório para parsear JSON com segurança
if ! command -v python3 &>/dev/null; then
  exit 0
fi

INPUT=$(cat)

# Validar JSON mínimo antes de processar
if ! echo "$INPUT" | python3 -c "import sys,json; json.load(sys.stdin)" 2>/dev/null; then
  exit 0
fi

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Extrair campos via variáveis de ambiente (evita interpolação insegura no Python)
MESSAGE=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('message','') or '')" 2>/dev/null || echo "")
TITLE=$(echo "$INPUT" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('title','Claude Code') or 'Claude Code')" 2>/dev/null || echo "Claude Code")

# Append ao session-state.md (não sobrescreve)
echo "[$TIMESTAMP] NOTIF: $TITLE — $MESSAGE" >> "$SESSION_STATE" 2>/dev/null

# Notificação Windows via PowerShell
# SEGURANÇA: MESSAGE e TITLE passados via variáveis de ambiente,
# não interpolados diretamente na string do script PowerShell (evita injeção)
NOTIF_MSG="$MESSAGE" NOTIF_TITLE="$TITLE" powershell.exe -WindowStyle Hidden -Command "
  \$msg   = \$env:NOTIF_MSG
  \$title = \$env:NOTIF_TITLE
  Add-Type -AssemblyName System.Windows.Forms
  \$balloon = New-Object System.Windows.Forms.NotifyIcon
  \$balloon.Icon = [System.Drawing.SystemIcons]::Information
  \$balloon.BalloonTipIcon = 'Info'
  \$balloon.BalloonTipText  = \$msg
  \$balloon.BalloonTipTitle = \$title
  \$balloon.Visible = \$true
  \$balloon.ShowBalloonTip(3000)
  Start-Sleep -Milliseconds 3500
  \$balloon.Dispose()
" 2>/dev/null &

exit 0
