---
description: Run the Test & Deploy Pipeline (unit → integration → e2e → coverage → security → build → staging → prod). Ops agent EXCLUSIVE for stages 4-9.
allowed-tools: [Read, Bash, TodoWrite, Agent]
---

# Test & Deploy Pipeline

Gate-pass criteria per stage. Ops agent EXCLUSIVE for stages 4-7.

## Pipeline Stages

### Stage 1: Unit Test Suite
```
Command: npm test (or equivalent)
Gate: All tests pass
Metric: 0 failures
Action if fail: Developer fixes, rerun
```

### Stage 2: Integration Tests
```
Command: npm run test:integration
Gate: All integration tests pass
Metric: 0 failures
Action if fail: Developer investigates, rerun
```

### Stage 3: E2E Tests
```
Command: npm run test:e2e
Gate: All critical user flows pass
Metric: ≥95% pass rate
Action if fail: Document known issues, escalate
```

### Stage 4: Coverage Check (Ops)
```
Metric: Line coverage ≥80%
Gate: PASS if coverage ≥80%, WARN if 70-79%, FAIL if <70%
Action:
├─ PASS: Continue to Stage 5
├─ WARN: Document gap, continue with approval
└─ FAIL: Block, developer adds tests
```

### Stage 5: Security Scan (Ops → Reviewer)
1. **Ops:** Run scanner (SAST/SCA)
2. **Reviewer:** Triage results
   - Critical: Block, fix required
   - High: Mitigation plan
   - Medium/Low: Log in ADR

Gate: Critical = 0, High ≤ 1 with plan

### Stage 6: Build Verification (Ops)
```
Command: npm run build (or equivalent)
Gate: Build succeeds, output valid
Artifact: Deployable package
Action if fail: Developer debugs, rerun
```

### Stage 7: Staging Deploy (Ops EXCLUSIVE)
```
Target: Staging environment
Action: Deploy current commit
Trigger: Stage 6 PASS
Gate: Deployment succeeds
Monitor: Error logs, uptime
```

### Stage 8: Smoke Tests (Ops)
```
Tests: Critical user flows on staging
Gate: ≥99% of critical paths respond
Action if fail: Ops investigates, may rollback staging
```

### Stage 9: Production Deploy (Ops EXCLUSIVE + User Approval)
```
Requires: Explicit user approval in chat
Target: Production environment
Action: Deploy to prod with monitoring
Trigger: All stages 1-8 PASS
Gate: Deployment succeeds
Monitor: Errors, performance, rollback ready
```

## Rollback Triggers

| Signal | Action |
|---|---|
| Error rate > 1% | Rollback to previous |
| Latency spike > 50% | Investigate, may rollback |
| Critical service down | Rollback immediately |
| Database migration fails | Rollback + investigate |

## Gate Matrix: PASS=Continue, FAIL=Stop | E2E/Coverage/Security WARN=Continue with documentation

## Exit Criteria (Production Ready)

- ✓ All stages 1-9 pass
- ✓ User approval obtained
- ✓ Deploy log recorded
- ✓ Monitoring active
- ✓ Rollback plan documented
