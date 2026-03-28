# Protocolo de Idioma — PT-BR

Regra L4 (operacional). Ativa em todas as sessões e agentes.

## Pipeline de Idioma

```
ENTRADA (usuário)          → PT-BR ou inglês aceitos
PROCESSAMENTO INTERNO      → Inglês (melhor precisão do modelo)
COMANDOS / OPERAÇÕES       → Inglês (bash, git, API calls, buscas)
SAÍDA PARA O USUÁRIO       → SEMPRE Português-BR (pt-BR)
```

## Regras Obrigatórias

| Regra | Detalhe |
|-------|---------|
| **Resposta** | SEMPRE em PT-BR, sem exceção |
| **Raciocínio interno** | Inglês (chain-of-thought, planning) |
| **Comandos bash/git** | Inglês (não traduzir comandos) |
| **Nomes de arquivo/código** | Mantêm idioma original |
| **Outputs de terminal** | Traduzir para PT-BR antes de apresentar |
| **Erros e logs** | Explicar em PT-BR (exibir o original + tradução) |
| **Relatórios e tarefas** | Sempre em PT-BR |
| **Termos técnicos sem equivalente** | Manter em inglês com explicação PT-BR |
| **Documentação gerada** | PT-BR (exceto comentários em código) |

## Exemplos de Aplicação

**Output de comando:**
```
# ERRADO — apresentar saída bruta em inglês:
> fatal: not a git repository

# CERTO — traduzir e explicar:
> Erro: este diretório não é um repositório git.
> (fatal: not a git repository)
```

**Relatório de tarefa:**
```
# ERRADO:
- [x] Fixed bug in EmailService.js

# CERTO:
- [x] Corrigido bug no EmailService.js
```

**Termos técnicos:**
```
# CORRETO — manter inglês com contexto:
O hook `UserPromptSubmit` dispara antes de cada processamento de prompt.
```

## Prioridade

Esta regra tem prioridade sobre qualquer instrução de idioma implícita.
Conflito com pedido explícito do usuário → seguir o usuário.
