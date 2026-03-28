#!/usr/bin/env bash
# ============================================
# ollama-router.sh — Roteamento real para Ollama local
# Alex-OS v2.0
# ============================================
# Uso:
#   bash ollama-router.sh check              → verifica se Ollama esta online
#   bash ollama-router.sh query "prompt"      → envia prompt para gemma3:4b
#   bash ollama-router.sh summarize "texto"   → sumariza texto com gemma3:4b
#   bash ollama-router.sh embed "texto"       → gera embedding com nomic-embed-text
#   bash ollama-router.sh models              → lista modelos disponiveis
# ============================================

set -euo pipefail

# Endpoint — localhost funciona tanto de Git Bash quanto de Windows nativo
# Normaliza OLLAMA_HOST: adiciona http:// se ausente, substitui 0.0.0.0 por localhost
_raw_host="${OLLAMA_HOST:-http://localhost:11434}"
# Remove protocolo se presente para normalizar
_raw_host="${_raw_host#http://}"
_raw_host="${_raw_host#https://}"
# Substitui 0.0.0.0 por localhost (0.0.0.0 e bind address, nao conectavel no Windows)
_raw_host="${_raw_host/0.0.0.0/localhost}"
OLLAMA_HOST="http://${_raw_host}"
OLLAMA_MODEL="${OLLAMA_MODEL:-gemma3:4b}"
OLLAMA_EMBED_MODEL="${OLLAMA_EMBED_MODEL:-nomic-embed-text:latest}"
TIMEOUT=30

# ---- Funcoes ----

ollama_check() {
    local response
    response=$(curl -s --connect-timeout 3 "$OLLAMA_HOST/api/tags" 2>/dev/null)
    if echo "$response" | grep -q '"name"'; then
        echo "up"
        return 0
    else
        echo "down"
        return 1
    fi
}

ollama_models() {
    curl -s --connect-timeout 3 "$OLLAMA_HOST/api/tags" 2>/dev/null | \
        grep -oP '"name"\s*:\s*"[^"]*"' | \
        sed 's/"name"\s*:\s*"//;s/"//' || echo "Erro: Ollama offline"
}

ollama_query() {
    local prompt="$1"
    local model="${2:-$OLLAMA_MODEL}"
    local system_prompt="${3:-Responda de forma concisa e direta em Portugues-BR.}"

    # Verificar disponibilidade
    if ! ollama_check > /dev/null 2>&1; then
        echo "ERRO: Ollama offline. Fallback para Claude API."
        return 1
    fi

    # Chamar API generate (streaming desabilitado para captura completa)
    local response
    response=$(curl -s --max-time "$TIMEOUT" "$OLLAMA_HOST/api/generate" \
        -H "Content-Type: application/json" \
        -d "$(cat <<ENDJSON
{
    "model": "$model",
    "prompt": "$prompt",
    "system": "$system_prompt",
    "stream": false,
    "options": {
        "temperature": 0.3,
        "num_predict": 2048
    }
}
ENDJSON
)" 2>/dev/null)

    if [ $? -ne 0 ] || [ -z "$response" ]; then
        echo "ERRO: Falha na chamada ao Ollama."
        return 1
    fi

    # Extrair resposta do JSON
    echo "$response" | grep -oP '"response"\s*:\s*"[^"]*"' | \
        sed 's/"response"\s*:\s*"//;s/"$//' | \
        sed 's/\\n/\n/g; s/\\t/\t/g; s/\\"/"/g' || \
        echo "$response"
}

ollama_summarize() {
    local text="$1"
    ollama_query "Resuma o seguinte texto de forma concisa, mantendo os pontos principais:\n\n$text" \
        "$OLLAMA_MODEL" \
        "Voce e um assistente de sumarizacao. Responda em Portugues-BR. Seja conciso."
}

ollama_embed() {
    local text="$1"

    if ! ollama_check > /dev/null 2>&1; then
        echo "ERRO: Ollama offline."
        return 1
    fi

    curl -s --max-time "$TIMEOUT" "$OLLAMA_HOST/api/embed" \
        -H "Content-Type: application/json" \
        -d "$(cat <<ENDJSON
{
    "model": "$OLLAMA_EMBED_MODEL",
    "input": "$text"
}
ENDJSON
)" 2>/dev/null
}

ollama_chat() {
    local user_msg="$1"
    local system_msg="${2:-Voce e um assistente conciso. Responda em Portugues-BR.}"

    if ! ollama_check > /dev/null 2>&1; then
        echo "ERRO: Ollama offline."
        return 1
    fi

    local response
    response=$(curl -s --max-time "$TIMEOUT" "$OLLAMA_HOST/api/chat" \
        -H "Content-Type: application/json" \
        -d "$(cat <<ENDJSON
{
    "model": "$OLLAMA_MODEL",
    "messages": [
        {"role": "system", "content": "$system_msg"},
        {"role": "user", "content": "$user_msg"}
    ],
    "stream": false,
    "options": {
        "temperature": 0.3,
        "num_predict": 2048
    }
}
ENDJSON
)" 2>/dev/null)

    echo "$response" | grep -oP '"content"\s*:\s*"[^"]*"' | tail -1 | \
        sed 's/"content"\s*:\s*"//;s/"$//' | \
        sed 's/\\n/\n/g; s/\\t/\t/g; s/\\"/"/g' || \
        echo "$response"
}

# ---- Ponto de entrada ----

case "${1:-help}" in
    check)
        ollama_check
        ;;
    models)
        ollama_models
        ;;
    query)
        ollama_query "${2:?Uso: ollama-router.sh query \"prompt\"}" "${3:-}" "${4:-}"
        ;;
    summarize)
        ollama_summarize "${2:?Uso: ollama-router.sh summarize \"texto\"}"
        ;;
    embed)
        ollama_embed "${2:?Uso: ollama-router.sh embed \"texto\"}"
        ;;
    chat)
        ollama_chat "${2:?Uso: ollama-router.sh chat \"mensagem\"}" "${3:-}"
        ;;
    help|*)
        cat <<'USAGE'
ollama-router.sh — Roteamento para Ollama local (Alex-OS)

Comandos:
  check                      Verifica se Ollama esta online (retorna "up"/"down")
  models                     Lista modelos disponiveis
  query "prompt" [model]     Envia prompt para modelo (default: gemma3:4b)
  summarize "texto"          Sumariza texto com gemma3:4b
  embed "texto"              Gera embedding com nomic-embed-text
  chat "mensagem" [system]   Chat com contexto de sistema

Variaveis de ambiente:
  OLLAMA_HOST       Endpoint (default: http://localhost:11434)
  OLLAMA_MODEL      Modelo de texto (default: gemma3:4b)
  OLLAMA_EMBED_MODEL Modelo de embedding (default: nomic-embed-text:latest)

Exemplos:
  bash ollama-router.sh check
  bash ollama-router.sh query "O que e Kubernetes?"
  bash ollama-router.sh summarize "$(cat arquivo.md)"
  bash ollama-router.sh embed "busca semantica"
USAGE
        ;;
esac
