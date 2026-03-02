# Testing Standards

This document establishes TDD testing requirements and quality benchmarks.

## Core Principles

The framework mandates **Test-First Always** methodology: "Write test first, see it fail, then implement" rather than writing implementation code beforehand.

The **RED-GREEN-REFACTOR Cycle** structures development:
1. RED: Create a failing test (must fail for correct reasons)
2. GREEN: Implement minimum code to pass
3. REFACTOR: Improve while maintaining green tests

Key requirements include writing one test at a time, ensuring complete test independence (no shared state or execution order dependencies), and committing only at green phases.

## Prohibited Practices

- Skipping the RED phase by implementing without failing tests
- Testing private methods or implementation details
- Creating test interdependencies where later tests rely on earlier ones

## Test Structure Standards

Tests must follow the **AAA Pattern** (Arrange-Act-Assert) and use naming conventions like "should_[expected]_when_[condition]".

## Coverage & Quality Thresholds

| Category | Minimum | Target |
|----------|---------|--------|
| Overall coverage | 80% | 90% |
| Business logic | 90% | 100% |
| Critical paths | 100% | 100% |

The **FIRST Principles** require tests be Fast (<10ms unit tests), Independent, Repeatable, Self-Validating, and Timely.

## Acceptance Criteria

Merges are blocked for coverage below 80%, test failures, or test interdependencies.
