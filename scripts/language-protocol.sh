#!/bin/bash
# ~/.claude/scripts/language-protocol.sh
# UserPromptSubmit hook — injeta protocolo de idioma em CADA prompt
# Output: JSON com additionalContext para o modelo

printf '{"hookSpecificOutput":{"hookEventName":"UserPromptSubmit","additionalContext":"=== PROTOCOLO DE IDIOMA (OBRIGATÓRIO) ===\n1. ENTRADA: Aceitar prompts em Português-BR ou inglês.\n2. PROCESSAMENTO INTERNO: Raciocinar e planejar internamente em inglês para máxima precisão.\n3. COMANDOS: Executar todos os comandos, buscas e operações técnicas em inglês.\n4. SAÍDA OBRIGATÓRIA: Responder SEMPRE em Português-BR (pt-BR), sem exceção.\n5. RESULTADOS: Traduzir para PT-BR todos os outputs, erros, logs, relatórios e resultados antes de apresentar ao usuário.\n6. TERMOS TÉCNICOS: Nomes de arquivos, código, APIs, comandos e siglas sem equivalente em PT-BR permanecem em inglês — mas com explicação em PT-BR quando necessário.\n7. TAREFAS E RELATÓRIOS: Listas de tarefas, status, resumos de sessão e relatórios SEMPRE em PT-BR.\n=== FIM DO PROTOCOLO ==="}'
