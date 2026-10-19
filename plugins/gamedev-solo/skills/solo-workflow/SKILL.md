---
name: solo-workflow
description: Full-rigor session workflow for a long-term solo game project with Claude — session start and end routine, plan mode for multi-system work, a test for every rule, owner playtest before every commit, a decision log with an awaiting-confirmation list, lessons learned, and periodic health checks of the project memory and code. Use at the start of each session on a long-term solo project ("let's continue", "what's next"), before larger features, and when wrapping up a session.
---

# Solo long-term workflow

Same core skills as always (`gamedev-core:*`), with the dial at **"quality that lasts"**:
months later, any session must be able to pick up cold and trust what it finds.

## Session start

1. `git status`. User changes in data/levels/art → offer to commit them first as
   `Owner tuning: …` / `Owner level: …` (see `owner-assets-git`).
2. Read CLAUDE.md "Current status & next steps" and "Awaiting confirmation".
3. Say in 2–3 lines where we are and what's next; ask if the user wants that or something else.
4. If something built earlier is still **awaiting playtest**, ask for the verdict before
   starting new work.

## During the session

- **Plan mode** for anything touching several systems: show the plan, let the user adjust,
  then build.
- **Every rule gets a test** in the pure model, written with the rule. Tests simulate inputs
  the way the real components report them.
- **Every slice gets an owner playtest** before it's committed (see `slice-loop`).
- **Decisions are recorded as they happen** — dated, with the why. Claude's own proposals that
  the user accepted implicitly go to "Awaiting confirmation" until confirmed explicitly.
- Prefer **reusable tooling** over one-off manual work: editor menus that build kits,
  converters the user runs per scene, bake steps for generated art — documented as recipes in
  CLAUDE.md.
- When a mistake happens, add a dated lesson to "Verification lessons".

## Session end

- Update "Current status & next steps" (built / verified / awaiting playtest / committed).
- If something is ready to commit and approved, ask; commit by path.
- Mention any open question the user should think about before next time.

## Health checks (every ~5 sessions or after a big milestone)

Offer a short review:

- **CLAUDE.md**: condense finished slices to one line each; move answered questions; remove
  stale facts; check "Awaiting confirmation" — ask the user to confirm or change each item.
- **Code**: run the full test suite (only when no unsaved user scene is open), look for
  duplicated patterns that should become a shared helper, rules that crept into glue code.
- **Roadmap**: still the right next slices? Anything to cut given the pillars?

## Long-project traps to watch for

- Scope creep → check new ideas against the pillars; park them in "Later".
- Feel drift → keep a stable test room so changes are judged in the same place.
- Silent defaults → a code default change doesn't change existing assets; tell the user.
- Re-asking settled questions → search the decision log first.
