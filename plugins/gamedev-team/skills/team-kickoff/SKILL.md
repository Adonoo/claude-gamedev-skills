---
name: team-kickoff
description: Set up or restructure a shared Unity game project for a group of any size (1 to ~8 people, specialists or generalists) where each person works with their own Claude — roster and experience levels, who decides what, ownership by issue and scene locks, GitHub issues/board/PR flow, Unity merge safety and LFS, the repo scaffold (CLAUDE.md, TEAM.md, decision records, .claude/settings.json with plugins and hooks, PR and issue templates) and the first week's plan. Use when a team starts a shared Unity project, moves an existing project to this workflow, adds members, or keeps running into merge conflicts or conflicting decisions.
---

# Team kickoff

Every rule from `gamedev-core` still holds; in a team, **"the owner" becomes "whoever owns that
file right now"**, and most damage comes from two people (or two Claudes) touching the same
file or deciding the same thing differently. This kickoff is usually run by one person (the
**lead**) with the others present or answering async. Ask in rounds with `AskUserQuestion`.
It is about **how the team works**, not the game design — the concept gets its own session.

## Scale the process to the team

| Team | Reviews | Playtest of a PR | Areas |
|---|---|---|---|
| 1 | self-merge after own playtest | self | none |
| 2–3 | 1 teammate approves | the reviewer | optional |
| 4–6 | 1 teammate approves; architecture seams by the architecture decider | another teammate (rotate) | by folder, per issue |
| 7+ | area owner approves | area owner + one other | mandatory, durable |

Pick the row in round 1 and write it into `TEAM.md`. Grow into the next row when it hurts,
not before.

## Round 1 — People & decisions

- Members: name, GitHub handle, **experience** (Unity: none / some / solid; with Claude: none /
  some / solid), interests, hours per week, time zone. "Everyone does everything" is a valid
  answer — then roles are per issue, not per person.
- **Decision map**, as small as possible:
  - **Vision & tie-break** — one person. Breaks deadlocks, guards the pillars.
  - **Architecture seams** — one person (usually the most experienced coder). Decides how
    systems talk to each other (see `unity-architecture` → seams), packages, project settings.
  - **Everything inside an issue** — the issue's assignee, within the agreed design.
  - **Anything that changes another person's work or the pillars** — the team (weekly sync or
    an async `decision` issue with a 48 h window), recorded by whoever raised it.
- Where the team talks (Discord channel, etc.). Rule: a decision isn't real until it's a record
  in `docs/decisions/`.

## Round 2 — Ownership without a fixed org chart

- **Issue = ownership.** Whoever is assigned an issue owns the files that issue touches until
  it's merged. Two open issues must not plan to touch the same files; if they do, sequence them.
- **Scenes are locked**, not shared: `*.unity` is marked `lockable` in `.gitattributes`; you
  `git lfs lock` a scene before editing and unlock after merge. Lockable files are read-only
  until locked, which stops accidental edits (by people and by Claude). **Test locking in week
  1** with a throwaway scene: lock on one machine, try to edit on another.
- **Tuning assets**: owned by whoever's issue introduced them, listed in `TEAM.md` once they
  matter. Others propose values.
- Durable areas (a person owns "Enemies" for months) only once someone sticks with a system.

## Round 3 — GitHub flow

- Private repo; `main` protected (PR required, no force push). `main` must always open and
  play — a broken `main` is everyone's top priority.
- **Issues** for all work: templates `slice`, `bug`, `decision`. Labels: `slice`, `bug`,
  `decision`, `good-first-issue`, `needs-playtest`, `area:<x>`.
- **Board** (GitHub Projects): Backlog → Ready → In progress → Review & playtest → Done.
- Branches `<name>/<issue>-<slug>`, one slice per PR, squash merge, branch deleted after merge.
- Status, handoffs and open questions live **in issues and PRs**, never in CLAUDE.md.

## Round 4 — Unity & repo facts *(decide once)*

- Unity version (everyone exactly the same), render pipeline, 2D/3D. For 3D go through the
  "decide early" items in `gamedev-core:unity-3d` (controller, camera, lighting, art pipeline).
- LFS: which file types, and the host's current free storage/bandwidth limits. 3D assets eat
  quota fast (every clone downloads them). If it's tight: keep source files (`.blend`, `.psd`)
  in LFS only when needed, or agree on a paid plan/other host early.
- Smart Merge configured on every machine (see `gamedev-core:setup-check`).
- Builds: who makes the weekly build of `main` (rotate the **build captain**), where it's shared.

## Setup (the lead, one session)

1. Create the project with `unity:new-unity-project` (or audit an existing one against
   `gamedev-core:unity-architecture`; propose a migration, don't restructure without OK).
2. Copy from `references/` into the repo and fill them in:
   - `CLAUDE.team.template.md` → `CLAUDE.md` (keep it under ~150 lines)
   - `TEAM.template.md` → `TEAM.md`
   - `HOW-WE-WORK.template.md` → `docs/HOW-WE-WORK.md` (the human handbook)
   - `decision.template.md` → `docs/decisions/0000-template.md`, then one record per decision
     from rounds 1–4
   - `settings.template.json` → `.claude/settings.json` (plugins for everyone)
   - `lessons.template.md` → `.claude/rules/lessons.md`; `unity-editor.rules.md` →
     `.claude/rules/unity-editor.md`
   - `github/` → `.github/` (PR template, issue templates)
   - `gitattributes.template` → `.gitattributes`, `gitignore.template` → `.gitignore`
   - `CLAUDE.local.template.md` stays a template; each member makes their own.
3. Folder scaffold (`unity-architecture` layout, empty folders get a `.gitkeep`), Force Text,
   visible meta, the scale dummy prefab for 3D.
4. First commit, push, protect `main`, create labels and the board (`gh label create ...`,
   `gh project create ...` — ask before creating anything on GitHub), invite members.
5. Each member runs `/gamedev-team:team-onboarding`.

## Hand-off: the first week

Propose a plan that keeps people out of each other's files:

- **Lead**: the *walking skeleton* — bootstrap scene, player moves in a greybox room, camera,
  one build. Everything else hangs off this, so it comes first and alone.
- **Others** (in parallel, no overlap with the skeleton): onboarding, then `good-first-issue`s
  that teach the loop without touching core code — a greybox test level in their own scene, a
  data asset with tuning, a placeholder model through the import pipeline, a sound list.
- End of week 1: first weekly sync (`/gamedev-team:team-sync`), playtest the skeleton together,
  then the concept session decides the first real slices.
