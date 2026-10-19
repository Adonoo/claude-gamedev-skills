# <Project name> — <one-line pitch>

## How we work (read first)

- **Ask before assuming.** When something is ambiguous (design, feel, scope, architecture), ask; don't guess silently.
- **Challenge design choices, never overrule them.** Point out risks, contradictions and alternatives with reasons, then let the owner decide.
- **Record decisions.** Settled questions go into "Design decisions" (date + reason); keep "Open questions" current.
- **Small vertical slices.** plan → implement → verify → owner playtests → fix → commit.
- **Game feel is verified by the owner, not by Claude.** After feel changes, say exactly what to test and which tuning values are exposed.
- **Owner tuning is untouchable.** Values in `<data folder>` and owner-built levels in `<levels folder>` are never changed unless the owner asks.
- **Protect owner changes in git.** Check `git status` first; commit owner changes separately (`Owner tuning: …`, `Owner level: …`); stage own files by path, never `git add -A`.

## Verification lessons (learned the hard way)

- _(add one line per lesson: date — what happened — the rule)_

## Project facts

- Engine: Unity <version>, <render pipeline>, <input system>, Force Text serialization.
- Platforms / input devices: <...>
- Version control: git (+ LFS for heavy binaries). Remote: <url>
- Tooling: Unity CLI (`unity`), Unity Editor driven live via the `unity-cli` skill.

## Game concept

<3–6 lines: what the player does moment to moment, the loop, the hook, the look. Feel reference.>

**Pillars** (every feature must serve one; used to say no):
1.
2.
3.

**First playable:** <smallest version that tests whether the core is fun>

**Slice roadmap:** (ordered; each playable on its own)
1.

**Later / not now:**
-

## Design decisions

_(locked only; `YYYY-MM-DD — **Decision.** Detail. (Why.)`; "tunable" = owner finds the value by playing)_

**Core loop**
-

**Controls & feel**
-

**Presentation**
-

## Open questions

-
- **Awaiting owner confirmation** (built on Claude's proposals):
  -

## Current status & next steps (keep this updated)

_Last updated YYYY-MM-DD: <one line>._

- **Next:**

## Architecture conventions

- All project content in `Assets/_Project/` (`Scripts/Runtime`, `Scripts/Editor`, `Tests/EditMode`, `Art`, `Audio`, `Prefabs`, `Data`, `Scenes`, `Settings`, `Input`).
- Namespaces mirror folders under `Game`.
- Tuning and content definitions live in ScriptableObjects under `Data/`; no gameplay constants in code.
- Pure rules in plain C# classes (EditMode-tested); MonoBehaviours are thin glue.
- _(add "how to add a new X" recipes as systems appear)_

## Git

- Commit small, focused changes with clear messages, only when the owner agrees.
- Push policy: <ask / after each verified commit>.
