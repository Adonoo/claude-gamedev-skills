---
name: project-memory
description: Keep the project's CLAUDE.md as the living source of truth for a game project — working rules, locked design decisions with date and rationale, open questions, current status, architecture conventions and hard-won lessons. Use at the start and end of every work session, whenever a design question is settled, when a status changes (built / verified / playtested / committed), or when a mistake teaches a rule worth keeping.
---

# Project memory (CLAUDE.md)

Claude starts every session with no memory of the last one except what the repo says. The
project's `CLAUDE.md` is loaded into every session automatically, so it is where shared
understanding lives. Keep it **current, short per item, and organised** — a stale CLAUDE.md is
worse than none.

## Sections (in this order)

1. **How we work** — the collaboration rules (ask before assuming, challenge never overrule,
   slice loop, who verifies feel, what Claude must never touch, git rules). Few lines, imperative.
2. **Verification lessons (learned the hard way)** — every time a mistake cost time, add the rule
   that would have prevented it, with the date and one line of what happened.
3. **Project facts** — engine version, render pipeline, input system, target platforms, version
   control, tooling paths.
4. **Game concept** — a short summary; details live in decisions.
5. **Design decisions** — locked decisions only, grouped by topic (Presentation, Movement / Core
   loop, Run structure, UI, ...). Format:
   `- YYYY-MM-DD — **Decision in bold.** Detail. (Rationale / who decided.)`
   Mark values as *tunable* when the exact number is the user's to find by playing.
   When a decision is replaced, edit it in place and note "superseded YYYY-MM-DD: ...".
6. **Open questions** — move items to decisions when answered. Keep a sub-list
   **"Awaiting confirmation"** for things built on Claude's proposal that the user hasn't
   explicitly confirmed.
7. **Current status & next steps** — "Last updated YYYY-MM-DD: ..." line, then per slice: what was
   built, how it was verified, playtest verdict, committed or not. End with **Next:**.
8. **Architecture conventions** — folder layout, namespaces, patterns, "how to add a new X"
   recipes, gotchas of the engine/tools.

A ready-made skeleton is in `references/CLAUDE.template.md`. The mode plugins (jam / solo / team)
ship their own templates with mode-specific rules.

## Rules

- **Dates are absolute** (`2026-10-15`), never "yesterday" or "last week".
- **Decisions record the why.** One line is enough; it stops later sessions from re-litigating.
- **Status says what is NOT done**: "built, awaiting playtest, not committed" is as important as
  "done".
- **Lessons are concrete**: name the tool, call or file that bit you and the safe alternative.
- **Recipes over prose** in architecture: "New enemy = `EnemyDefinition` asset + add to
  `EnemyPool`" beats a paragraph about extensibility.
- Don't duplicate what the code or git history already says clearly. Record what is
  **non-obvious**: intent, constraints, traps.
- Prune: when a section grows past what's useful, condense finished slices into one line each.

## Session routine

- **Start:** read CLAUDE.md "Current status", check `git status` (see `owner-assets-git`), and
  confirm with the user what this session is for if it isn't obvious.
- **During:** update decisions/open questions as soon as something is settled, not at the end.
- **End:** update "Current status & next steps" so the next session can pick up cold.

## Personal vs shared

- `CLAUDE.md` (committed) = shared project truth.
- `CLAUDE.local.md` (git-ignored) = one person's private preferences or machine paths.
- Claude's auto-memory = facts about the user across projects; not a substitute for CLAUDE.md.
