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

## Read-Only Constraints

**Exploration/Planning phases (before approval):**
- Search only; no modifications
- Propose via analysis, not direct changes
- Request spec review before implementation
- Log queries for audit trail

**Post-approval phases:**
- Implement per spec
- Test locally before commit
- Request review; await ACK before push
