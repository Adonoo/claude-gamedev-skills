# <Project name> — <one-line pitch>

<!-- Keep this file under ~150 lines. Decisions → docs/decisions/, lessons → .claude/rules/,
     status → docs/status.md (solo/jam) or issues (team), recipes → .claude/skills/. -->

## How we work (read first)

- **Ask before assuming.** When something is ambiguous (design, feel, scope, architecture), ask; don't guess silently. Search `docs/decisions/` before asking.
- **Challenge, never overrule.** Point out risks, contradictions and alternatives with reasons, then the owner decides. Never build a different design than agreed.
- **Small vertical slices:** plan → implement → verify → owner playtests → fix → commit.
- **Feel is judged by the owner, not by Claude.** After feel changes, say what to test and which values are tunable.
- **Owner tuning and levels are untouchable:** `<data folder>`, `<levels folder>`. Propose values; don't change them.
- **Git:** `git status` first; owner changes get their own commit; stage by path, never `git add -A`; commit only when the owner agrees.

## Project facts

- Unity <version>, <URP 3D / URP 2D>, Input System, Force Text, visible meta.
- Platforms / input: <...>
- Repo: <url> · Push policy: <...>
- Unity CLI: `<path>` (drive the open Editor via the `unity:unity-cli` skill).

## Commands

- Compile: `unity command recompile` → `recompile_status` (done = `up_to_date`)
- Tests: `unity command run_tests --mode EditMode` (never while the owner's scene is unsaved)
- Build: <...>

## Map

- `Assets/_Project/` — all game content (see `unity-architecture`).
- `ArtSource/` — raw source art, outside Unity.
- `docs/decisions/` — locked decisions, one file each. `docs/status.md` — status & next steps.
- `.claude/rules/` — lessons per tool/folder. `.claude/skills/` — "how to add X" recipes.

## Concept

<3–5 lines: what the player does moment to moment, the loop, the hook, the look.>
**Pillars:** 1. … 2. … 3. …
