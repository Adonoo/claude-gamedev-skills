---
name: solo-kickoff
description: Start a long-term solo game project with Claude as design partner — vision and pillars, references, the core-loop question rounds, a "first playable" scope, a slice roadmap, Unity project setup and a full CLAUDE.md with decision log. Use when the user starts a new personal game project meant to run for months, or wants to restructure an existing solo project around this workflow.
---

# Solo long-term kickoff

Long projects live or die by **shared understanding that survives sessions**. Spend the first
session(s) on questions, not code. Use the core skills throughout
(`gamedev-core:design-partner`, `project-memory`, `slice-loop`, `unity-architecture`,
`unity-claude-rules`, `owner-assets-git`).

Ask in rounds with `AskUserQuestion`; expect several rounds. Challenge vague answers.

## Round 1 — Vision

- The game in one sentence; the **feel reference** ("X but in 2D", "Y meets Z").
- **3 pillars**: what every feature must serve (e.g. "speed", "clean readability",
  "no combat"). Pillars are the tool for saying no later.
- Who it's for and why they'd keep playing.
- The user's own goal: shipping? learning? exploring a technique? (changes how much polish and
  rigor are worth it).

## Round 2 — Core loop & structure

- Moment-to-moment: what does the player do every second?
- Session loop: what is one run/level/day?
- Long loop: progression, unlocks, meta.
- What is **handmade vs generated**; where randomness is allowed and where it isn't.
- Controls on each input device (both first-class?).

## Round 3 — Presentation & tech

- Art style (pixel? resolution? palette?), camera, lighting, UI framework.
- Who makes art/audio; placeholder policy; source files and who owns them.
- Engine version, render pipeline, target platforms.

## Round 4 — First playable & roadmap

- **First playable**: the smallest version that tests whether the core is fun.
- A **slice roadmap**: ordered list of vertical slices to reach it (each playable on its own).
  Mark the riskiest assumption and put its slice early.
- Record what is explicitly **later** (so it stops coming up).

## Setup

- New project → `unity:new-unity-project`. Existing project → audit it against
  `gamedev-core:unity-architecture` and propose a migration plan (don't restructure without OK).
- Copy `references/CLAUDE.solo.template.md` to the project root as `CLAUDE.md` and fill it with
  every answer, each decision dated.
- git + LFS + `.gitignore` + Force Text + visible meta; first commit; ask about a remote and the
  push policy.
- Reproducible test scene via an Editor builder (`Game/Setup/Build Test Room`), so mechanics can
  be tried without the user's levels.

## Hand-off

Summarise: pillars, first playable, slice 1. Then continue with `solo-workflow`.
