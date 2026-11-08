---
name: team-onboarding
description: Bring a new member into an existing team Unity project with Claude, especially someone new to game development or to working with AI — tool setup, clone and open the exact Unity version, a personal CLAUDE.local.md with experience level, a guided tour of the game and the repo, the team's way of working in plain words, a practice round through the whole issue → branch → PR → playtest loop, and a first real issue. Use when someone joins the team, says they're new to the project, or asks "how do I start?" in a team repo.
---

# Team onboarding

Goal: after one session the new member has played the current game, knows where things are,
has been through the whole loop once with a tiny change, and has a first real issue. Go slowly,
one step at a time, and let them **do** the steps (with guidance) — watching Claude do
everything teaches nothing.

## 1. Tools

Run `gamedev-core:setup-check` (git, LFS, gh, Unity CLI, exact Editor version from
`ProjectSettings/ProjectVersion.txt`, Unity plugin, Smart Merge). Then:

```bash
gh repo clone <owner>/<repo> && cd <repo>
git lfs pull
```

Open the project in Unity Hub with the exact version (first import takes a while — explain
why: `Library/` is built locally and never committed). Trust the folder in Claude Code so the
team plugins from `.claude/settings.json` install.

## 2. Personal file

Create `CLAUDE.local.md` from `team-kickoff/references/CLAUDE.local.template.md` (team plugin): name,
GitHub handle, experience, how much to explain, preferences. Confirm it's git-ignored. Add the
member to `TEAM.md` in a small PR later (it's their first PR — see step 5).

## 3. Tour (15–20 minutes)

1. **Play** the current build or the start scene. Ask what they noticed — it's useful feedback.
2. **Folders**: `Assets/_Project/` areas, `Data/` (tuning), `Prefabs/`, `Scenes/` (who has
   what locked: `git lfs locks`), `ArtSource/`.
3. **Unity basics, only as needed** for a beginner: scene, GameObject, component, prefab,
   ScriptableObject asset, Inspector, Play mode (changes in Play mode are lost — except on
   ScriptableObject assets, which keep them).
4. **Where knowledge lives**: `docs/HOW-WE-WORK.md` (read it together), `TEAM.md` (who decides
   what), the 5 most important records in `docs/decisions/`, the board, `CLAUDE.md`.

## 4. How we work, in plain words

- Work comes from **issues**; you assign yourself, make a branch, and lock scenes you edit.
- Claude asks questions before building — answer them, or say "your call".
- Claude builds a small piece and gives a **playtest checklist**; you play and say how it feels.
- Nothing goes to `main` directly: a **pull request**, a teammate playtests it, then merge.
- Decisions that affect others go to the team (a `decision` issue or the weekly sync).
- Stuck for more than ~30 minutes? Ask in the team channel; that's normal, not failure.

## 5. Practice round (the whole loop, tiny change)

Pick something harmless, e.g. "add yourself to `TEAM.md`" or "tune one value in a test scene
you own". Walk through: issue → assign → branch → change → commit by path → push → PR with the
template → a teammate reviews → merge → delete branch. Explain each git step in one sentence.

## 6. First real issue

Pick a `good-first-issue` that matches their interest and doesn't touch core code (a greybox
level in their own scene, a data asset with tuning, a placeholder model through the import
pipeline, a UI screen mockup). Write the first handoff comment together at the end.

## For the lead

Tell the lead what went well and what was confusing — confusing steps are fixes for
`docs/HOW-WE-WORK.md` or the skills.
