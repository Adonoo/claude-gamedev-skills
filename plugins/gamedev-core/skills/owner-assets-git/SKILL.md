---
name: owner-assets-git
description: Protect people's own work in a Unity project — their tuned data values, hand-built levels and art — and keep git history clean. Use before any git commit or staging, at the start of each session, before changing ScriptableObject data assets, scenes or prefabs a person may have edited, and when setting up git, .gitignore, .gitattributes or Git LFS for a Unity project.
---

# Owner assets & git hygiene

People tune values and build levels in the Editor while Claude codes. Their changes must never
be overwritten, reverted or swept into Claude's commits.

## Who is "the owner"?

- **Solo / jam:** the user.
- **Team:** the person a file belongs to right now — the assignee of the issue that touches it,
  the holder of a scene lock, or the area owner listed in `TEAM.md`. Check `git log -3 --format=
  "%an %ar" -- <file>` before changing a data asset or scene: if someone else tuned it recently,
  propose the change to them instead of making it.

## What belongs to the owner

- **Tuning values** in data assets (e.g. everything under `Assets/_Project/Data/**`).
- **Hand-built levels/scenes** (e.g. `Assets/_Project/Scenes/Levels/**`).
- **Art they made** and anything they say is theirs.

Never change these unless the owner explicitly asks. Record the exact folders in CLAUDE.md
"How we work". To suggest a different value, **propose** it (asset, field, old → new, why).

## Session start

1. `git status` — look for modified files in the owner's areas.
2. If there are owner changes and you are about to commit anything, first commit theirs
   separately (with their agreement):
   - `Owner tuning: <what changed>` · `Owner level: <level> edits` · `Owner art: ...`
3. Then do your work.

## Committing

- **Commit only when the user asks or agrees.**
- **Stage by path.** `git add <file> <file>` — never `git add -A` / `git add .` / `git add --all`
  while other changes are in the working tree. (The team plugin's hook blocks these.)
- Include the `.meta` of every new or moved asset; never delete a `.meta` someone else created.
- Small, focused commits with clear messages ("Slice: wall jump", "Fix: door closes on player").
- Review `git diff --cached --stat` before committing; if something unexpected is staged, ask.
- **Pushing**: ask once what the push policy is and record it.
- Never rewrite published history, force-push, `reset --hard`, `checkout -- .` or `clean -fd`
  without explicit permission — they destroy unsaved or uncommitted Editor work.

## Setting up git for Unity

- `.gitignore`: `Library/`, `Temp/`, `Obj/`, `Build/`, `Builds/`, `Logs/`, `UserSettings/`,
  `MemoryCaptures/`, `Recordings/`, `*.csproj`, `*.sln`, `.vs/`, `.idea/`, `CLAUDE.local.md`,
  `.claude/settings.local.json`. Keep `Assets/`, `Packages/`, `ProjectSettings/`.
- `.gitattributes`: Unity YAML (`*.unity *.prefab *.asset *.mat *.anim *.controller *.meta`) as
  text with `eol=lf`; **Git LFS** for heavy binaries (audio, `*.psd`, `*.fbx`, `*.blend`,
  textures above a few hundred KB, fonts, video, `*.exr`). Small PNG / Aseprite files may stay
  in plain git. Run `git lfs install` once per machine. The team plugin ships a full template.
- LFS costs quota: every clone and CI checkout downloads LFS files and counts against the repo
  owner's bandwidth. Check the host's current free limits before a 3D project starts.
- Unity settings: **Asset Serialization = Force Text**, **Version Control = Visible Meta Files**.
- First commit right after project creation, before any feature work.
