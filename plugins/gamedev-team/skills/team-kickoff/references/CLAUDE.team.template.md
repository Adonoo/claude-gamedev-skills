# <Project name> — <one-line pitch>

## How we work (read first — applies to every member's Claude)

- **Know who you work for.** Read `CLAUDE.local.md` for the current member's name and areas. If it's missing, ask.
- **Ask before assuming; challenge, never overrule.** Final say per topic is in the Decision map. Between members, lay out options; never pick a side.
- **Stay in your areas.** Only edit areas owned by the current member. Shared files (input actions, ProjectSettings, shared prefabs, this file) change in small separate commits that are announced to the team.
- **One scene = one owner.** Never edit another member's scene. Shared content goes into prefabs.
- **Small vertical slices** on a feature branch: plan → implement → verify → playtest → fix → PR.
- **Game feel is judged by the area owner**; Claude says what to test and which values are tunable.
- **Tuning values and levels belong to their owners.** Propose; don't change.
- **Git:** pull/rebase `main` at session start; `git status` before work; stage by path, never `git add -A`; one slice per PR; never force-push shared branches.

## Decision map

| Topic | Final say |
|---|---|
| Vision / overall design | |
| Game design: <system> | |
| Art direction | |
| Audio | |
| Code architecture | |
| Levels | |

## Areas

| Area | Owner | Folders / scenes |
|---|---|---|
| | | |

## Verification lessons (learned the hard way)

-

## Project facts

- Unity <version> (everyone the same), <render pipeline>, Input System, Force Text, visible meta, Smart Merge configured.
- Repo: <url> · Branches: `<name>/<feature>` → PR → `main` · Reviews: area owner approves.
- Comms: <where decisions are discussed>.

## Game concept

<3–6 lines.> **Pillars:** 1. 2. 3.

## Design decisions

_(`YYYY-MM-DD — **Decision.** Detail. (Why. Decided by <name>.)`)_
-

## Open questions

- _(question — who decides)_
- **Awaiting confirmation:**

## Current status (per area)

_Last updated YYYY-MM-DD._

| Area | Status | Next |
|---|---|---|
| | | |

## Architecture conventions

- Content in `Assets/_Project/`; namespaces under `Game`; tuning in ScriptableObjects under `Data/`; pure rules in plain C# with EditMode tests; MonoBehaviours as glue.
- Cross-area communication through explicit interfaces / ScriptableObject event channels, documented here.
- _(add "how to add a new X" recipes)_

---

### `CLAUDE.local.md` snippet (each member, git-ignored)

```markdown
# Me
- I'm <name>. I own: <areas>. Final say on: <topics from the decision map>.
- My feature branch prefix: <name>/
- Preferences: <e.g. explain Unity concepts as you go / be brief>
```
