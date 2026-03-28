# Token Economy & Compression Rules

Strict budget allocation. Cache hierarchy. Memory TTLs. Strategic compression.

## Budget Allocation

| Bucket | Token Budget | Purpose |
|--------|-------------|---------|
| Memories (persistent) | 20% (~40k tokens) | Decisions, patterns, preferences, learned patterns |
| Code context (current) | 80% (~160k tokens) | File content, analysis, generated code, test plans |

**Rule:** Load only required files via INDEX.md routing. Avoid full-directory loads.

## Compression Strategy Selection

| Strategy | Compression Rate | Best For | Triggers |
|----------|-----------------|----------|----------|
| Code structure | 70-90% | Boilerplate, repetitive patterns, scaffolding | >500 lines, <5% unique logic |
| Conversation summary | 80-95% | Chat history, decision log, requirements | >10 turns, >50k tokens |
| Semantic dedup | 50-70% | Redundant explanations, repeated examples | Multiple similar documents |
| Hierarchical outline | 60-80% | Large specs, design docs, runbooks | >200 lines, nested sections |
| TOON format | 70-98% | Ultra-compact serialization | Emergency (near context limit) |

**Selection rule:** Use highest-compression strategy that preserves required semantics. Default to 70-80% compression.

## Cache Hierarchy

| Layer | Capacity | TTL | Medium | Access Pattern |
|-------|----------|-----|--------|-----------------|
| L1 | 100MB | 5 min | Memory | Hot: current session analysis |
| L2 | 500MB | 1 hr | SQLite | Warm: recent files, decision log |
| L3 | ∞ | 7d | Remote (INDEX.md) | Cold: source of truth routing |

**Load rule:** L1 → miss → check L2 → miss → fetch from L3 via INDEX.md.

## Memory TTLs

| Memory Type | TTL | Refresh Rule |
|-------------|-----|--------------|
| Decision (critical choices) | 7 days | Re-validate if context changes >30% |
| Pattern (code patterns, naming) | 30 days | Update on new codebase scan |
| Preference (style, format) | 24 hours | Re-confirm per project |
| Code (file paths, function sigs) | 1 hour | Refresh before write ops |
| Conversation (chat history) | 5 minutes | Reset on new conversation turn |

## Global Rate Limits

| Limit | Threshold | Escalation |
|-------|-----------|------------|
| Requests/min | 60 req/min | Queue excess; alert on sustained >50 req/min |
| Tokens/min | 100k tokens/min | Compress context; escalate to user if blocking |
| File operations/session | 50 ops | Batch writes; reduce frequency |
| Search queries/minute | 10 queries/min | Cache results; reuse within TTL |

## File Loading Rules

1. **Load INDEX.md first** – Discover routing table, architecture, file locations
2. **Lazy load only needed** – Use Glob/Grep to locate, then Read specific files
3. **Avoid full-directory reads** – File counts >100 = use search tools
4. **Batch reads in parallel** – Multiple independent files = same function_calls block
5. **Respect file size limits** – >10MB = request permission; chunk or summarize
6. **Cache read results** – Same file in 5min window = reuse L1 memory

## Model Selection Rules

Route subagent tasks to **free local** first, **Anthropic API** for everything else.
**Always check Ollama first** — local models cost nothing.

| Model | Cost | Use When |
|-------|------|----------|
| **ollama:gemma3:4b** | $0 (free local) | Summarization, extraction, formatting, Q&A (score ≤ 3) |
| **ollama:nomic-embed-text:latest** | $0 (free local) | Semantic embeddings (768 dims) for search |
| **ollama:bge-m3:latest** | $0 (free local) | Alternative embeddings, multilingual |
| **haiku** | 1x | Cheap fallback when local fails or score ≤ 3 offline |
| **sonnet** | 10x | Standard: implementation, analysis, code review (score 4–8) |
| **opus** | 30x | Critical: architecture, complex reasoning (score 9–10) |

**Scoring criteria** (evaluate before spawning subagent):

| Signal | +Local | +Haiku | +Sonnet | +Opus |
|--------|--------|---------|---------|-------|
| Files touched | read ≤3 | read ≤3 | read/write ≤10 | >10 cross-module |
| Decision weight | informational | reversible | moderate | architectural |
| Reasoning depth | extract/format | lookup | analyze/implement | design/tradeoffs |
| Error tolerance | best-effort | retry-safe | needs accuracy | must be correct |
| Output size | <5k tokens | <20k tokens | <80k tokens | unlimited |

**Routing flow (simple):**
1. **Check Ollama** — `curl -s http://172.26.48.1:11434/api/tags`
2. **Score ≤ 3 + Ollama up** → `ollama:gemma3:4b` (FREE)
3. **Score ≤ 3 + Ollama down** → `haiku` (cheap fallback)
4. **Score 4–8** → `sonnet` (Anthropic API)
5. **Score 9–10** → `opus` (Anthropic API)
6. User override always takes precedence

**Ollama endpoint:** `http://localhost:11434` (Git Bash / Windows nativo) — `http://172.26.48.1:11434` somente de dentro do WSL
**Ollama check:** `curl -s http://localhost:11434/api/tags | grep -q "name" && echo "up" || echo "down"`

**Reality:** Local model is LIMITED. Only use for simple tasks. For anything complex, use Claude API.

**Cost tracking:** Log model used per subagent in session digest for post-session analysis.

## Token Optimization Checklist

- [ ] Ollama checked? (`curl -s http://localhost:11434/api/tags`)
- [ ] Task score ≤ 3 + Ollama up → routed to local `gemma3:4b` (FREE)?
- [ ] INDEX.md consulted for routing?
- [ ] Only required files loaded?
- [ ] Parallel reads batched together?
- [ ] Large files (>2MB) summarized or chunked?
- [ ] Compression strategy selected for context >80k tokens?
- [ ] TTL checked before using cached data?
- [ ] Rate limits respected (60 req/min, 100k tok/min)?
