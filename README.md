# Gamedev workflow for Claude Code + Unity

Skills that make Claude Code a good partner for making Unity games: it **asks critical
questions**, **challenges ideas but never overrules you**, builds **one small playable slice at
a time**, hands you a **playtest checklist**, keeps **your tuning values and levels untouched**,
and keeps a living **`CLAUDE.md`** so every session picks up where the last one stopped.

## What's inside

| Plugin | For | Skills |
|---|---|---|
| `gamedev-core` | **always install** | `design-partner`, `project-memory`, `slice-loop`, `unity-claude-rules`, `unity-architecture`, `owner-assets-git`, `setup-check` |
| `gamedev-jam` | game jams (1–3 weeks) | `jam-kickoff`, `jam-workflow`, `jam-ship` |
| `gamedev-solo` | long-term solo projects | `solo-kickoff`, `solo-workflow` |
| `gamedev-team` | long-term team projects in one shared repo | `team-kickoff`, `team-workflow` |

Install `gamedev-core` plus **one** mode plugin per project type.

## Before you start (once per computer)

1. **Claude Code** (desktop app or CLI) with a Claude subscription.
2. **Git** and **Git LFS** (`git lfs install` once).
3. **Unity Hub** + an account. The Unity Editor itself can be installed later by Claude.
4. Recommended: **Aseprite** or any pixel/art tool you like.

## Install

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

(Swap the last one for `gamedev-solo` or `gamedev-team` when that fits.) Restart Claude Code
if the skills don't show up. Updates: `/plugin marketplace update gamedev-workflow`.

The `unity` plugin is Unity's official one: it lets Claude install the Editor, create projects
and drive your open Editor through the Unity CLI.

## First session

1. Make an empty folder for your game and open it in Claude Code.
2. Say: **"I'm new to Unity with Claude, check my setup"** → runs `setup-check`.
3. Say: **"Kick off the jam"** (or run `/gamedev-jam:jam-kickoff`) → concept questions,
   scope, milestone plan, Unity project, `CLAUDE.md`, first commit.
4. Every later session: **"Let's continue"**.

## How working with it feels

- Claude asks a lot of questions at the start of a feature. Answer them; say "your call" if you
  don't care.
- It builds a small piece, then gives you a checklist: open this scene, do this, expect that,
  these values are tunable in this asset.
- You play and tell it how it feels in plain words ("jump too floaty", "can't see the exit").
- You tune numbers yourself in the Inspector. Claude won't touch them or your levels.
- When you're happy, you say "commit" — your own changes get their own commit.
- `CLAUDE.md` in your project is the shared memory. Read it now and then; fix it if it's wrong.

## Tips

- Keep Unity open while Claude works, save your scenes often, and tell Claude when you're about
  to play for a while.
- If something went wrong, tell Claude to add a lesson to `CLAUDE.md` so it doesn't happen
  again.
- Ideas to improve these skills: open an issue or PR on this repo.
