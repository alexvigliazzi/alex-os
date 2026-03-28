# Visao: Ollama como Motor Local de Contexto e Roteamento

**Status:** PLANEJAMENTO
**Data:** 2026-03-28
**Agente responsavel:** CTO
**Prioridade:** MEDIA (depende de Ollama estar online)

---

## Objetivo

Transformar o Ollama (modelos locais gratuitos) em uma camada de analise de contexto que trabalha em paralelo com o Boss, realizando tarefas de baixa complexidade (score <= 3) de forma autonoma, com validacao obrigatoria pelos especialistas antes de entrega ao usuario.

---

## Arquitetura Proposta

```
                    USUARIO
                       |
                     BOSS
                    /     \
           [score <= 3]  [score > 3]
               |              |
          OLLAMA LOCAL    CLAUDE API
          (gemma3:4b)    (sonnet/opus)
               |              |
          VALIDADOR       EXECUCAO
        (specialist)      DIRETA
               |
           ENTREGA
```

### Camada 1: Ollama como Assistente de Contexto

| Funcao | Modelo | Descricao |
|--------|--------|-----------|
| Resumo de contexto | gemma3:4b | Sumarizar session-state, PRDs, specs antes do Boss processar |
| Extracao de padroes | gemma3:4b | Identificar padroes em codigo, logs, outputs |
| Formatacao de dados | gemma3:4b | Converter, formatar, estruturar dados simples |
| Embeddings semanticos | nomic-embed-text | Busca semantica local (alternativa ao ciam quando offline) |
| Embeddings multilingual | bge-m3 | Embeddings PT-BR/EN para busca cross-idioma |

### Camada 2: Open Router (Multi-Provider Gateway)

**O que e:** Gateway unificado para acessar modelos de multiplos providers (OpenAI, Anthropic, Google, Mistral, etc.) via uma unica API.

| Aspecto | Detalhes |
|---------|---------|
| Endpoint | `https://openrouter.ai/api/v1/` |
| Autenticacao | API key unica |
| Beneficio | Fallback automatico entre providers; acesso a modelos especializados |
| Integracao | Via `ai-sdk` com provider `openrouter` |
| Seguranca | API key em `.env`, nunca em codigo; rate limiting; audit log |

**Casos de uso:**
- Fallback quando Claude API estiver indisponivel
- Acesso a modelos especializados (code-specific, vision, etc.)
- Comparacao de outputs entre providers para decisoes criticas

### Camada 3: OpenClaw (Ferramenta de Analise)

**O que e:** Framework de analise e comparacao de modelos/ferramentas de IA.

| Aspecto | Detalhes |
|---------|---------|
| Instalacao | `pip install openclaw` ou binario |
| Capacidades | Benchmark, comparacao, avaliacao de outputs |
| Integracao | CLI + possivel MCP server |
| Seguranca | Sandbox de execucao; sem acesso a credenciais do Alex-OS |

---

## Pipeline de Roteamento Expandido

```
MENSAGEM DO ALEX
      |
   BOSS analisa
      |
      +-- Score 0-1: OLLAMA DIRETO (gemma3:4b)
      |   -> Resumo, extracao, formatacao
      |   -> Resultado validado por Boss antes de entregar
      |
      +-- Score 2-3: OLLAMA + VALIDACAO
      |   -> Ollama executa
      |   -> Specialist (dev/reviewer) valida output
      |   -> Boss entrega resultado validado
      |
      +-- Score 4-8: CLAUDE SONNET
      |   -> Execucao direta via Claude API
      |   -> Fallback: Open Router se Claude indisponivel
      |
      +-- Score 9-10: CLAUDE OPUS
      |   -> Decisoes arquiteturais, cross-module
      |   -> Sem fallback (qualidade critica)
      |
      +-- OFFLINE (sem internet):
          -> Ollama para tudo score <= 5
          -> Queue para score > 5 (aguardar conexao)
```

---

## Requisitos de Seguranca

| Requisito | Implementacao |
|-----------|--------------|
| API keys isoladas | Cada provider em `.env` separado, nunca em codigo |
| Audit trail | Logar modelo usado, tokens consumidos, custo por tarefa |
| Sandbox de execucao | Ollama roda local, sem acesso a rede externa |
| Validacao de output | Outputs de modelos locais SEMPRE validados antes de entrega |
| Rate limiting | Respeitar limites por provider (60 req/min global) |
| Fallback seguro | Se provider falha, NÃO enviar dados para provider desconhecido |
| Encriptacao em transito | TLS obrigatorio para todas as chamadas API externas |
| Sem vazamento de contexto | Nao enviar system prompts ou rules para providers externos |

---

## Etapas de Implementacao

| # | Etapa | Dependencia | Status |
|---|-------|-------------|--------|
| 1 | Ollama online e estavel | Docker ou servico nativo | PENDENTE |
| 2 | Script de health check Ollama | Etapa 1 | EXISTENTE (hooks/ollama-check.sh) |
| 3 | Roteamento Boss -> Ollama para score <= 3 | Etapa 1 + model-router skill | PARCIAL |
| 4 | Validacao de output por specialist | Etapa 3 | PLANEJADO |
| 5 | Open Router como fallback | API key configurada | PLANEJADO |
| 6 | OpenClaw para benchmark/comparacao | Instalacao + sandbox | PLANEJADO |
| 7 | Dashboard de custo/uso por sessao | Audit trail | PLANEJADO |

---

## Proximos Passos Concretos

1. **Garantir Ollama estavel** — verificar se `ollama serve` esta configurado como servico Windows
2. **Implementar roteamento real** — Boss despacha para Ollama via `curl` quando score <= 3
3. **Criar MCP server para Ollama** — integrar como tool nativa do Claude Code
4. **Configurar Open Router** — obter API key, adicionar ao `.env`, criar provider no model-router
5. **Avaliar OpenClaw** — instalar, testar, decidir se agrega valor real
