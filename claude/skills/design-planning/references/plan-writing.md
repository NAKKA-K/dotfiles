# Plan Writing Guidelines

Reference material for the Documentation phase of the design-planning skill.

## Overview

Write implementation plans so that a developer with **zero codebase context and no domain knowledge** can execute them without confusion.

- Include all information needed for each task
- Provide exact file paths, code, and verification commands
- Break into tasks completable in 2-5 minutes

> For TDD cycles, commit practices, and code quality standards, see `~/.claude/rules/`.

## Plan Document Format

**Save to:** `.local/YYYY-MM-DD-<topic>-plan.md`

### Header

```markdown
# [Feature Name] Implementation Plan

**Goal:** [What this builds, one sentence]

**Architecture:** [Approach overview, 2-3 sentences]

**Tech Stack:** [Technologies and libraries used]

**References:**
- TDD: `~/.claude/rules/testing.md`
- jj: `~/.claude/rules/jj-practice.md`

---
```

### Task Structure

Choose the structure based on task type.

#### Type A: Feature Implementation (TDD)

```markdown
### Task N: [Component Name]

**Files:**
- Create: `exact/path/to/file.py`
- Modify: `exact/path/to/existing.py:123-145`
- Test: `tests/exact/path/to/test.py`

**Process:** Follow TDD cycle per `~/.claude/rules/testing.md`

1. Write failing test
2. Run test, confirm failure
3. Write minimal implementation
4. Run test, confirm pass
5. Commit (`jj describe -m "feat: ..." && jj new`)

**Test Code:**
\`\`\`python
def test_specific_behavior():
    result = function(input)
    assert result == expected
\`\`\`

**Implementation Code:**
\`\`\`python
def function(input):
    return expected
\`\`\`

**Verification:**
Run: `pytest tests/path/test.py::test_name -v`
Expected: PASS
```

#### Type B: Configuration / Infrastructure

```markdown
### Task N: [Configuration Name]

**Files:**
- Modify: `pyproject.toml`

**Steps:**
1. Apply changes
2. Verify behavior
3. Commit

**Changes:**
\`\`\`toml
[tool.pytest]
testpaths = ["tests"]
\`\`\`

**Verification:**
Run: `pytest --collect-only`
Expected: Tests under tests/ are collected
```

#### Type C: Documentation

```markdown
### Task N: [Document Name]

**Files:**
- Create: `docs/api.md`

**Steps:**
1. Create/update document
2. Verify links and consistency
3. Commit

**Content:**
\`\`\`markdown
# API Reference
...
\`\`\`
```

## Task Granularity Guide

**Target: Completable in 2-5 minutes**

| Granularity | Judgment |
|-------------|----------|
| One test + one function | OK |
| One config file change | OK |
| Changes spanning multiple files | Consider splitting |
| "Implement auth feature" | Too large - must split |

**When to split:**
- Task description contains "and"
- Multiple verification steps needed
- Rollback on failure would be complex

## Anti-Patterns

| Pattern | Problem | Fix |
|---------|---------|-----|
| Too coarse | Executor gets lost, hard to rollback | Split into 2-5 min units |
| Vague instructions | "handle appropriately", "as needed" | Write concrete code |
| Missing paths | "add tests" | `tests/auth/test_login.py` |
| No verification | Can't determine success/failure | Always include command + expected result |
| Implicit assumptions | Executor lacks context | Document prerequisites and dependencies |
| Code fragments only | "add this line" | Complete before/after code blocks |

## Quality Checklist

Verify before finalizing the plan:

- [ ] Each task completable in 2-5 minutes
- [ ] File paths are complete (`src/auth/login.py` format)
- [ ] Code is complete (actual code, not "add validation")
- [ ] Verification commands and expected results specified
- [ ] Task dependencies are clear (reason for ordering)
- [ ] Prerequisites documented (required packages, env vars, etc.)
- [ ] TDD tasks reference `~/.claude/rules/testing.md`

## Good/Bad Examples

### Bad: Vague and Too Coarse

```markdown
### Task 1: User Authentication

Implement authentication feature. Handle errors appropriately
and store passwords securely.
Add tests.
```

**Problems:** Too coarse, "appropriately" is vague, no paths, no verification

### Good: Specific and Executable

```markdown
### Task 1: Password Hash Functions

**Files:**
- Create: `src/auth/password.py`
- Test: `tests/auth/test_password.py`

**Process:** Follow TDD cycle per `~/.claude/rules/testing.md`

**Test Code:**
\`\`\`python
import pytest
from src.auth.password import hash_password, verify_password

def test_hash_password_returns_different_value():
    password = "secret123"
    hashed = hash_password(password)
    assert hashed != password
    assert len(hashed) == 60  # bcrypt format

def test_verify_password_returns_true_for_correct():
    password = "secret123"
    hashed = hash_password(password)
    assert verify_password(password, hashed) is True

def test_verify_password_returns_false_for_incorrect():
    hashed = hash_password("secret123")
    assert verify_password("wrong", hashed) is False
\`\`\`

**Implementation Code:**
\`\`\`python
import bcrypt

def hash_password(password: str) -> str:
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

def verify_password(password: str, hashed: str) -> bool:
    return bcrypt.checkpw(password.encode(), hashed.encode())
\`\`\`

**Verification:**
Run: `pytest tests/auth/test_password.py -v`
Expected: 3 passed

**Dependencies:**
- Requires `bcrypt` package (assumed already in `pyproject.toml`)
```
