# Engineering Agent Guide

This repository is developed with AI coding agents.

Optimize for correct, maintainable, verified changes with minimal unnecessary modification.

Use this workflow:

**Understand → Plan → Slice → Implement → Verify → Review → Commit**

---

## Core rules

* Understand relevant code before editing.
* Work on one bounded problem at a time.
* Prefer small, coherent, testable changes.
* Preserve existing architecture and conventions unless the task requires changing them.
* Reuse existing schemas, interfaces, names, and abstractions before creating new ones.
* Do not refactor unrelated code.
* Do not silently change public APIs, persistent formats, protocols, configuration, or deployment behavior.
* Handle failures intentionally. Do not swallow exceptions merely to make code work.
* Prefer simple, explicit code over clever or speculative abstractions.
* Never claim a command, test, subagent, deployment, or tool ran unless it actually did.

When requirements are unclear, inspect the repository first.

Ask the user only when ambiguity materially affects behavior, architecture, public interfaces, compatibility, safety, or scope.

---

## Skills and tool references

Use installed development skills automatically when their guidance applies.

Do not wait for the user to explicitly request a skill.

Skills are reference material for the current task, not separate development sessions. Consult them when useful and continue the task using their guidance.

### `grill-with-docs`

Automatically invoke `grill-with-docs` when:

* starting a new vague feature that the user requests with not enough definition.
* design decisions are needed from me for a feature.
* Early planning work when we are planning for future work.

### `tdd`

Automatically invoke `tdd` when:

* fixing a bug
* adding behavior that should be covered by tests
* writing integration tests
* the user requests test-first development
* the task naturally fits a red → green loop

Use it before writing the relevant tests or implementation.

Follow its guidance on:

* behavioral tests
* seams
* red → green development
* vertical slices
* mocking
* test anti-patterns

Do not require user confirmation of an obvious existing seam. Infer seams from repository architecture when reasonably clear.

Ask only when selecting a seam would materially change the public interface or architecture.

### `codebase-design`

Automatically invoke `codebase-design` when:

* introducing or changing a module boundary
* deciding where new behavior belongs
* designing a new public interface
* extracting substantial code
* choosing between adapters, abstractions, or service boundaries
* architecture is unclear or contested
* the correct testing seam is unclear because the interface itself is being designed

Use it before committing to the structural decision.

Do not invoke it for straightforward changes inside an established boundary.

### `thermo-nuclear-code-quality-review`

Automatically invoke `thermo-nuclear-code-quality-review` and `improve-codebase-architecture` after substantial implementation when:

* multiple files changed
* public behavior changed
* architecture or interfaces changed
* a bug fix had meaningful edge cases
* concurrency, security, persistence, networking, or external processes are involved
* significant refactoring occurred

Use it after implementation is green and before final completion.

For small mechanical changes, direct review may be sufficient.

### Skill discipline

Do not invoke every skill for every task.

Use the smallest relevant set.

When multiple skills apply, a typical sequence is:

**codebase-design → tdd → implementation → code-review**

Do not repeatedly invoke the same reference unless new information materially changes the task.

---

## Understand before editing

Before changing code:

1. Identify the behavior being changed.
2. Locate the public interface or system boundary.
3. Read the relevant implementation.
4. Read nearby tests.
5. Check relevant architecture docs, ADRs, schemas, or interface definitions.
6. Find similar existing behavior.
7. Determine the smallest coherent file set.

Prefer understanding a few relevant files deeply over scanning or rewriting large areas.

Trace enough of the execution path to understand:

* input
* important decisions
* state changes
* external interactions
* output
* error handling
* verification points

Read `CONTEXT.md` if present and use its domain terminology.

Respect ADRs affecting the area being changed.

---

## Plan substantial work

For non-trivial work, establish a short plan containing:

* goal
* current and desired behavior
* likely files/components
* public seams
* implementation slices
* tests or verification
* important non-goals
* compatibility or deployment risks

Keep planning proportional to the task.

Plans are working hypotheses. Update them when repository evidence proves an assumption wrong.

---

## Work in vertical slices

Prefer vertical slices:

**behavior → test → implementation → verification**

Avoid horizontal development such as:

**all interfaces → all internals → all tests**

Each slice should create one small piece of observable working behavior.

Do not implement speculative future requirements.

Do not create abstractions until the current problem demonstrates a useful boundary.

---

## Testing

Tests should verify behavior through stable public seams.

Typical seams include:

* public functions/classes
* APIs
* CLI interfaces
* protocols
* hardware abstractions
* persistence interfaces
* service boundaries

Avoid tests coupled unnecessarily to implementation structure.

A behavior-preserving refactor should normally preserve its tests.

Expected values must come from an independent source of truth such as:

* specifications
* known examples
* fixtures
* protocol definitions
* explicitly defined behavior

Do not duplicate the implementation algorithm inside the test to calculate the expected result.

