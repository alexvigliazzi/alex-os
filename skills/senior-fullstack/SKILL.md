---
name: senior-fullstack
description: Senior full-stack development patterns for SisAlmoxIBTEC (GAS/Clasp) and SisIBTEC (Next.js/Prisma/Supabase). Use for implementation, architecture, and code review in these projects.
---

# Skill: Senior Full Stack — SisAlmoxIBTEC + SisIBTEC

> **Idioma:** Responder SEMPRE em Português-BR. Processar internamente em inglês. Ver `rules/language.md`.

## Stack primário
- **Back-end**: Google Apps Script (GAS) + Clasp
- **Front-end de referência**: Next.js 16 + TypeScript 5.9 + Prisma 6
- **Banco**: Supabase (Postgres)
- **Monorepo**: pnpm 10

## Princípios obrigatórios (não negociáveis)

### 1. Search-before-code
Antes de criar qualquer função ou arquivo:
- Buscar no codebase se já existe implementação similar (`Grep` first)
- Verificar `INDEX.md` do projeto para entender a arquitetura
- Nunca duplicar lógica existente

### 2. Clean Architecture
Separação obrigatória de camadas:
- `domain/` — entidades, interfaces, regras de negócio puras
- `application/` — casos de uso, orquestração
- `infrastructure/` — GAS services, Supabase, external APIs
- Dependências sempre apontam para dentro (domain não importa infra)

### 3. Tipagem TypeScript estrita
```typescript
// tsconfig obrigatório: strict: true
// NUNCA:
const x: any = foo()
function bar(data) { ... }  // sem tipo
// SEMPRE:
const x: MinhaInterface = foo()
function bar(data: RequestPayload): ResponseDTO { ... }
```

### 4. GAS — Padrões específicos
```javascript
// NUNCA hardcode de config — sempre PropertiesService:
const API_URL = PropertiesService.getScriptProperties().getProperty('API_URL')

// Logger em vez de console:
Logger.log('mensagem')  // não console.log

// Sempre verificar existência antes de criar planilha/aba:
const ss = SpreadsheetApp.getActiveSpreadsheet()
let sheet = ss.getSheetByName('Dados') ?? ss.insertSheet('Dados')

// Cache para operações repetidas (evitar quota):
const cache = CacheService.getScriptCache()
```

### 5. Tratamento de erros explícito
```typescript
// NUNCA silent failures:
try { doSomething() } catch (e) {} // PROIBIDO

// SEMPRE:
try {
  doSomething()
} catch (error) {
  const msg = error instanceof Error ? error.message : String(error)
  Logger.log(`[ERRO] contexto: ${msg}`)
  throw new Error(`Falha em contexto: ${msg}`)
}
```

### 6. Nomenclatura
- Funções e variáveis: `camelCase` em inglês
- Comentários explicativos: português
- Arquivos: `kebab-case.ts` ou `PascalCase.ts` (componentes React)
- Constantes: `UPPER_SNAKE_CASE`

### 7. Commits e histórico
- Mensagem de commit em inglês, imperativo: `fix:`, `feat:`, `refactor:`
- Nunca commitar `.clasp.json` com credenciais
- Sempre backup antes de `clasp push` em produção

## Checklist antes de qualquer implementação
- [ ] Busquei código existente com Grep?
- [ ] Identifiquei a camada correta (domain/application/infra)?
- [ ] Tipagem estrita aplicada?
- [ ] Tratamento de erro explícito presente?
- [ ] Nenhum hardcode de configuração?
- [ ] Testes ou validação manual planejados?
