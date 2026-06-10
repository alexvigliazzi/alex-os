#!/usr/bin/env bash
# setup-google-auth.sh — Configura autenticação Google Cloud + Gemini + Clasp
# Executar manualmente (requer interação do usuário)
# Uso: bash scripts/setup-google-auth.sh

set -e

BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info()    { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[AVISO]${NC} $1"; }
section() { echo -e "\n${BOLD}=== $1 ===${NC}"; }

# ─── PATH ────────────────────────────────────────────────────────────────────
export PATH="/opt/google-cloud-sdk/bin:$PATH"

section "VERIFICAÇÃO DE FERRAMENTAS"

check_tool() {
  if command -v "$1" &>/dev/null; then
    info "$1 disponível ($(command -v "$1"))"
  else
    echo -e "${RED}[ERRO]${NC} $1 não encontrado"
    exit 1
  fi
}

check_tool gcloud
check_tool clasp
check_tool node
check_tool python3

# ─── GOOGLE CLOUD ────────────────────────────────────────────────────────────
section "GOOGLE CLOUD AUTHENTICATION"

if gcloud auth list --filter=status:ACTIVE --format="value(account)" 2>/dev/null | grep -q "@"; then
  ACCOUNT=$(gcloud auth list --filter=status:ACTIVE --format="value(account)" 2>/dev/null | head -1)
  info "Já autenticado como: $ACCOUNT"
else
  warn "Não autenticado. Execute o comando abaixo:"
  echo ""
  echo "  gcloud auth login --no-browser"
  echo ""
  echo "Ou para autenticação com Application Default Credentials (ADC):"
  echo "  gcloud auth application-default login --no-browser"
  echo ""
  read -p "Pressione Enter após autenticar para continuar..."
fi

# ─── PROJECT CONFIG ───────────────────────────────────────────────────────────
section "CONFIGURAÇÃO DO PROJETO GOOGLE CLOUD"

CURRENT_PROJECT=$(gcloud config get-value project 2>/dev/null)
if [ -n "$CURRENT_PROJECT" ] && [ "$CURRENT_PROJECT" != "(unset)" ]; then
  info "Projeto ativo: $CURRENT_PROJECT"
else
  warn "Nenhum projeto configurado."
  echo ""
  echo "Liste seus projetos com: gcloud projects list"
  echo "Defina com: gcloud config set project SEU_PROJECT_ID"
  echo ""
  read -p "Digite o Project ID (ou Enter para pular): " PROJECT_ID
  if [ -n "$PROJECT_ID" ]; then
    gcloud config set project "$PROJECT_ID"
    info "Projeto configurado: $PROJECT_ID"
  fi
fi

# ─── GEMINI API KEY ───────────────────────────────────────────────────────────
section "GEMINI API KEY"

ENV_FILE="$HOME/.env"
GEMINI_KEY=$(grep "^GEMINI_API_KEY=" "$ENV_FILE" 2>/dev/null | cut -d'=' -f2- | tr -d '"'"'" | tr -d '\r')

if [ -n "$GEMINI_KEY" ]; then
  info "GEMINI_API_KEY já configurada em ~/.env"
else
  warn "GEMINI_API_KEY não encontrada."
  echo ""
  echo "Gere sua chave em: https://aistudio.google.com/app/apikey"
  echo ""
  read -p "Cole sua Gemini API Key (ou Enter para pular): " GEMINI_KEY_INPUT
  if [ -n "$GEMINI_KEY_INPUT" ]; then
    echo "GEMINI_API_KEY=$GEMINI_KEY_INPUT" >> "$ENV_FILE"
    info "Chave salva em ~/.env"
  fi
fi

# Exportar para sessão atual
if [ -f "$ENV_FILE" ]; then
  GEMINI_KEY=$(grep "^GEMINI_API_KEY=" "$ENV_FILE" | cut -d'=' -f2- | tr -d '"'"'" | tr -d '\r')
  [ -n "$GEMINI_KEY" ] && export GEMINI_API_KEY="$GEMINI_KEY"
fi

# Teste rápido da API
if [ -n "$GEMINI_API_KEY" ]; then
  echo "Testando Gemini API..."
  RESPONSE=$(python3 -c "
import google.generativeai as genai
import os
genai.configure(api_key=os.environ['GEMINI_API_KEY'])
model = genai.GenerativeModel('gemini-1.5-flash')
r = model.generate_content('Diga apenas: OK')
print(r.text.strip())
" 2>&1)
  if echo "$RESPONSE" | grep -qi "ok\|OK"; then
    info "Gemini API funcionando!"
  else
    warn "Teste Gemini retornou: $RESPONSE"
  fi
fi

# ─── ADC (Application Default Credentials) ───────────────────────────────────
section "APPLICATION DEFAULT CREDENTIALS (ADC)"

if [ -f "$HOME/.config/gcloud/application_default_credentials.json" ]; then
  info "ADC já configurado"
else
  warn "ADC não configurado. Para usar Gemini via Vertex AI / SDKs Google:"
  echo "  gcloud auth application-default login --no-browser"
fi

# ─── CLASP ───────────────────────────────────────────────────────────────────
section "CLASP (Google Apps Script)"

CLASP_CREDS="$HOME/.clasprc.json"
if [ -f "$CLASP_CREDS" ]; then
  info "Clasp já autenticado ($CLASP_CREDS)"
else
  warn "Clasp não autenticado."
  echo ""
  echo "Para autenticar o Clasp, execute:"
  echo "  clasp login --no-localhost"
  echo ""
  echo "Você receberá uma URL para autorizar no navegador."
  read -p "Pressione Enter após autenticar o Clasp..."
fi

# Verificar .clasp.json do projeto
CLASP_PROJECT="$HOME/SisAlmoxIBTEC/.clasp.json"
if [ -f "$CLASP_PROJECT" ]; then
  SCRIPT_ID=$(python3 -c "import json; d=json.load(open('$CLASP_PROJECT')); print(d.get('scriptId',''))" 2>/dev/null)
  info "SisAlmoxIBTEC scriptId: $SCRIPT_ID"
fi

# ─── RESUMO ──────────────────────────────────────────────────────────────────
section "RESUMO"

echo ""
echo "Ferramentas instaladas:"
printf "  %-20s %s\n" "gcloud" "$(gcloud version 2>/dev/null | head -1)"
printf "  %-20s %s\n" "clasp" "$(clasp --version 2>/dev/null)"
printf "  %-20s %s\n" "python3" "$(python3 --version 2>/dev/null)"
printf "  %-20s %s\n" "google-generativeai" "$(python3 -c 'import google.generativeai as g; print(g.__version__)' 2>/dev/null)"
echo ""
echo "Próximos passos manuais (requerem navegador):"
echo "  1. gcloud auth login --no-browser"
echo "  2. gcloud auth application-default login --no-browser"
echo "  3. clasp login --no-localhost"
echo "  4. Gere Gemini API Key em: https://aistudio.google.com/app/apikey"
echo ""
