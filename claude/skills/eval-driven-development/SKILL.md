---
name: eval-driven-development
description: EDD workflow for rubric-driven, measurable improvements. Use when modifying skills, prompts, configurations, or any artifact where quality can be evaluated before and after changes. Define evaluation criteria first, score the current state as a baseline, implement changes, then compare before/after to confirm improvement.
---

# Eval-Driven Development (EDD)

Changes driven by explicit evaluation criteria, not intuition.

**Core principle:** Define what "good" looks like before touching anything.

## Workflow

```
┌──────────────┐     ┌────────────────┐     ┌─────────────┐     ┌──────────────┐
│ 1. Define    │────▶│ 2. Eval Before │────▶│ 3. Improve  │────▶│ 4. Eval After│
│    Rubric    │     │   (Baseline)   │     │             │     │  (Compare)   │
└──────────────┘     └────────────────┘     └─────────────┘     └──────────────┘
```

## Step 1: Define Rubric

Derive criteria from the relevant spec, guidelines, or goals. Each criterion must be binary (✅ / ❌) or scored (0–2).

```markdown
| # | Criterion | Source |
|---|-----------|--------|
| E1 | [Measurable condition] | [Spec reference] |
| E2 | [Measurable condition] | [Spec reference] |
```

**Good criteria:**
- Objective and verifiable ("frontmatter contains only `name` and `description`")
- Derived from an authoritative source (guidelines, spec, contract)

**Bad criteria:**
- Subjective ("looks good", "feels clean")
- Not derivable from the artifact itself

## Step 2: Baseline Evaluation

Score every target artifact against the rubric before making any changes.

```markdown
| Target | E1 | E2 | E3 | Score |
|--------|----|----|----|-------|
| foo    | ✅ | ❌ | ✅ | 2/3   |
| bar    | ❌ | ❌ | ✅ | 1/3   |
```

This baseline is the ground truth. Do not skip it—without it, "improvement" is unverifiable.

## Step 3: Implement

Make targeted changes to fix failing criteria. One criterion at a time is preferred.

- Fix only what the rubric flags as failing
- Do not introduce changes outside the rubric's scope

## Step 4: Eval After and Compare

Re-score using the identical rubric. Present a side-by-side comparison.

```markdown
| Target | E1 Before→After | E2 Before→After | E3 Before→After | Score Before→After |
|--------|-----------------|-----------------|-----------------|---------------------|
| foo    | ✅ → ✅         | ❌ → ✅         | ✅ → ✅         | 2/3 → 3/3          |
| bar    | ❌ → ✅         | ❌ → ✅         | ✅ → ✅         | 1/3 → 3/3          |
```

If a criterion still fails after changes, note it explicitly and explain why.

## Output Format

Always present all four steps visibly, in order:

```
## Rubric
[Criteria table]

## Baseline (Before)
[Scoring table]

## Changes
[What was changed and why, mapped to failing criteria]

## Result (After)
[Comparison table]
[Summary: X/Y criteria now passing across all targets]
```

## When Rubric Criteria Are Unclear

If the spec or guidelines are ambiguous, surface the ambiguity before scoring:

1. Propose a candidate interpretation
2. Ask for confirmation
3. Lock in the interpretation, then proceed

Never invent criteria without grounding them in an authoritative source.
