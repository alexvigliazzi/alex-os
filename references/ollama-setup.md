# Ollama — Setup & Integração (LOCAL GRÁTIS ONLY)

Guia de instalação no Windows e uso de modelos locais grátis com o .claude.

---

## Status Atual

✅ **Ollama instalado no Windows**
✅ **Host IP:** `172.26.48.1:11434` (acessível da VM)
✅ **Modelos locais grátis instalados:**
- `gemma3:4b` — LLM local para tarefas simples
- `nomic-embed-text:latest` — embeddings (768 dims)
- `bge-m3:latest` — embeddings alternativos

⚠️ **Modelos "cloud"** (`gpt-oss:*-cloud`, `deepseek:*-cloud`, etc.) **requerem API/autenticação** — não são realmente grátis. Ignore-os.

---

## 1. Verificar instalação

```powershell
# Testar se Ollama está respondendo
curl http://localhost:11434/v1/chat/completions `
  -H "Content-Type: application/json" `
  -d '{"model":"gemma3:4b","messages":[{"role":"user","content":"ping"}]}'

# Listar modelos locais disponíveis
ollama list
```

---

## 2. Modelos locais (GRÁTIS, sem custo)

Você já tem estes instalados:

| Modelo | Tamanho | Uso |
|--------|---------|-----|
| `gemma3:4b` | ~3GB | Sumarização, extração, formatação, Q&A simples |
| `nomic-embed-text:latest` | ~274MB | Embeddings semânticas (768 dims) |
| `bge-m3:latest` | ~1.2GB | Embeddings alternativos, multilíngue |

**Use apenas estes para zero custo.**

---

## 3. Integração no SisIBTEC (Next.js)

O pacote `ollama-ai-provider` já está no cache bun.

### Instalação
```bash
cd repoScripts/sis_ibtec
bun add ollama-ai-provider
```

### Uso com Vercel AI SDK
```typescript
// src/lib/ai/models.ts
import { ollama } from 'ollama-ai-provider'

export const ollamaModels = {
  local: ollama('gemma3:4b'),           // FREE local
  embed: ollama.embedding('nomic-embed-text:latest'),  // FREE
  embed2: ollama.embedding('bge-m3:latest'),  // FREE
}
```

### Exemplo: Sumarização grátis
```typescript
import { generateText } from 'ai'
import { ollamaModels } from '@/lib/ai/models'

export async function summarizeDocument(content: string): Promise<string> {
  const { text } = await generateText({
    model: ollamaModels.local,  // $0 — roda localmente
    prompt: `Summarize concisely:\n\n${content}`,
  })
  return text
}
```

### Exemplo: Embeddings grátis
```typescript
import { embed } from 'ai'
import { ollamaModels } from '@/lib/ai/models'

export async function generateEmbedding(text: string): Promise<number[]> {
  const { embedding } = await embed({
    model: ollamaModels.embed,
    value: text,
  })
  return embedding
}
```

---

## 4. Integração nos Agents (.claude)

O `model-router` SKILL.md agora verifica Ollama antes de gastar tokens:

```bash
# Verificar disponibilidade (use em hooks ou scripts)
curl -s http://172.26.48.1:11434/api/tags | grep -q "name" && echo "Ollama UP" || echo "Ollama DOWN"
```

**Roteamento automático:**
- Score ≤ 3 + Ollama UP → `gemma3:4b` (FREE)
- Score ≤ 3 + Ollama DOWN → `haiku` (cheap fallback)
- Score > 3 → `sonnet` ou `opus` (Anthropic API)

---

## 5. Limitações de gemma3:4b (importante!)

**Pode fazer:**
- Sumarizar documentos ✅
- Extrair informações ✅
- Formatar dados ✅
- Responder perguntas simples ✅

**NÃO pode fazer:**
- Multi-step reasoning ❌
- Gerar código complexo ❌
- Revisar código ❌
- Tomar decisões arquiteturais ❌
- Usar ferramentas dinâmicas ❌

**Regra:** Se o modelo local falhar ou a tarefa for > score 3, use Claude API imediatamente. Não force.

---

## 6. Endereço Ollama

**Host IP:** `172.26.48.1:11434`

⚠️ Este IP pode mudar após reboot. Se falhar:
```powershell
# No Windows PowerShell
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.IPAddress -like "172.*" }).IPAddress
```

Depois atualize `ollama-host.env`:
```
OLLAMA_HOST=<novo-ip>:11434
```

---

## 7. Verificação rápida

```bash
# Test 1: Modelo responde?
curl -s http://172.26.48.1:11434/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"gemma3:4b","messages":[{"role":"user","content":"oi"}],"max_tokens":20}' \
  | jq '.choices[0].message.content'

# Test 2: Embeddings funcionam?
curl -s http://172.26.48.1:11434/api/embeddings \
  -d '{"model":"nomic-embed-text:latest","prompt":"teste"}' \
  | jq '.embedding | length'  # Deve retornar 768
```

---

## 8. Resumo: Como economizar tokens

| Tarefa | Modelo | Custo |
|--------|--------|-------|
| Sumarizar | `gemma3:4b` | **$0** ✅ |
| Extrair padrões | `gemma3:4b` | **$0** ✅ |
| Embeddings | `nomic-embed-text` | **$0** ✅ |
| Análise complexa | `claude-sonnet` | ~$0.003 |
| Implementação | `claude-sonnet` | ~$0.01 |
| Arquitetura | `claude-opus` | ~$0.03+ |

**Máximo possível de economia:** Use `gemma3:4b` para TODAS as tarefas simples (score ≤ 3). Cai direto em Claude API para o resto.
