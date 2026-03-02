---
name: design-planning
description: Mandatory guardrail before any creative work (features, components, or logic changes). Steers the dialogue to explore true intent and constraints before a single line of code is written. Builds a conceptual blueprint through collaborative inquiry, strictly blocking implementation until a shared design is approved.
---

# Overview

This skill acts as a mandatory "Design Planning" phase to be invoked **before** any creative work—including feature creation, component building, or modifying existing behavior and logic.
It aims to collaboratively build a solid conceptual blueprint by exploring the user's true intent, requirements, and constraints through dialogue before a single line of code is written.

Regardless of the perceived simplicity of a project, **DO NOT take any implementation action** (writing code, scaffolding projects, or modifying logic) until you have presented a design and received explicit user approval.
Invoking any implementation-related skills is strictly prohibited until this process is complete.

# Anti-Pattern: "This Is Too Simple To Need A Design"

Every project goes through this process without exception. A todo list, a single-function utility, a config change — all of them. "Simple" projects are where unexamined assumptions cause the most wasted work. While the design can be short (even just a few sentences for truly simple projects), you **MUST present it and get approval** before moving forward.

# Step-by-Step Checklist

You MUST create a task for each of the following items and complete them in order:

1. **Context Discovery** — Investigate relevant files, existing documentation, and recent commit history to understand the current project state.
2. **Requirement Definition** — Define the purpose, technical constraints, and success criteria through collaborative dialogue.
3. **Approach Proposals** — Present 2-3 approaches including a recommended path, comparing their respective trade-offs.
4. **Incremental Design** — Break the design into manageable sections (e.g., architecture, data flow, UI) and obtain user approval for each section.
5. **Documentation** — Summarize the final agreement into `.local/YYYY-MM-DD-<topic>-plan.md`. Follow the format in `references/plan-writing.md`.

# Core Principles

Guidelines for high-quality dialogue and maintaining strict "Guardrails."

- **One Question per Message** - Focus the dialogue and avoid overwhelming the user by asking only one clarifying question at a time.
- **Provide Specific Options** - Whenever possible, present multiple choices (e.g., "Option A or B?") to facilitate faster and easier decision-making.
- **Ruthless YAGNI** - Strictly eliminate features based on "future needs." Seek the leanest, most effective design for the current problem.
- **Transparency of Trade-offs** - Act as an honest guide by clearly stating the disadvantages and risks of any proposal, including the recommended one.
- **Embrace Flexibility** - If contradictions or new insights emerge, do not hesitate to circle back to previous steps to redefine assumptions.

# Post-Design Action

Once the design has received final approval, follow these steps to conclude the design phase and open the door to implementation:

1. **Documentation** - Save the approved design as `.local/YYYY-MM-DD-<topic>-plan.md`.
2. **Declaration of Transition** - Inform the user that the documentation is complete and ask, "Are you ready to proceed with the implementation?"
3. **Lifting the Guardrail** - Only after receiving an explicit "GO" from the user is the Hard-Gate of this skill lifted. At this point, you are permitted to write code, scaffold projects, or modify logic.
