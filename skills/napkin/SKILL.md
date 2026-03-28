---
name: napkin
description: Error memory and daily notes log. Appends Bash errors and quick notes to napkin.md for session review.
---

# Skill: Napkin — Memória de Erros do Dia

> **Idioma:** Responder SEMPRE em Português-BR. Processar internamente em inglês. Ver `rules/language.md`.

## Propósito
Registrar erros cometidos e corrigidos durante a sessão para evitar repetição
em sessões futuras. Funciona como um "guardanapo" de anotações rápidas.

## Arquivo de memória
`~/.claude/memory/napkin.md`

## Quando ativar
- Após qualquer correção de bug ou erro de implementação
- Quando a IA cometer uma alucinação e for corrigida
- Quando um padrão incorreto for identificado e substituído

## Comportamento obrigatório

### Ao CORRIGIR qualquer erro:
1. Abrir `~/.claude/memory/napkin.md`
2. Registrar no formato abaixo
3. Confirmar ao usuário que o registro foi feito

### Ao INICIAR nova sessão:
1. Carregar `~/.claude/memory/napkin.md` como contexto de "erros recentes"
2. Mencionar brevemente os últimos 3 registros se relevantes para a tarefa atual

### Ao DETECTAR padrão repetido:
1. Alertar: "Este erro já foi registrado no Napkin em [DATA]. Regra: [REGRA]"
2. Aplicar a regra preventivamente

## Formato de entrada no napkin.md

```
## [AAAA-MM-DD HH:MM] — [ARQUIVO/MÓDULO]
**Stack:** [GAS | Next.js | TypeScript | outro]
**Erro:** [descrição do erro cometido]
**Correção:** [o que foi feito para corrigir]
**Regra:** Sempre que [contexto/trigger], [ação preventiva]
```

## Regras de manutenção
- Máximo 30 entradas (apagar as mais antigas ao atingir limite)
- Não registrar erros triviais de sintaxe (typos sem padrão)
- Priorizar erros arquiteturais, de importação ou de contrato de API
- Tags obrigatórias: stack afetada + arquivo afetado

## Exemplo de entrada válida

```
## 2026-03-24 14:30 — Code.gs / almoxarifado
**Stack:** GAS
**Erro:** Tentou usar `console.log` em GAS — não existe neste ambiente
**Correção:** Substituído por `Logger.log` e `console.log` removido
**Regra:** Sempre que escrever logs em GAS, usar `Logger.log()`, nunca `console.log()`
```
