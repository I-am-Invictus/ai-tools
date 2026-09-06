# Agent workflow

Use this workflow for substantial features, behavior changes, and refactors:

`grill-with-docs` -> `to-spec` -> `to-tickets` -> `implement` ->
`thermo-nuclear-code-quality-review` -> `improve-codebase-architecture`

The named skills are the source of truth for each stage. Load the relevant
skill before doing that stage. Preserve the decisions and artifacts produced by
earlier stages rather than reconstructing them from memory.

## Stages

1. **Align — `grill-with-docs`**
   Interview the user until the design tree has no unresolved decisions that
   would materially change the solution. Record agreed terminology and
   architectural decisions in the repository as the skill directs. This stage
   is complete when the user and agent share a documented understanding of the
   intended outcome.

2. **Specify — `to-spec`**
   Turn the agreed conversation and repository context into an implementation
   spec. The spec must define scope, behavior, constraints, acceptance criteria,
   and explicit exclusions. This stage is complete when another agent could
   implement the work without relying on missing conversation context.

3. **Decompose — `to-tickets`**
   Split the spec into tracer-bullet tickets with explicit dependencies. Each
   ticket must be independently verifiable and leave the codebase in a coherent
   state. This stage is complete when ticket order and blocking edges are clear.

4. **Build — `implement`**
   Implement from the approved spec or tickets. Follow repository instructions,
   keep changes within scope, and run the smallest relevant verification after
   each slice. This stage is complete when every acceptance criterion is met and
   the relevant checks pass.

5. **Review — `thermo-nuclear-code-quality-review`**
   Run a strict maintainability review of the completed implementation. Report
   findings by severity with concrete file references. Fix accepted findings
   and rerun affected checks. This stage is complete when no unresolved blocking
   maintainability finding remains.

6. **Refine — `improve-codebase-architecture`**
   Survey the resulting codebase for deepening opportunities and produce the
   skill's visual report. Work through the selected candidate with the user and
   capture any accepted follow-up work. This stage is complete when the report
   accounts for the affected architecture and accepted improvements are either
   implemented and verified or recorded as explicit follow-up work.

## Routing

- Resume from the first incomplete stage when prior artifacts already exist.
- Use `diagnosing-bugs` for hard bugs or performance regressions that require a
  reproducible feedback loop; return to the main workflow if the fix expands
  into a substantial change.
- Use `improve` for broader audits that produce plans; route accepted plans into
  `to-tickets` or `implement` as appropriate.
- A direct user instruction to start at, repeat, reorder, or skip a stage takes
  precedence over this default workflow.
- Small, well-scoped edits may go directly to implementation and the two final
  review stages when the missing stages would add no decisions or useful
  artifacts.

## Handoffs

At every stage boundary, state the artifact produced, unresolved decisions, and
the next stage. Ask for user input only when a decision would materially change
the result or authority is required; otherwise continue through the workflow.
