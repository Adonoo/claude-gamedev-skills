# Design notes 0.2 — from solo 2D to a 4-person 3D team

_2026-11-08. Why the skills changed, what was kept, and how to roll it out._

## What this is based on

- These skills (0.1.0).
- The Unity project `ClaudeCoProject` (2D roguelite, 2026-10-03 → 10-15): `CLAUDE.md` 54 KB,
  158 EditMode tests, pixel pipeline, level kit, themes.
- The Godot port of the same game (2026-10-30 → 11-06): `CLAUDE.md` 69 KB, 180 tests, headless
  verify scripts, the personal `pixel-art` skill.

## What worked — kept as is

- **Design partner** (ask, challenge, never overrule) and **decisions with a why**. The 2D
  project's decision log is why a whole engine port kept the design intact.
- **Slice loop with owner playtests.** Almost every slice ended "owner playtested, approved".
- **Owner tuning is untouchable** + runtime copies of data assets.
- **Pure model + thin glue + tests.** The movement model was ported 1:1 between engines
  because the rules were in testable plain code.
- **Reproducible builders** that create only what's missing.
- **Verification lessons**: scenes from disk, per-frame measurement, virtual gamepad, renders,
  "never touch the owner's dirty scene".

## Problems found

1. **CLAUDE.md became a changelog.** 54 KB and 69 KB, most of it "Current status" paragraphs
   and every decision ever made. All of it loads into every session; Claude Code's guidance is
   under ~200 lines per file. With 4 people it would also be the most-conflicted file in the
   repo. → `project-memory` now splits it: short CLAUDE.md, `docs/decisions/` (one file per
   decision), `.claude/rules/` (path-scoped lessons), status in issues / `docs/status.md`,
   recipes as project skills.
2. **Rules lived only as text.** "Never `git add -A`" was repeated in four files. Text is
   guidance, not enforcement. → `gamedev-team` hooks block the dangerous git commands and ask
   before hand-editing Unity YAML.
3. **One owner who knows Unity.** The workflow assumed the person driving Claude can judge its
   output and tune feel. Beginners can't yet, and every review would land on the lead. →
   experience level in `CLAUDE.local.md`; fewer, simpler questions for beginners; Claude teaches
   as it goes and lets them do Editor steps; PRs are playtested by a teammate; a
   `team-onboarding` skill with a full practice round.
4. **Fixed areas and one decider per topic** don't fit four generalists. → ownership by
   **issue** (the assignee owns the files) + **scene locks**; a minimal decision map (vision,
   architecture seams, issue details, team decisions); a size table from 1 to 7+ people.
5. **Shared status file.** → status, handoffs and open questions go into GitHub issues and PRs.
6. **2D only.** → new `unity-3d` skill (scale, greybox, controller choice, cameras, additive
   scenes, lighting and baked data, Blender/FBX pipeline, animation, layers, navigation,
   performance, multi-angle verification). 2D specifics moved into one section of
   `unity-architecture`.
7. **Personal paths and tools in shared files** (`C:\Users\noahp\...`, `F:\SteamLibrary\...`,
   a personal user skill). Teammates' machines differ. → machine paths go to
   `CLAUDE.local.md`; anything the team relies on must live in the repo or this marketplace.
8. **"Awaiting confirmation" items aged for weeks** (the wall-momentum interpretation from
   10-03 was still unconfirmed on 11-06). → health checks ask the decider to confirm or change.
9. **Plugins installed by hand on each machine.** → the kickoff writes `.claude/settings.json`
   with `extraKnownMarketplaces` + `enabledPlugins`; teammates get them when they trust the folder.
10. **LFS quota.** GitHub Free includes 10 GiB LFS storage and 10 GiB download bandwidth per
    month for the repo owner, and every clone or CI run counts. 3D assets × 4 people × fresh
    clones can hit that. → called out in the kickoff; decide early.
11. **Four Claudes, four architectures.** Each session "matches surrounding code", but four
    parallel sessions can invent four patterns at once. → an **architecture seams** decider,
    recipes as shared project skills, no refactors outside the slice, teammate review.
12. **"Ask many critical questions" was one person's preference**, written as a project rule.
    → it's now sized per person.

## The team loop

```
issue (Ready) → assign + branch + lock scenes → Claude plans/asks → build → Claude verifies
→ member playtests → draft PR + handoff comment → ready PR (checklist) → teammate playtests
+ reviews → squash merge → unlock, close issue → decisions recorded in docs/decisions/
```

Weekly sync (`team-sync`): play `main` together, decide open decisions, plan the week so no two
issues touch the same files, 5-minute retro → rules.

## Rollout

| When | Who | What |
|---|---|---|
| Now | lead | Review this diff, commit, push. `/plugin marketplace update gamedev-workflow`. |
| Week 0 | lead + 1 friend | `team-kickoff` in a new repo. Test: hooks fire in Claude Code on Windows (Git Bash); `git lfs lock` on a `.unity` file works on GitHub and makes it read-only on the other machine; Smart Merge on a deliberate prefab conflict. Fix the skills where reality differs. |
| Week 1 | everyone | `team-onboarding` for the other three. Lead builds the walking skeleton alone; others do good-first-issues in their own scenes. First `team-sync`. |
| Weeks 2–3 | everyone | Concept session, then real slices. Note every friction point. |
| Week 4 | everyone | Workflow retro: keep / change / drop. Decide on CI and the dashboard (below). |

## A custom webapp?

What it would do that GitHub doesn't already: one screen with **who has which scene locked,
which PRs wait for my playtest, the latest build to download**, and a **playtest feedback form**
for people who don't want to touch git.

Recommendation: **not yet.** Use GitHub Issues + Projects for 2–3 weeks first; the board,
labels and PR templates cover most of it, and building a tool now takes time away from the
game. If the gaps above still hurt in the week-4 retro, build a small **read-only** dashboard
over the GitHub API (locks, PRs by label, releases). Never make it a second source of truth:
Claude reads the repo and GitHub, so state that lives only in the app is invisible to every
member's Claude.

## Later

- **CI** (e.g. GameCI on GitHub Actions) for EditMode tests and builds on PRs. Check Unity
  license activation for CI and cache LFS so CI doesn't eat the bandwidth quota.
- **Solo/jam templates** still put decisions and status into CLAUDE.md. Align them with the new
  `project-memory` (decisions → `docs/decisions/`, status → `docs/status.md`) in a follow-up.
- **Migrate the two 2D projects' CLAUDE.md files** with the new "Migrating an old CLAUDE.md"
  steps, if they continue.
- Consider merging `gamedev-solo` into `gamedev-team` (a team of one) once the team mode has
  proven itself.
