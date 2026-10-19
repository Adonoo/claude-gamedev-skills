---
name: jam-workflow
description: Day-to-day workflow during a game jam with Claude — daily deadline check against the milestone plan, scope cuts, right-sized slices and tests, fun check, feature freeze, juice and polish priorities, and regular builds. Use at the start of every jam work session ("let's continue", "what's next"), when the user proposes a new feature mid-jam, when behind schedule, or when deciding what to polish.
---

# Jam workflow

Applies the core skills (`gamedev-core:slice-loop`, `design-partner`, `unity-claude-rules`,
`owner-assets-git`, `project-memory`) with the jam's dial set to **"ship on time"**.

## Every session starts with the deadline

1. Read CLAUDE.md (Milestones, Scope, Current status) and `git status`.
2. Tell the user in 3 lines: today's date, days left, the next milestone and whether we're
   **ahead / on track / behind**.
3. If behind: **propose cuts first** (move Musts → Should, Shoulds → Could, simplify content
   targets). The user decides; record cuts with the date in "Cut".
4. Propose today's 1–3 slices, smallest first.

## Slices in a jam

- Same loop as `slice-loop`, but slices are smaller (a few hours) and the playtest handoff is
  a 3–5 line checklist.
- **Tests**: only for tricky pure logic (timers, scoring, generation rules, state machines,
  anything that broke twice). Skip tests for glue, visuals, one-off scripts.
- **Placeholder first**: greybox/colored shapes until the mechanic is approved; art replaces
  sprites without rewiring.
- Still: tuning in data assets, no edits to the user's values or levels, commit after the
  user's OK.

## New ideas mid-jam

Every new idea gets the same three questions, out loud:

1. Which list does it go on (Must / Should / Could)?
2. What does it cost (hours) and what does it push out?
3. Does it make the **core loop** better, or is it a second game?

Challenge, then let the user decide. After **feature freeze** the answer to new features is
"Could list for the post-jam version", unless the user explicitly overrides.

## Fun check (around day 4 of 14)

Have the user (and ideally someone else) play the core loop for 5 minutes. Ask:
What was the best moment? Where did you get bored or confused? Would you play another round?
Then decide together: **polish the core**, **twist it**, or **cut sideways** to the fun part.
Record the decision.

## Builds

- Build for the **target platform** every ~2 days, from day 2–3 on. Fix build-only problems
  immediately (WebGL: no threads, file size, audio needs a click to start, input focus).
- Keep the last good build. Note in CLAUDE.md which commit it came from.

## Polish priorities (after feature freeze)

In this order — each step makes the game better for a player who has 5 minutes:

1. **Can a stranger play it?** Start screen, controls shown, clear goal, end/win/lose screen,
   restart without reloading the page.
2. **Bugs that block or soft-lock.**
3. **Feedback / juice** on the core action: hit/land/collect feedback, screen shake (small),
   particles, squash & stretch, sound on every important action.
4. **Audio**: music loop + key SFX, volume sane by default, a mute key.
5. **Difficulty pass**: the first minute must be easy.
6. **Presentation**: itch page, cover image, 3–5 screenshots, a GIF, short description,
   controls listed.

## When finishing

Use `jam-ship` for the release checklist.
