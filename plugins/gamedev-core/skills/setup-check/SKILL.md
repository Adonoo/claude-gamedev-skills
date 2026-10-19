---
name: setup-check
description: First-time onboarding for someone new to making Unity games with Claude Code — checks that the tools are installed and connected (Unity Hub/Editor, Unity CLI, the Editor connection, the official Unity plugin, git and Git LFS) and explains in plain words how to work with Claude on a game. Use when the user says they are new, asks how to get started, asks "is my setup ok?", or when Unity CLI commands fail because something isn't installed.
---

# Setup check & onboarding

Walk the user through this **one step at a time**. Run checks yourself; only ask the user to act
where you can't (installers with UI, sign-ins, licenses). Explain each tool in one sentence the
first time it appears. Assume they've never used Unity with Claude.

## 1. Check the tools

Run these and report a short table (tool / found? / what to do):

```bash
git --version
git lfs version
unity --version
unity auth status
unity editors --installed
```

- **git** missing → install Git for Windows / Xcode CLT / package manager, then reopen the shell.
- **git lfs** missing → install Git LFS, then `git lfs install` once.
- **unity** (Unity CLI) missing → install it following the `unity:unity-cli` skill's install
  section, open a new shell, re-check.
- Not signed in / no license → `unity auth login`, then a Personal license (see `unity:unity-cli`).
- No Editor → ask which version (default: latest LTS, or the version the team agreed on) and
  install it in the background with the target platform modules (e.g. WebGL for itch.io).

## 2. Check the Claude side

- The official **Unity plugin** (`unity@claude-plugins-official`) should be installed — it
  provides `unity-cli`, `new-unity-project` and many Unity skills. If skills named `unity:*` are
  missing, tell the user to run `/plugin install unity@claude-plugins-official`.
- This workflow's plugins: `gamedev-core` plus exactly **one** mode plugin
  (`gamedev-jam`, `gamedev-solo` or `gamedev-team`).

## 3. Check the Editor connection (once a project exists)

With the project open in Unity:

```bash
unity status
```

If the project isn't connected, add the bridge package once: `unity pipeline install` (see
`unity:unity-cli`). If it was connected before but now fails, look for compile errors
(Safe Mode).

## 4. Explain how we work (short, in your own words)

- **You decide, Claude builds and challenges.** Claude will ask questions before building and
  point out risks; answer them — that's the point. Say "your call" when you don't care.
- **One feature at a time.** Claude builds a small playable piece, then gives you a checklist
  to playtest. You play, say how it feels, Claude fixes, then you agree to commit.
- **Tune values yourself** in the Inspector (ScriptableObject assets under `Data/`). Claude
  won't touch your values or your levels.
- **Keep Unity open** while Claude works, but tell Claude before you hit Play for a long session;
  save your scenes often.
- **Feedback in player words** is perfect: "the jump feels floaty", "I can't see where to go".
- **CLAUDE.md** in the project root is the shared memory: decisions, status, rules. Read it
  sometimes; correct it when it's wrong.
- **Start each session** with "let's continue" — Claude reads the status and picks up.

## 5. Next step

Offer the kickoff of the installed mode plugin (`/gamedev-jam:jam-kickoff`,
`/gamedev-solo:solo-kickoff` or `/gamedev-team:team-kickoff`).
