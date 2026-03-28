# Ollama — Status Final & Próximos Passos

Data: 2026-03-18
Estado: ✅ **OPERACIONAL**

---

## O que foi feito

### 1. Instalação & Validação
- ✅ Ollama instalado no Windows (host)
- ✅ Acessível da VM em `172.26.48.1:11434`
- ✅ Testado: gemma3:4b responde, embeddings funcionam

### 2. Configuração arquivos .claude
- ✅ `model-router/SKILL.md` — roteamento automático (2 tiers: local FREE + Anthropic API)
- ✅ `rules/token-economy.md` — regras de custo atualizadas
- ✅ `references/ollama-setup.md` — guia de integração
- ✅ `references/ollama-host.env` — IP do host salvo

### 3. Modelos locais grátis APENAS
```
GRÁTIS (rodam no Windows):
- gemma3:4b           → Tarefas simples (score ≤ 3)
- nomic-embed-text    → Embeddings (768 dims)
- bge-m3              → Embeddings alternativo

NÃO USE (requerem autenticação/custo):
- gpt-oss:*-cloud
- deepseek-v3.1:*-cloud
- qwen3-coder:*-cloud
- kimi-k2-thinking:cloud
```

---

## Roteamento automático ativado

Agora que você sabe o que é REALMENTE grátis:

**Quando agents/skills rodam:**
1. ✅ Score ≤ 3 + Ollama disponível → `gemma3:4b` ($0)
2. ✅ Score ≤ 3 + Ollama offline → `haiku` (~$0.00005/1k tokens)
3. ✅ Score 4-8 → `sonnet` (~$0.003/1k tokens)
4. ✅ Score 9-10 → `opus` (~$0.015/1k tokens)

---

## Próximas ações (você)

### 1. Verificar se gemma3 sempre roda bem
```powershell
# No Windows
ollama run gemma3:4b "Diga em uma frase: você está funcionando?"
```

Se responder bem → tudo OK.
Se lentidão/crash → aumentar RAM ou usar apenas Claude API.

### 2. (Opcional) Instalar modelo local maior se tiver 8GB+ RAM
```powershell
# Para tarefas um pouco mais complexas (score 3-4)
ollama pull mistral:7b    # ~4.1GB

# Depois atualizar model-router com este modelo também
```

### 3. Monitorar custos do primeiro subagent
Depois que agents começarem a rodar:
```bash
grep "subagent_log:" ~/.claude/sessions/*.yaml
```

Verificar quantos rodam "free" vs "pagos".

---

## Referência rápida

| Situação | Ação |
|----------|------|
| Precisa sumarizar doc | Use `gemma3:4b` direto |
| Precisa código funcional | Use `sonnet` |
| Precisa decisão crítica | Use `opus` |
| Ollama caiu | Fallback automático para `haiku` |

---

## Se algo der errado

**Ollama offline?**
```bash
# No Windows, reiniciar:
Stop-Process -Name "ollama" -Force
Start-Process "ollama" -ArgumentList "serve" -WindowStyle Hidden
```

**IP mudou após reboot?**
```powershell
# Encontrar novo IP
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -like "172.*" }).IPAddress

# Atualizar ollama-host.env em .claude/references/
```

**Model lento ou crashes?**
- Reduzir tamanho de contexto
- Usar `haiku` em vez de `gemma3:4b`
- Considerar upgrade de RAM no Windows

---

## Economia esperada

**Cenário 1:** Rodam 10 tarefas simples/dia, todas via `gemma3:4b`
- Economia: ~$0.20/dia × 30 = **$6/mês** (vs sonnet)

**Cenário 2:** 5 simples (local) + 5 complexas (sonnet)/dia
- Economia: ~$0.10/dia × 30 = **$3/mês**

**Cenário 3:** Sem Ollama, tudo via API
- Custo: ~$0.30/dia × 30 = **$9/mês**

---

## Documentação completa

- `skills/model-router/SKILL.md` — Como funciona o roteamento
- `rules/token-economy.md` — Regras de orçamento e modelo selection
- `references/ollama-setup.md` — Integração com SisIBTEC
- `references/ollama-host.env` — Configuração do host

