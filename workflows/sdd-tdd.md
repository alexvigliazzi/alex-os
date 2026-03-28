# Workflow: SDD + TDD — Método Akita
# Spec Driven Development mesclado com Test Driven Development

## Quando usar
Invocar explicitamente com `/sdd-tdd` ou quando o usuário descreve
uma nova feature com critérios de aceitação claros.

**NUNCA ativar automaticamente.** Aguardar invocação explícita do usuário.

---

## ETAPA 1 — Pesquisa e PRD
**Objetivo:** Coletar contexto, mapear impacto, sem modificar nada.

**Comportamento do Claude:**
1. Apenas ler e buscar (modo Read-Only)
2. Identificar TODOS os arquivos que serão tocados
3. Listar dependências, APIs e documentações relevantes
4. Produzir um mini-PRD em `~/.claude/plans/[feature]-prd.md`

**Prompt para o usuário usar:**
```
Etapa 1 — SDD Pesquisa:
Preciso implementar [DESCRIÇÃO DA FEATURE].
Faça apenas leitura do codebase:
1. Mapeie todos os arquivos que serão tocados
2. Liste dependências e padrões existentes que devo seguir
3. Identifique riscos ou conflitos potenciais
4. Gere ~/.claude/plans/[feature]-prd.md com os achados
NÃO escreva nenhum código ainda.
```

**Saída esperada:** `~/.claude/plans/[feature]-prd.md`

---

## ETAPA 2 — Geração da Spec
**Objetivo:** Transformar o PRD em plano tático de ataque.

**Ação obrigatória antes:** Digitar `/clear` para limpar histórico de pesquisa.

**Comportamento do Claude:**
1. Ler APENAS o arquivo `[feature]-prd.md`
2. Gerar `~/.claude/plans/[feature]-spec.md` com:
   - Lista exata de arquivos a criar ou modificar
   - Assinaturas de função/método esperadas (com tipos)
   - Critérios de aceitação mensuráveis e verificáveis
   - Ordem de implementação recomendada

**Prompt para o usuário usar:**
```
/clear

Etapa 2 — SDD Spec:
Leia apenas ~/.claude/plans/[feature]-prd.md
Gere ~/.claude/plans/[feature]-spec.md com:
- Lista exata de arquivos a criar/modificar (caminhos absolutos)
- Assinaturas de função com tipos TypeScript/JSDoc
- Critérios de aceitação verificáveis (Given/When/Then)
- Ordem de implementação (quais arquivos primeiro)
NÃO escreva código de produção ainda.
```

**Saída esperada:** `~/.claude/plans/[feature]-spec.md`

---

## ETAPA 3 — TDD: Testes Primeiro (Método Akita)
**Objetivo:** Criar rede de segurança ANTES de tocar no código de produção.

**Ação obrigatória antes:** Digitar `/clear` novamente.

**Comportamento do Claude:**
1. Ler APENAS `[feature]-spec.md`
2. Escrever TODOS os testes baseados na especificação
3. Usar mocks para dependências externas (GAS, APIs, Supabase)
4. Os testes DEVEM falhar inicialmente (red phase) — isso é correto
5. NUNCA tocar no código de produção nesta etapa

**Stack de testes:**
- GAS: `clasp run` + `jest` com mocks
- Next.js/TypeScript: `jest` + `@testing-library/react`
- API routes: `supertest` ou mocks de fetch

**Prompt para o usuário usar:**
```
/clear

Etapa 3 — TDD Testes:
Leia apenas ~/.claude/plans/[feature]-spec.md
Escreva TODOS os testes para esta feature:
1. Testes unitários para cada função especificada
2. Mocks para dependências externas (GAS services, Supabase, APIs)
3. Testes de integração para os critérios de aceitação
4. Os testes devem estar na fase RED (falhando) — não implemente lógica ainda
NÃO toque em arquivos de produção.
```

**Saída esperada:** Arquivos de teste na estrutura do projeto, todos em estado RED.

---

## ETAPA 4 — Implementação (GREEN phase)
**Objetivo:** Implementar até todos os testes passarem.

**Ação:** NÃO limpar contexto — a IA precisa dos testes recentes em memória.

**Comportamento do Claude:**
1. Ler Spec + testes como guia
2. Implementar apenas o necessário para os testes passarem (sem over-engineering)
3. Ao encontrar erro: anotar no `~/.claude/memory/napkin.md`, corrigir, NÃO modificar testes
4. Executar testes ao final de cada arquivo implementado
5. Fase GREEN: todos os testes passando = feature completa

**Prompt para o usuário usar:**
```
Etapa 4 — TDD Implementação:
Com base em ~/.claude/plans/[feature]-spec.md e nos testes escritos:
1. Implemente os arquivos na ordem definida na Spec
2. Execute os testes após cada implementação
3. Se um teste falhar: identifique a causa, corrija o CÓDIGO (nunca o teste)
4. Registre qualquer padrão corrigido no napkin (~/.claude/memory/napkin.md)
5. Confirme quando todos os testes estiverem GREEN
```

**Saída esperada:** Testes passando + código implementado conforme Spec.

---

## Regras de ouro do Método Akita

1. **Nunca pule etapas** — cada /clear é intencional e obrigatório
2. **Testes são contratos** — nunca modifique um teste para ele passar; corrija o código
3. **Spec é a lei** — qualquer desvio da Spec exige aprovação explícita do usuário
4. **Napkin é memória** — todo erro encontrado na etapa 4 vai para o napkin.md
5. **Desapego do código** — se a IA errar, explique onde errou no prompt; ela mesma corrige

## Arquivos gerados por feature

```
~/.claude/plans/
  [feature]-prd.md      ← Etapa 1: Pesquisa e requisitos
  [feature]-spec.md     ← Etapa 2: Plano tático de implementação

[projeto]/tests/ ou __tests__/
  [feature].test.ts     ← Etapa 3: Testes (RED)
  [feature].spec.ts     ← (alternativo)

~/.claude/memory/
  napkin.md             ← Etapa 4: Erros e regras derivadas
```
