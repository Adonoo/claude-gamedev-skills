---
name: setup-check
description: First-time onboarding for someone new to making Unity games with Claude Code — checks that the tools are installed and connected (Unity Hub/Editor in the project's exact version, Unity CLI, the Editor connection, the official Unity plugin, git, Git LFS, GitHub CLI, Unity Smart Merge) and explains in plain words how to work with Claude on a game. Use when the user says they are new, asks how to get started, asks "is my setup ok?", joins an existing project, or when Unity CLI, git or gh commands fail because something isn't installed.
---

# Setup check & onboarding

Walk the user through this **one step at a time**. Run checks yourself; only ask the user to act
where you can't (installers with UI, sign-ins, licenses). Explain each tool in one sentence the
first time it appears. Assume they've never used Unity with Claude. In a team project, the
`gamedev-team:team-onboarding` skill runs this first and then gives the project tour.

## 1. Check the tools

Run these and report a short table (tool / found? / what to do):

```bash
git --version
git lfs version
gh --version && gh auth status
unity --version
unity auth status
unity editors --installed
```

- **git** missing → install Git for Windows / Xcode CLT / package manager, then reopen the shell.
- **git lfs** missing → install Git LFS, then `git lfs install` once.
- **gh** (GitHub CLI) missing or logged out → install it, `gh auth login`. Needed for issues and
  pull requests in team projects; optional for solo.
- **unity** (Unity CLI) missing → install it following the `unity:unity-cli` skill's install
  section, open a new shell, re-check.
- Not signed in / no license → `unity auth login`, then a Personal license (see `unity:unity-cli`).
- **Editor version**: inside an existing project, read `ProjectSettings/ProjectVersion.txt` and
  install **exactly** that version (with the target platform modules). A different version
  re-imports and re-serializes files and causes noisy diffs for everyone. New project: latest
  LTS, or the version the team agreed on.

## 2. Check the Claude side

- The official **Unity plugin** (`unity@claude-plugins-official`) provides `unity-cli`,
  `new-unity-project` and many Unity skills. If skills named `unity:*` are missing, tell the user
  to run `/plugin install unity@claude-plugins-official`.
- This workflow's plugins: `gamedev-core` plus exactly **one** mode plugin
  (`gamedev-jam`, `gamedev-solo` or `gamedev-team`).
- In a team repo the plugins are declared in `.claude/settings.json`
  (`extraKnownMarketplaces` + `enabledPlugins`): when the user trusts the folder, Claude Code
  offers to install them. If that didn't happen, install them by hand with `/plugin`.
- `CLAUDE.local.md` exists? If not, offer to create it (name, experience level, how much to
  explain — see section 5). Check it's in `.gitignore`.

## 3. Check git for Unity (inside a project)

```bash
git config --get merge.tool
git lfs locks 2>/dev/null | head -3
```

- **Smart Merge**: Unity ships `UnityYAMLMerge` in the Editor's `Data/Tools` folder. Configure
  it once per machine as the git mergetool for scenes/prefabs/assets, following Unity's "Smart
  merge" manual page for the installed version (it lists the exact `.gitconfig` lines). Typical
  shape — verify the path and flags against the manual:
  ```
  [merge]
      tool = unityyamlmerge
  [mergetool "unityyamlmerge"]
      trustExitCode = false
      cmd = '<Editor>/Data/Tools/UnityYAMLMerge' merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
  ```
- **LFS locks** reachable (team projects that lock scenes): `git lfs locks` must not error.

## 4. Check the Editor connection (once a project exists)

With the project open in Unity:

```bash
unity status
```

If the project isn't connected, add the bridge package once: `unity pipeline install` (see
`unity:unity-cli`). If it was connected before but now fails, look for compile errors
(Safe Mode).

## 5. How much should Claude explain?

Ask once and write it to `CLAUDE.local.md` as `Experience:` and `Explain:`:

- **New to Unity** → explain each Unity concept the first time (GameObject, component, prefab,
  ScriptableObject, scene, Inspector), and let the user do small Editor steps themselves with
  guidance instead of doing everything for them. Ask fewer, simpler design questions, always
  with a recommended default.
- **Knows Unity, new to Claude** → explain the workflow, not the engine.
- **Experienced** → be brief.

## 6. Explain how we work (short, in your own words)

- **You decide, Claude builds and challenges.** Claude asks questions before building and
  points out risks; answer them — that's the point. Say "your call" when you don't care.
- **One feature at a time.** Claude builds a small playable piece, then gives you a checklist
  to playtest. You play, say how it feels, Claude fixes, then you agree to commit.
- **Tune values yourself** in the Inspector (ScriptableObject assets under `Data/`). Claude
  won't touch your values or your levels.
- **Keep Unity open** while Claude works, save your scenes often, and tell Claude before you
  play for a long time.
- **Feedback in player words** is perfect: "the jump feels floaty", "I can't see where to go".
- **Shared memory** is in the repo: `CLAUDE.md` (rules), `docs/decisions/` (what we decided),
  status in issues (team) or `docs/status.md` (solo). Correct them when they're wrong.
- **Start each session** with "let's continue" — Claude reads the status and picks up.

## 7. Next step

Offer the kickoff of the installed mode plugin (`/gamedev-jam:jam-kickoff`,
`/gamedev-solo:solo-kickoff` or `/gamedev-team:team-kickoff`), or in an existing team project
`/gamedev-team:team-onboarding`.
