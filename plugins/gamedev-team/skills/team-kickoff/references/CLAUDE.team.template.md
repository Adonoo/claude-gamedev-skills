# <Project name> — <one-line pitch>

<!-- Shared by every member's Claude. Keep under ~150 lines.
     Status & handoffs → GitHub issues/PRs. Decisions → docs/decisions/. Lessons → .claude/rules/.
     Recipes → .claude/skills/. Humans: read docs/HOW-WE-WORK.md. -->

@TEAM.md

## How we work (read first — applies to every member's Claude)

- **Know who you work for.** Read `CLAUDE.local.md` (name, handle, experience). Missing → ask.
- **Ask before assuming; challenge, never overrule.** Search `docs/decisions/` before asking. Deciders are in `TEAM.md`; between members lay out options, never pick a side.
- **Work comes from issues.** One issue = one branch `<name>/<n>-<slug>` = one PR. Status and handoffs go into the issue/PR, not into this file.
- **Stay inside your issue's files.** Changes elsewhere → a request to that file's owner. Shared files (ProjectSettings, Packages, input actions, layers, shared prefabs, `.claude/`, this file) → small separate commits, called out in the PR.
- **Scenes are locked** (`git lfs lock`) before editing and unlocked after merge. Never edit a scene locked by someone else.
- **Tuning values and levels belong to their owners.** Propose; don't change.
- **Small vertical slices**: plan → implement → verify → playtest → PR → teammate playtest → merge.
- **Feel is judged by people.** Every PR carries a playtest checklist someone else can follow.
- **Git:** `git status` first; stage by path; never on `main`; never force-push.
- **Explain as much as the member's `Explain:` level asks for.**

## Project facts

- Unity <exact version> (everyone the same), URP <3D>, Input System, Force Text, visible meta, Smart Merge.
- Physics layers: <table or "see decision 000X">.
- Repo: <url> · Board: <url> · Comms: <channel>.
- Unity CLI: drive the open Editor via the `unity:unity-cli` skill.

## Commands

- Compile: `unity command recompile` → `recompile_status` (done = `up_to_date`)
- Tests: `unity command run_tests --mode EditMode` (never while the member's scene is unsaved)
- Build: <menu item / command> → `Builds/` (git-ignored)

## Map

- `Assets/_Project/` — content by area: `Scripts/Runtime/<Area>`, `Data/<Area>`, `Prefabs/<Area>`, `Scenes/` (bootstrap + content scenes).
- `ArtSource/` — `.blend`, `.psd` sources (LFS, lockable). Exports go to `Assets/_Project/Art/`.
- `docs/decisions/` — locked decisions. `docs/HOW-WE-WORK.md` — the human handbook.
- `.claude/rules/` — lessons (path-scoped). `.claude/skills/` — project recipes ("add an enemy", "new level").

## Concept

<3–5 lines.> **Pillars:** 1. … 2. … 3. …
