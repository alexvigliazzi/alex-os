#!/bin/bash
# Alex-OS CIAM Query Wrapper
# Uso: bash ciam-query.sh "query string"
# Requer: ciam servidor HTTP ativo (ciam serve)

QUERY="${1:-}"
CIAM_BIN="${HOME}/go/bin/ciam.exe"
CIAM_HTTP="http://localhost:8080"

if [ -z "${QUERY}" ]; then
  echo "Uso: ciam-query.sh 'sua query aqui'"
  exit 1
fi

# Verificar ciam via MCP (modo preferencial no Claude Code)
if [ -f "${CIAM_BIN}" ]; then
  # Tentar HTTP se servidor estiver ativo
  HTTP_STATUS=$(curl -s --connect-timeout 1 "${CIAM_HTTP}/health" 2>/dev/null | grep -c "ok" || true)
  if [ "${HTTP_STATUS}" -gt 0 ]; then
    curl -s "${CIAM_HTTP}/search?q=$(python3 -c "import urllib.parse; print(urllib.parse.quote('${QUERY}'))")" 2>/dev/null
  else
    echo "[ciam] servidor HTTP inativo — usar via MCP no Claude Code (tools automáticos)"
  fi
else
  echo "[ciam] binário não encontrado em ${CIAM_BIN}"
fi