Mock real external boundaries when necessary.

Avoid mocking internal implementation simply to isolate every function.

### Bugs

When practical:

1. reproduce the failure
2. write a focused regression test
3. confirm it fails for the expected reason
4. implement the smallest coherent fix
5. verify the focused test
6. run broader relevant checks

### Features

When practical:

1. identify the seam
2. define one observable behavior
3. write a focused failing test
4. implement that slice
5. verify it
6. continue to the next behavior

Do not build large speculative test suites against imagined behavior.

Small cleanup after green is acceptable.

Keep broad refactoring separate.

---

## Agent delegation

The primary agent owns:

* overall understanding
* architecture
* decomposition
* integration
* final review
* final verification

When subagents are available, use them early for bounded work.

Good tasks include:

* locating code
* tracing execution
* finding similar patterns
* identifying tests
* implementing isolated changes
* writing focused tests
* reproducing bugs
* investigating specific failures
* reviewing diffs
* documentation
* focused verification

Keep global architecture, ambiguous cross-cutting behavior, migrations, security-sensitive changes, and final integration with the primary agent.

Every delegated task should specify:

* concrete goal
* relevant paths or search direction
* constraints
* expected deliverable
* acceptance criteria
* verification
* non-goals

Tell implementation agents to make the bounded change, not merely recommend one.

Run independent tasks concurrently when safe.

Avoid simultaneous edits to the same file.

Do not redo correct delegated work.

Subagent output is evidence, not proof. The primary agent reviews and integrates it.

---

## Code quality

Prefer:

* explicit data flow
* narrow responsibilities
* existing domain vocabulary
* existing representations
* bounded waits and retries
* useful failures and logging
* focused modules

Avoid:

* unnecessary abstraction
* premature generalization
* duplicated domain models
* hidden global state
* swallowed exceptions
* unbounded retries
* unbounded waits
* unexplained magic values
* unrelated formatting churn
* opportunistic rewrites

Do not move code merely because another organization looks cleaner.

Make structural changes because they solve a concrete boundary or maintenance problem.

---

## Verification

The coding agent owns routine verification.

After implementation:

1. run the narrowest relevant test
2. run relevant lint/type/static checks
3. run broader relevant tests when practical
4. perform safe smoke/integration checks when useful
5. inspect `git status`
6. inspect the final diff

For integrations, verify both sides of the boundary when practical.

If a check cannot run:

* investigate why
* distinguish code failures from environment failures
* report exactly what did and did not run

Never describe an unexecuted check as passing.

---

## Review

After implementation is green, review the complete change.

Check for:

* incorrect assumptions
* unnecessary complexity
* missed error handling
* weak tests
* implementation-coupled tests
* accidental API changes
* compatibility problems
* concurrency problems
* resource leaks
* security issues
* dead code
* unrelated changes

Use `code-review` automatically when the change warrants it.

Refactor only to improve the completed change or fix a concrete issue.

Rerun relevant verification afterward.

---

## Git discipline

Before staging:

* inspect `git status`
* inspect the relevant diff
* exclude unrelated user changes
* exclude secrets
* exclude temporary/generated artifacts unless intentionally tracked

Prefer small coherent commits.

Each commit should represent one understandable verified change.

Do not rewrite history, force push, discard user work, or run destructive Git commands unless explicitly requested.

---

## External and destructive actions

Implementation does not imply authorization for destructive or externally visible actions.

Do not perform actions such as:

* production deployment
* destructive migrations
* deletion of user data
* credential changes
* infrastructure modification
* publishing releases
* force pushing

unless explicitly requested or authorized.

Keep these phases distinct:

**implementation → verification → deployment preparation → deployment → post-deployment verification**

---

## Completion

A task is complete when:

* requested behavior works
* relevant tests pass
* broader verification ran when practical
* final changes were reviewed
* unrelated changes are excluded
* compatibility concerns were considered
* documentation was updated when necessary

Report:

* what changed
* important decisions
* files/components affected
* tests/checks actually run
* remaining risks
* commit ID if applicable
* deployment status if applicable

Keep routine completion reports concise.

---

# Project Configuration

Customize this section for each repository.

## Project

**Purpose:** TODO
**Languages/frameworks:** TODO
**Runtime/deployment target:** TODO

## Documentation

**Context:** `CONTEXT.md` or TODO
**Architecture:** TODO
**ADRs:** TODO

## Components

* `TODO` — TODO

## Important interfaces

* TODO

## Commands

### Setup

```bash
# TODO
```

### Focused tests

```bash
# TODO
```

### Full tests

```bash
# TODO
```

### Static checks

```bash
# TODO
```

### Run locally

```bash
# TODO
```

## Deployment

**Target:** TODO
**Deploy command:** TODO
**Health checks:** TODO
**Rollback:** TODO

## Repository-specific rules

* TODO
