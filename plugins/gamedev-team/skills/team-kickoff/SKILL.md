---
name: team-kickoff
description: Start or restructure a long-term group game project where several people (each with their own Claude) work in one shared Unity repo — roles and area ownership, who decides what, branch and merge strategy, Unity scene/prefab merge safety, shared CLAUDE.md plus personal CLAUDE.local.md, and project setup. Use when a team starts a shared Unity project, adds members, or keeps running into merge conflicts or conflicting decisions.
---

# Team kickoff

In a team, every rule from `gamedev-core` still holds, but **"the owner" becomes "the owner of
that area"**, and most damage comes from two people (or two Claudes) touching the same file.
This kickoff is usually run by one person with the others present or answering async; record
everything in the shared CLAUDE.md.

## Round 1 — People & authority

- Members, roles, time zones, hours per week.
- **Decision map**: who has the final say on what (overall vision, game design per system,
  art direction, audio, code architecture, levels). One name per row. Disagreements go to the
  person on that row — Claude never picks a side, it lays out options.
- How the team communicates decisions (Discord channel? PR comments?), and that settled ones
  always land in CLAUDE.md.

## Round 2 — Areas & ownership

Split the project into **areas with one owner each**, matching folders where possible:

| Area | Owner | Folders |
|---|---|---|
| Player & movement | | `Scripts/Runtime/Player`, `Data/Player` |
| Levels | | `Scenes/Levels/<name>_*` |
| UI | | `UI/`, `Scripts/Runtime/UI` |
| Art | | `Art/`, `ArtSource/` |
| ... | | |

Rules that follow from it (write them into CLAUDE.md):

- Claude only edits areas of the person it's working for, unless that person coordinated it
  with the area owner. Shared files (input actions, project settings, shared prefabs, CLAUDE.md)
  are changed in **small separate commits** and announced.
- **One scene = one owner at a time.** Level scenes are named after/claimed by their owner.
  Shared things are **prefabs**, not scene objects; work in your own scene and reference
  prefabs, or use additive scenes.
- Tuning assets have an owner too; others propose values.

## Round 3 — Git strategy

- **Short-lived feature branches** (`<name>/<feature>`), merged via pull request after the
  slice is playtested. `main` always opens and plays.
- Pull/rebase from `main` at the start of every session.
- PR = one slice, small. Review with the `code-review` skill + a human skim; the area owner
  approves.
- **Unity merge safety** (do once per machine/repo):
  - Force Text serialization, visible meta files.
  - Configure Unity's **Smart Merge** (`UnityYAMLMerge`, shipped in the Editor's
    `Data/Tools` folder) as git mergetool for `.unity`, `.prefab`, `.asset`. Look up the exact
    config for the installed Editor version in Unity's "Smart merge" manual page.
  - Git LFS for binaries; consider `git lfs lock` for binary files two people might edit.
  - Never resolve a scene/prefab conflict by hand-editing YAML blindly: take one side, then
    redo the other side's change in the Editor, or ask the owner.
- `.meta` files always committed with their asset; never delete a `.meta` someone else
  created.

## Round 4 — Shared vs personal instructions

- `CLAUDE.md` (shared, committed): the team's rules, decisions, areas, status per area. Changes
  to the **How we work** section are agreed by the team.
- `CLAUDE.local.md` (personal, add to `.gitignore`): the person's own preferences, their
  name/role ("I'm <name>, I own Player & UI"), machine paths.
- Every member installs the same plugins (`gamedev-core`, `gamedev-team`, `unity`).

## Setup

- New project: `unity:new-unity-project` (one person), push, everyone clones.
- Copy `references/CLAUDE.team.template.md` to the root as `CLAUDE.md`, fill it in.
- Each member creates their `CLAUDE.local.md` from the snippet in the template.
- First commit + push; branch protection on `main` if the host allows.

## Hand-off

Summarise the decision map, areas and git rules; propose each member's first slice so they
don't overlap. Continue with `team-workflow`.
