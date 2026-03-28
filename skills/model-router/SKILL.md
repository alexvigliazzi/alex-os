---
name: model-router
description: >
  Adaptive model selection for subagent tasks. Routes to free local Ollama
  (gemma3:4b) for simple tasks or Anthropic API (haiku/sonnet/opus) for
  everything else. Use this skill whenever spawning subagents, delegating
  tasks, or when the user asks about model selection, cost optimization,
  or which model to use.
---

> **Idioma:** Responder SEMPRE em Português-BR. Processar internamente em inglês. Ver `rules/language.md`.

# Model Router — Simplified (Local FREE only)

Routes every subagent task to **free local** or **Anthropic API**.
Goal: maximize free local usage, fallback to Claude API when needed.

---

## Model Tiers (Only 2)

### Tier 0 — Local FREE (Ollama on Windows)

| Model | Size | Best For |
|-------|------|----------|
| `ollama:gemma3:4b` | ~3GB | Summarization, extraction, formatting, Q&A (simple tasks) |
| `ollama:nomic-embed-text:latest` | ~274MB | Semantic embeddings (768 dims) for seshat/th0th search |
| `ollama:bge-m3:latest` | ~1.2GB | Alternative embeddings, multilingual support |

**Constraint:** These are the ONLY free models. They cannot handle complex reasoning, multi-step implementation, or architectural decisions. Accept this limitation.

### Tier 1 — Anthropic API (pay-per-token)

| Model | Cost | Best For |
|-------|------|----------|
| `claude-haiku-4-5` | 1x | Light analysis, fallback for complex extractions |
| `claude-sonnet-4-6` | 10x | Standard: implementation, analysis, code review, tool use |
| `claude-opus-4-6` | 30x | Critical: architecture, complex reasoning, final validation |

---

## Availability Check

**Always run before routing:**
```bash
# Host IP: 172.26.48.1 (from ollama-host.env)
OLLAMA_HOST=$(grep OLLAMA_HOST ~/.claude/references/ollama-host.env 2>/dev/null | cut -d= -f2 || echo "172.26.48.1:11434")
curl -s --connect-timeout 2 http://$OLLAMA_HOST/api/tags | grep -q "name" && echo "up" || echo "down"
```

If `up` → **try local first**, then fall back to API.
If `down` → **use Anthropic API directly**.

---

## Scoring & Routing

Score each task on 5 dimensions (0–2 each, max 10):

| Dimension | 0 pts | 1 pt | 2 pts |
|-----------|-------|------|-------|
| **Scope** | Read ≤3 files | Read/write ≤10 files | Cross-module, >10 files |
| **Decision weight** | Informational | Creates artifacts | Architectural |
| **Reasoning depth** | Extract/format | Analyze/summarize | Design/tradeoffs |
| **Precision** | Best-effort | Should work | Must be correct |
| **Output size** | <5k tokens | 5–30k tokens | >30k tokens |

### Routing Decision

| Score | Ollama up? | Route |
|-------|------------|-------|
| 0–3 | Yes | **gemma3:4b** (FREE) |
| 0–3 | No | **haiku** (cheap fallback) |
| 4+ | Any | **sonnet** or **opus** (by complexity) |

**Critical rule:** If task score > 3, **always use Claude API** — never force local model beyond its limits.

---

## Task → Model Quick Reference

| Task | Score | Local? | Model to Use |
|------|-------|--------|--------------|
| Summarize document | 1 | Yes | `gemma3:4b` ✅ |
| Extract patterns from code | 1 | Yes | `gemma3:4b` ✅ |
| Format / convert data | 2 | Yes | `gemma3:4b` ✅ |
| Generate embeddings | 0 | Yes | `nomic-embed-text:latest` ✅ |
| Answer Q&A | 2 | Yes | `gemma3:4b` ✅ |
| Write boilerplate | 3 | Maybe* | See decision below |
| Code review | 5 | No | `sonnet` (Claude) |
| Write implementation | 5 | No | `sonnet` (Claude) |
| Write tests | 5 | No | `sonnet` (Claude) |
| Multi-file refactoring | 7 | No | `sonnet` (Claude) |
| System architecture | 9 | No | `opus` (Claude) |

**Maybe* (score 3):** Try local `gemma3:4b` first. If output is weak, immediately fall back to `haiku`.

---

## Usage Examples

### Example 1: Simple summarization (score 1)
```typescript
import { ollama } from 'ollama-ai-provider'

const summary = await generateText({
  model: ollama('gemma3:4b'),  // FREE
  prompt: `Summarize: ${longText}`,
})
```

### Example 2: Embeddings (score 0)
```typescript
import { ollama } from 'ollama-ai-provider'

const embedding = await embed({
  model: ollama.embedding('nomic-embed-text:latest'),  // FREE
  value: text,
})
```

### Example 3: Code implementation (score 5+)
```typescript
import { createAnthropic } from '@ai-sdk/anthropic'

const model = createAnthropic().textModel('claude-sonnet-4-6')
const code = await generateText({
  model,  // PAY-PER-TOKEN
  prompt: `Implement: ${spec}`,
})
```

### Example 4: Fallback pattern
```typescript
import { ollama } from 'ollama-ai-provider'
import { createAnthropic } from '@ai-sdk/anthropic'

async function smartRoute(score: number, prompt: string) {
  if (score <= 3 && ollamaIsAvailable()) {
    try {
      // Try free local first
      return await generateText({
        model: ollama('gemma3:4b'),
        prompt,
      })
    } catch (e) {
      console.warn('Local model failed, using Claude')
      // Fall back to API
    }
  }
  // Use Claude for anything > score 3 or if local failed
  return await generateText({
    model: createAnthropic().textModel('claude-sonnet-4-6'),
    prompt,
  })
}
```

---

## Override Rules

| Condition | Action |
|-----------|--------|
| User requests specific model | Use that model, no routing |
| Task needs tool use / artifacts | Minimum `sonnet` (local can't do this) |
| Direct user-facing artifact | Minimum `sonnet` (quality guarantee) |
| "Economize" / budget mode | Score ≤ 3 → try local first |
| "Do your best" / quality mode | Score ≥ 5 → use `sonnet` minimum |
| Ollama offline | Use Anthropic API per score |

---

## Cost Tracking

Log per subagent in session digest:
```yaml
subagent_log:
  - task: "Summarize references"
    model: ollama:gemma3:4b
    cost: $0

  - task: "Write auth module"
    model: claude-sonnet-4-6
    tokens: 15000
    cost: ~$0.0045
```

---

## Reality Check

**What gemma3:4b can do (free):**
- Summarize text
- Extract information
- Format/convert simple data
- Answer straightforward questions

**What gemma3:4b CANNOT do:**
- Multi-step reasoning
- Complex code generation
- Architectural design
- Tool use / dynamic execution
- Handle ambiguous or novel problems

**When in doubt, use Claude.** The free local model is limited—accept it and don't force tasks beyond its capability.

---

## References
- `rules/token-economy.md` — budget rules and rate limits
- `references/ollama-setup.md` — installation and integration
- `references/ollama-host.env` — Ollama host IP configuration
