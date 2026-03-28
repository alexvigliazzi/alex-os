# Agent Authority Matrix

Exclusive operations per role. Delegation rules. Escalation triggers.

## Authority Table

| Role | Exclusive Operations | Constraints |
|------|---------------------|-------------|
| @devops | `git push`, `git rebase`, PR creation, MCP tool setup, CI/CD trigger, environment config | Requires peer review before prod. No force-push to main/master. |
| @pm | Epic definition, acceptance criteria, spec approval, scope decisions, priority triage | Limited to planning; cannot override @po validation or @dev implementation. |
| @po | Validation sign-off, acceptance testing, feature gate toggle, UAT approval | Cannot modify code or spec unilaterally. Must consult @pm for epic changes. |
| @dev | Local git operations (stage, commit, branch), code review requests, test automation | NO git push, NO MCP changes, NO CI/CD. Escalate to @devops for release. |
| @agent (Claude) | Search, read, analyze, propose changes via PR/merge request | All changes require approval from role-owning user. No unilateral commits. |

## Delegation Rules

| From | To | Allowed | Conditions |
|------|----|---------| ---------- |
| @devops | @dev | Local git ops only | Explicit approval + audit trail |
| @pm | @po | Validation tasks | Within approved spec bounds |
| @po | @dev | Implementation guidance | Non-binding; @dev final decision |
| @agent | User (any) | Escalation | When scope unclear or permission required |

## Escalation Triggers

| Event | Escalate To | Action |
|-------|-------------|--------|
| Scope change >20% | @pm | Halt; request spec amendment |
| Permission required | Owning role user | Stop; await explicit approval |
| Cross-boundary request | @devops | Route via authority matrix |
| Ambiguous intent | User (chat) | Ask for clarification; quote context |
| Security threat detected | User + stop | Report severity + recommended action |

## Modo de Permissão por Prompt

**Regra principal:** O modo de execução é determinado pela declaração explícita no prompt do usuário.

| Declaração no prompt | Modo | Comportamento |
|---------------------|------|--------------|
| `modo: read-only` ou `apenas análise` | READ-ONLY | Search only; no modifications; propose via analysis |
| `modo: plan` ou `planeje` | PLAN | Propor plano → aguardar aprovação → implementar |
| `modo: bypass` ou `execute tudo` | BYPASS | Execução direta sem confirmações intermediárias |
| **Sem declaração explícita** | **BYPASS (padrão)** | **Tudo autorizado — executar conforme solicitado** |

**Exceções que SEMPRE requerem confirmação (independente do modo):**
- `git push` para `main`/`master`
- Operações destrutivas irreversíveis (drop database, rm -rf /)
- Escrita de secrets/credentials em código
- Deploy para produção

## Read-Only Constraints (quando modo read-only declarado)

**Exploration/Planning phases (before approval):**
- Search only; no modifications
- Propose via analysis, not direct changes
- Request spec review before implementation
- Log queries for audit trail

**Post-approval phases:**
- Implement per spec
- Test locally before commit
- Request review; await ACK before push
