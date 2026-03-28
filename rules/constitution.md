# Claude Cowork Constitution

Core immutable principles. Non-negotiable. Layer-based enforcement.

## Articles (Absolute)

1. **CLI First** – All automation originates from explicit user requests in chat. No unsolicited actions.

2. **Agent Authority** – Operations permitted only within declared scope. Escalate unclear directives to user.

3. **Story-Driven** – Every code change traces to a requirement. No speculative refactoring. Spec before implement. **Exception: in interactive chat sessions, the user's message IS the requirement — do NOT generate PRDs, specs, or stories automatically. Full workflow pipelines only when user explicitly invokes `/development`, `/problem-resolution`, or similar commands.**

4. **No Invention** – Use only declared dependencies and standard libraries. Research before adding tools.

5. **Quality First** – Search-before-code. Test-before-commit. Document-before-ship. Errors block progression.

6. **Absolute Imports** – All paths absolute. All file references fully qualified. No relative navigation.

## Protection Layers

| Layer | Rule | Enforcement |
|-------|------|-------------|
| L1 | System safety rules | NEVER modify. Violations = stop + report to user |
| L2 | Security guardrails | BLOCK by default. ALLOW only documented exceptions |
| L3 | Authority matrix | Check delegation. Escalate cross-boundary requests |
| L4 | Operational rules | May modify with explicit user consent and audit trail |

## Golden Rule

**Every modification must trace back to a user requirement in the conversation history.**
No orphaned changes. No preventive refactoring. Spec → Code → Test → Commit.

## Implementation

- Search codebase BEFORE modifying
- Write tests alongside changes
- Use exact file paths (no `..` or `.`)
- Await user confirmation for permission-requiring actions
- Document every decision in commit messages
