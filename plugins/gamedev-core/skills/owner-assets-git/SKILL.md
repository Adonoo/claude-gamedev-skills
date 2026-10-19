---
name: owner-assets-git
description: Protect the user's own work in a Unity project — their tuned data values, hand-built levels and art — and keep git history clean. Use before any git commit or staging, at the start of each session, before changing ScriptableObject data assets, scenes or prefabs the user may have edited, and when setting up git, .gitignore or Git LFS for a Unity project.
---

# Owner assets & git hygiene

The user tunes values and builds levels in the Editor while Claude codes. Their changes must
never be overwritten, reverted or swept into Claude's commits.

## What belongs to the user

- **Tuning values** in data assets (e.g. everything under `Assets/_Project/Data/**`).
- **Hand-built levels/scenes** (e.g. `Assets/_Project/Scenes/Levels/**`).
- **Art they painted** and anything they say is theirs.

Never change these unless the user explicitly asks. Record the exact folders in CLAUDE.md
"How we work". To suggest a different value, **propose** it (asset, field, old → new, why) and
let the user decide.

## Session start

1. `git status` — look for modified files in the user's areas.
2. If there are user changes and you are about to commit anything, first commit theirs
   separately (with their agreement):
   - `Owner tuning: <what changed>` for data assets
   - `Owner level: <level name> edits` for levels
   - `Owner art: ...` for art
3. Then do your work.

## Committing

- **Commit only when the user asks or agrees.**
- **Stage by path.** `git add <file> <file>` — never `git add -A` / `git add .` while the
  user's changes are in the working tree.
- Include the `.meta` of every new or moved asset.
- Small, focused commits with clear messages ("Slice: wall jump", "Fix: door closes on player").
- Review `git diff --cached --stat` before committing; if something unexpected is staged, ask.
- **Pushing**: ask the user once what the push policy is (only on request / after each verified
  commit) and record it in CLAUDE.md.
- Never rewrite published history, force-push or reset the user's changes without explicit
  permission.

## Setting up git for Unity

- `.gitignore` for Unity: ignore `Library/`, `Temp/`, `Obj/`, `Build/`, `Builds/`, `Logs/`,
  `UserSettings/`, `MemoryCaptures/`, `*.csproj`, `*.sln`, `.vs/`, `.idea/`. Keep `Assets/`,
  `Packages/`, `ProjectSettings/`.
- **Git LFS** for heavy binaries: audio (`*.wav`, `*.mp3`, `*.ogg`), `*.psd`, fonts (`*.ttf`,
  `*.otf`), video, large textures. Small PNG / Aseprite files can stay in plain git so they diff
  and merge cheaply. Run `git lfs install` once per machine.
- Unity settings: **Asset Serialization = Force Text**, **Version Control = Visible Meta Files**.
- First commit right after project creation, before any feature work.
