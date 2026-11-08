# Gamedev workflow for Claude Code + Unity

Skills that make Claude Code a good partner for making Unity games, alone or as a team: it
**asks critical questions**, **challenges ideas but never overrules you**, builds **one small
playable slice at a time**, hands you a **playtest checklist**, keeps **your tuning values and
levels untouched**, and keeps the project's memory **small and findable** so every session
picks up where the last one stopped.

## What's inside

| Plugin | For | Skills |
|---|---|---|
| `gamedev-core` | **always install** | `design-partner`, `project-memory`, `slice-loop`, `unity-claude-rules`, `unity-architecture`, `unity-3d`, `owner-assets-git`, `setup-check` |
| `gamedev-jam` | game jams (1–3 weeks) | `jam-kickoff`, `jam-workflow`, `jam-ship` |
| `gamedev-solo` | long-term solo projects | `solo-kickoff`, `solo-workflow` |
| `gamedev-team` | shared repo, any team size (1–8) | `team-kickoff`, `team-workflow`, `team-onboarding`, `team-sync` + git safety hooks |

Install `gamedev-core` plus **one** mode plugin per project type.

## Before you start (once per computer)

1. **Claude Code** (desktop app or CLI) with a Claude subscription.
2. **Git** and **Git LFS** (`git lfs install` once). Team projects: **GitHub CLI** (`gh auth login`).
3. **Unity Hub** + an account. The Unity Editor itself can be installed later by Claude.
4. Recommended: **Blender** (3D) or **Aseprite** (pixel art), or any art tool you like.

## Install

### Solo or jam

In Claude Code (any project), run these one at a time. In the **desktop app**, the marketplace
must be given as a full `https://` URL:

```
/plugin marketplace add https://github.com/Adonoo/claude-gamedev-skills.git
```

```
/plugin install unity@claude-plugins-official
```

```
/plugin install gamedev-core@gamedev-workflow
```

```
/plugin install gamedev-jam@gamedev-workflow
```

(Swap the last one for `gamedev-solo` when that fits.) Restart Claude Code if the skills don't
show up. Updates: `/plugin marketplace update gamedev-workflow`.

### Team

The lead installs as above (with `gamedev-team`) and runs the kickoff. The kickoff writes
`.claude/settings.json` into the game repo, which declares this marketplace and the plugins.
Everyone else just clones the repo and trusts the folder in Claude Code — it offers to install
the same plugins. Then each member runs `/gamedev-team:team-onboarding`.

The `unity` plugin is Unity's official one: it lets Claude install the Editor, create projects
and drive your open Editor through the Unity CLI.

## First session

1. Make an empty folder for your game and open it in Claude Code.
2. Say: **"I'm new to Unity with Claude, check my setup"** → runs `setup-check`.
3. Say: **"Kick off the jam"** / **"kick off the team project"** (or run
   `/gamedev-jam:jam-kickoff`, `/gamedev-team:team-kickoff`).
4. Every later session: **"Let's continue"** (team: "let's continue with #12").

## How working with it feels

- Claude asks questions at the start of a feature. Answer them; say "your call" if you don't
  care. Beginners get fewer, simpler questions with a recommended default.
- It builds a small piece, then gives you a checklist: open this scene, do this, expect that,
  these values are tunable in this asset.
- You play and tell it how it feels in plain words ("jump too floaty", "can't see the exit").
- You tune numbers yourself in the Inspector. Claude won't touch them or your levels.
- When you're happy, you say "commit" (team: Claude opens a PR, a teammate playtests it).

## Where the project's memory lives

| What | Where |
|---|---|
| Rules, facts, commands, folder map | `CLAUDE.md` — short (≤ ~150 lines) |
| Who you are, how much to explain | `CLAUDE.local.md` — personal, git-ignored |
| What was decided and why | `docs/decisions/` — one file per decision |
| Lessons learned | `.claude/rules/` — loaded only for the files they're about |
| "How to add an X" | project skills in `.claude/skills/` |
| Status & next steps | GitHub issues/PRs (team) or `docs/status.md` (solo/jam) |

## Team hooks

`gamedev-team` ships hooks that are active in repos with a `TEAM.md`: they block
`git add -A`/`.`, `commit -a`, committing or pushing on `main`, force-push, `reset --hard`,
`clean -f`, `checkout .`; ask before Claude hand-edits scene/prefab YAML; and give each session
a short git status. A one-person team can allow commits on `main` with an empty file
`.claude/allow-main-commits`.

## Tips

- Keep Unity open while Claude works, save your scenes often, and tell Claude when you're about
  to play for a while.
- If something went wrong, tell Claude to add a lesson so it doesn't happen again.
- Ideas to improve these skills: open an issue or PR on this repo.
