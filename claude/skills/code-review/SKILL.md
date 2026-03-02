---
name: code-review
description: Autonomous code review for evaluating generated or modified code. Use when (1) >50 lines generated/modified, (2) completing a feature, (3) fixing a bug, (4) making critical path changes (auth, payments, data). Skip for trivial changes (<10 lines with obvious correctness), documentation-only, or formatting-only changes.
---

# Code Review Skill

Structured review methodology with confidence-based filtering for actionable feedback.

## Review Process

### 1. Scope Assessment

Identify changed files, change type (feature/bugfix/refactor), and locate project guidelines (CLAUDE.md, README.md).

### 2. Multi-Perspective Analysis

**Always apply:**
- **Bugs**: Logic errors, null handling, edge cases, race conditions, silent failures
- **Security**: Input validation, auth gaps, injection risks, data exposure
- **Quality**: Separation of concerns, error handling, DRY, readability
- **History**: Breaking changes, regression risks, pattern consistency

**Conditional:**
- **Tests**: When test files changed—coverage of critical paths and edge cases
- **Contracts**: When APIs/types changed—type safety, backward compatibility, data model consistency

### 3. Confidence Scoring

Score each issue 0-100:

| Score | Meaning |
|-------|---------|
| 0 | False positive or pre-existing |
| 25 | Unverified, possibly false positive |
| 50 | Real but minor or rare |
| 75 | Verified, impacts functionality or in guidelines |
| 100 | Certain, frequent, evidence confirms |

**Report only issues with confidence >= 80.**

### False Positives to Exclude

- Pre-existing in unchanged code
- Caught by linters/CI (imports, types, formatting)
- Pedantic nitpicks
- General concerns not in project guidelines
- Silenced with ignore comments
- Intentional changes related to the task

## Output Format

Report issues in flat format:

```text
[SEVERITY] Short issue title
File: path/to/file.ext:line
Confidence: 85
Issue: Brief description of the problem
Fix: How to resolve it
<bad code>   // BAD
<good code>  // GOOD
```

### Severity Levels

| Level | Criteria | Action |
|-------|----------|--------|
| Critical | Runtime errors, security vulnerabilities, data loss | Must fix |
| Important | Edge case failures, missing validation, test gaps | Should fix |
| Minor | Style, docs, optimization opportunities | Consider |

### Summary Format

```text
---
Summary: 12 issues (2 critical, 3 important, 5 minor, 2 suggestions)
Priority: Fix critical issues in auth module first
Quality Gate: PASS / FAIL (any Critical = FAIL)
```

## Approval Criteria

- **Approve**: No critical or important issues
- **Conditional**: Important issues with clear mitigation plan
- **Block**: Any critical issue present

## Principles

1. **Security first**: Block on critical security issues
2. **Quantify**: Numbers, not "some" or "many"
3. **Pragmatic**: Real issues over theoretical ones
4. **Scale**: >500 lines → prioritize architecture/security over style
5. **Actionable**: Every issue needs clear fix guidance
6. **Velocity**: Catch real bugs, don't block on minor style

## Reference

For coding standards and thresholds, see `~/.claude/rules/coding-style.md`.
