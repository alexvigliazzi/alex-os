---
name: uiux-promax
description: Professional UI/UX design patterns and quality standards. Use for interface design, component review, and UX decisions in SisIBTEC and other projects.
---

# Skill: UI/UX Pro Max — Interface de Qualidade Profissional

> **Idioma:** Responder SEMPRE em Português-BR. Processar internamente em inglês. Ver `rules/language.md`.

## Objetivo
Garantir que qualquer trabalho de front-end entregue pelo Claude tenha
hierarquia visual real, acessibilidade, Dark Mode e microinterações —
não apenas "um layout genérico que funciona".

## Stack suportada
- Tailwind CSS (preferido) ou CSS Modules
- Next.js / React com TypeScript
- shadcn/ui como base de componentes (quando disponível)

## Regras obrigatórias

### 1. Design Tokens — Nunca hardcode de cores
```typescript
// PROIBIDO:
<div style={{ color: '#1a1a1a', background: '#ffffff' }}>

// CORRETO (Tailwind):
<div className="text-foreground bg-background">

// CORRETO (CSS Variables):
:root { --color-primary: #2563eb; }
.component { color: var(--color-primary); }
```

### 2. Dark Mode obrigatório
```typescript
// Tailwind: prefixo dark: em TODOS os elementos com cor
<div className="bg-white dark:bg-zinc-900 text-gray-900 dark:text-gray-100">

// Next.js: usar next-themes ou classe 'dark' no <html>
```

### 3. Hierarquia visual aplicada
Toda tela deve ter estrutura clara:
- **Heading principal** (H1): peso 700+, tamanho ≥ 2rem
- **Subtítulos** (H2/H3): peso 600, tamanho decrescente
- **Corpo**: peso 400, line-height 1.5–1.75
- **Labels/captions**: peso 500, tamanho menor, cor muted
- **Espaçamento**: múltiplos de 4px (sistema 4pt grid)

```typescript
// Exemplo de hierarquia Tailwind:
<h1 className="text-3xl font-bold tracking-tight">Título</h1>
<h2 className="text-xl font-semibold text-muted-foreground">Subtítulo</h2>
<p className="text-base leading-relaxed">Corpo do texto</p>
```

### 4. Mobile-first obrigatório
```typescript
// Sempre partir do menor breakpoint:
<div className="flex flex-col gap-4 md:flex-row md:gap-6 lg:gap-8">
// sm: ≥640px  md: ≥768px  lg: ≥1024px  xl: ≥1280px
```

### 5. Microinterações e feedback visual
Todo elemento interativo deve ter estado explícito:

```typescript
// Botão — estados: default, hover, focus, disabled, loading
<button className="
  px-4 py-2 rounded-md font-medium transition-all duration-200
  bg-primary text-primary-foreground
  hover:bg-primary/90
  focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring
  disabled:opacity-50 disabled:cursor-not-allowed
  active:scale-[0.98]
">

// Loading state:
{isLoading ? <Spinner className="h-4 w-4 animate-spin" /> : 'Salvar'}
```

### 6. Acessibilidade mínima (WCAG AA)
```typescript
// Contraste mínimo: 4.5:1 para texto normal, 3:1 para texto grande
// Sempre:
<button aria-label="Fechar modal" onClick={onClose}>
  <X className="h-4 w-4" aria-hidden="true" />
</button>

<input
  id="email"
  aria-describedby="email-error"
  aria-invalid={!!error}
/>
<span id="email-error" role="alert">{error}</span>

// Nunca remover outline de focus — só estilizar:
// focus:outline-none  (PROIBIDO sem substituto)
// focus-visible:ring-2  (CORRETO)
```

### 7. Skeleton loading em vez de spinners globais
```typescript
// Preferir skeleton para conteúdo previsível:
{isLoading ? (
  <div className="space-y-2">
    <div className="h-4 bg-muted animate-pulse rounded w-3/4" />
    <div className="h-4 bg-muted animate-pulse rounded w-1/2" />
  </div>
) : <Content />}
```

## Checklist de entrega
- [ ] Dark Mode implementado e testado?
- [ ] Todas as cores via design tokens (sem hardcode)?
- [ ] Mobile-first (testado em 375px)?
- [ ] Estados hover/focus/disabled em elementos interativos?
- [ ] aria-label em ícones sem texto visível?
- [ ] Contraste WCAG AA verificado?
- [ ] Loading states explícitos?
