# <Game name> — <jam name> entry

## Jam facts

- Theme: **<theme>** · Deadline: **YYYY-MM-DD HH:MM <time zone>** · Submit to: <itch.io page / jam page>
- Format: <WebGL / Windows build / both> · Rules: <asset rules, team size>
- Team: <name — role> · Final say on design: **<name>**
- Hours/day: <n> · Unavailable: <dates>

## How we work (read first)

- **Ask before assuming, but keep it quick.** Ask when the answer changes what gets built; otherwise pick the obvious default and say so.
- **Challenge design choices, never overrule them.** Especially challenge scope: every new idea is weighed against the deadline. The final say is <name>'s.
- **Deadline first.** At the start of each session compare today with the milestone plan and say whether we're ahead/on track/behind. If behind, propose cuts before new work.
- **Small vertical slices**, each playable: plan → implement → verify → playtest → fix → commit.
- **Game feel is judged by the owner**; Claude says what to test and which values are tunable.
- **Owner tuning is untouchable** (`Assets/_Project/Data/**`, levels in `Assets/_Project/Scenes/Levels/**`). Propose values; don't change them.
- **Protect owner changes in git**: `git status` first; owner changes get their own commit; stage by path, never `git add -A`.
- **Tests only where they pay off**: tricky pure rules (timers, scoring, procedural rules, state machines). No tests for glue or visuals.
- **Build early, build often**: a target-platform build at least every ~2 days; a build that fails late is the classic jam killer.

## Verification lessons (learned the hard way)

-

## Project facts

- Unity <version>, <URP 2D / URP 3D>, Input System, Force Text. Platform: <...>. Input: <KBM / gamepad>.
- Git remote: <url> · Push policy: <...>

## Concept

**Brief:** <3–5 lines>
**Core loop:** <one sentence> · **Must feel great:** <the one mechanic>

## Scope

**Must** (smallest complete, winnable game):
- [ ]
**Should:**
- [ ]
**Could:**
- [ ]
**Cut** (decided not to do, with date):
-

## Milestones

| Date | Milestone | Status |
|---|---|---|
| YYYY-MM-DD | Core loop playable + first build | |
| YYYY-MM-DD | Fun check | |
| YYYY-MM-DD | Feature freeze | |
| YYYY-MM-DD | Release candidate | |
| YYYY-MM-DD | Submit (hours early) | |

## Design decisions

_(`YYYY-MM-DD — **Decision.** Detail. (Why.)`)_
-

## Open questions

-
- **Awaiting owner confirmation:**

## Current status & next steps

_Last updated YYYY-MM-DD: <one line>._
- **Next:**

## Architecture conventions

- Content in `Assets/_Project/` (Scripts/Runtime, Scripts/Editor, Tests/EditMode, Art, Audio, Prefabs, Data, Scenes, UI, Input). Namespaces under `Game`.
- Tuning in ScriptableObjects under `Data/`; pure rules in plain C#; MonoBehaviours as glue.
- _(add "how to add a new X" recipes as systems appear)_
