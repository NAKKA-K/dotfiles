---
name: refactoring
description: Code refactoring guidance, dead code detection, and technical debt resolution. Use when method/function exceeds 30 lines, class has >10 methods, code duplication detected (3+ instances), cyclomatic complexity >10, technical debt cleanup requested, or legacy code modernization needed.
---

# Refactoring Skill

Systematic approach to improving code structure while preserving behavior.

## Safety Prerequisites

Before any refactoring:

- [ ] Tests exist and pass (coverage > 80%)
- [ ] Understand scope of change impact
- [ ] Can rollback (committed current state)
- [ ] Have time margin (avoid near deadlines)

## Common Refactoring Patterns

### Extract Method/Function

**When**: Method exceeds 20-30 lines, logical blocks can be named meaningfully

```text
Before:
def process_order(order):
    # validation logic (10 lines)
    # calculation logic (15 lines)
    # save logic (10 lines)

After:
def process_order(order):
    validate_order(order)
    total = calculate_total(order)
    save_order(order, total)
```

### Extract Class/Module

**When**: Class has > 10-15 methods, clear subset works with same data

```text
Before:
class User:
    def save()
    def validate()
    def send_email()
    def format_name()

After:
class User:
    def save()
    def validate()

class UserMailer:
    def send_email()

class UserFormatter:
    def format_name()
```

### Replace Nested Conditionals with Guard Clauses

**When**: Multiple levels of nested if statements

```text
Before:
if valid:
    if authorized:
        if has_stock:
            process()

After:
if not valid: return
if not authorized: return
if not has_stock: return
process()
```

### Inline Method

**When**: Method body is as clear as method name, only called once

```text
Before:
def get_rating():
    return more_than_five_late_deliveries()

def more_than_five_late_deliveries():
    return self.late_deliveries > 5

After:
def get_rating():
    return self.late_deliveries > 5
```

### Replace Conditional with Polymorphism

**When**: Switch/if-else on object type, same pattern repeated

```text
Before:
if type == "dog":
    make_bark_sound()
elif type == "cat":
    make_meow_sound()

After:
class Dog:
    def make_sound(): return "bark"

class Cat:
    def make_sound(): return "meow"

animal.make_sound()
```

## Code Smell Detection

### Bloaters

| Smell | Threshold |
|-------|-----------|
| Long Method | > 30 lines |
| Large Class | > 15 methods |
| Long Parameter List | > 4 params |
| Primitive Obsession | Ungrouped related data |

### Couplers

| Smell | Indicator |
|-------|-----------|
| Feature Envy | More external than internal refs |
| Inappropriate Intimacy | Access to private/internal |
| Message Chains | a.b().c().d() |

### Dispensables

| Smell | Indicator |
|-------|-----------|
| Dead Code | No callers |
| Duplicate Code | Same logic 3+ times |
| Speculative Generality | Unused abstractions |

## Dead Code Detection

### Search Patterns

```bash
# Detect unused functions/methods
grep -r "def function_name" --include="*.py"
grep -r "function_name(" --include="*.py"

# Use static analysis tools
# TypeScript: ts-prune
# JavaScript: knip, depcheck
# Python: vulture
```

### Safe Removal Process

1. Search for usage (Grep/Glob)
2. Check test references
3. Check dynamic calls (reflection, etc.)
4. Mark as removal candidate (TODO/DEPRECATED)
5. Remove after confirmation
6. Verify with test execution

## Refactoring Workflow

### Phase 1: Assessment

```bash
# Run static analysis
npx ts-prune  # TypeScript dead code
npx knip      # Unused dependencies/exports

# Check complexity
npx eslint --rule 'complexity: ["error", 10]' src/
```

### Phase 2: Plan

Create refactoring plan with:
- Target files and specific changes
- Risk level (Low/Medium/High)
- Required tests before/after
- Rollback procedure

### Phase 3: Execute

1. One refactoring at a time
2. Run tests after each change
3. Commit after each successful change
4. Never mix feature changes with refactoring

### Phase 4: Verify

- [ ] All tests pass
- [ ] No performance degradation
- [ ] No new warnings/errors
- [ ] Documentation updated if needed

## Output Format

### Refactoring Report

```markdown
# Refactoring Report: [TARGET]

## Current State
- Total Lines: X
- Avg Method Length: X lines
- Max Method Length: X lines
- Cyclomatic Complexity: X

## Code Smells Detected
| Smell | Location | Severity |
|-------|----------|----------|
| Long Method | file:line | High |

## Refactoring Plan

### Phase 1: Quick Wins (Low Risk)
1. Extract `validateOrder` from `processOrder` (file:line)
   - Pattern: Extract Method
   - Tests Required: order.test.ts

### Phase 2: Structural Changes (Medium Risk)
...

## Dead Code Candidates
| Code | Location | Confidence |
|------|----------|------------|
| unusedHelper | utils.ts:42 | High |

## Estimated Impact
- Lines Removed: X
- Complexity Reduction: X%
```

## Anti-Patterns to Avoid

### Over-Refactoring

- Refactor for perfection
- Create abstractions for single use
- Sacrifice readability for "elegance"

### Premature Optimization

- Optimize without measurements
- Sacrifice readability for performance

### Breaking Changes

- Change public APIs without versioning
- Remove public methods without deprecation

## Reference

For code quality thresholds and approval criteria, see `~/.claude/rules/coding-style.md`.
