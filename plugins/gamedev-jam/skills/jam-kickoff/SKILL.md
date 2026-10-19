---
name: jam-kickoff
description: Start a game jam project (roughly 1–3 weeks, small team or solo per project) with Claude — interpret the theme, pitch and critique concepts, lock a core loop, cut scope with a must/should/could list, plan milestones back from the deadline, create the Unity project and a jam CLAUDE.md. Use when the user is starting a game jam, has a jam theme, or says "kick off the jam".
---

# Jam kickoff

A jam is a **medium-rigor** project: real deadline, real game, but no long-term maintenance.
Core skills still apply (`gamedev-core:design-partner`, `slice-loop`, `unity-claude-rules`,
`owner-assets-git`, `project-memory`). This skill sets the jam up in about one session.
Ask in rounds with `AskUserQuestion`; don't dump everything at once.

## Round 1 — Facts

- Jam name, **theme** (if out), **deadline with time zone**, submission platform (itch.io?),
  required format (WebGL in browser? downloadable?), rules (assets allowed? team size?).
- How many hours per day realistically; days you're unavailable.
- Team for this project (names, who does art / audio / code / design) and who has the
  **final say** on design questions (default: the person running this session).
- Engine version (default: latest LTS, or what the group agreed — everyone the same).

## Round 2 — Concept

1. Unpack the theme: 5–8 interpretations, including one literal and two unexpected ones.
2. Pitch **3 concepts**, each: one-sentence verb ("you ___ to ___"), the hook, the core loop,
   art style, the riskiest unknown, rough scope (S/M/L).
3. **Critique each honestly**: scope risk for the time available, how fast it becomes fun,
   whether it reads to a player in 10 seconds, how well it fits the theme.
4. The user picks (or mixes). Write a 3–5 line **brief** and read it back.

## Round 3 — Scope

- **Core loop** in one sentence, and the **one mechanic that must feel great**.
- **Must / Should / Could** list. *Must* = the smallest version that is a complete, winnable
  game (start → play → end screen). Be ruthless; challenge every Must.
- Content target (levels/rooms/enemies) as a number, not "a lot".
- Art & audio approach: placeholder first, which free assets are allowed, the look in one line.
- Platforms & input: keyboard only? gamepad? browser (WebGL limits: no threads, size, audio
  starts after a click).

## Round 4 — Milestone plan (back from the deadline)

Adapt to the actual length; for ~2 weeks:

| When | Milestone |
|---|---|
| Day 1 | Concept, scope, project setup, first commit |
| Day 2–3 | **Core loop playable** in greybox; **first build** on the target platform |
| Day 4 | **Fun check**: play it. Is the core fun? Fix, pivot or cut — decide now |
| Day 5–9 | Musts complete, then Shoulds; content production; real art/audio coming in |
| Day 10 | **Feature freeze** — only content, bugs, juice from here |
| Day 11–12 | Polish: juice, audio, menus, onboarding/tutorial, difficulty pass, playtests by others |
| Day 13 | Release candidate build, itch page, screenshots/GIF |
| Day 14 | Buffer. **Submit hours early**, not minutes |

Write the plan with **real dates** into CLAUDE.md.

## Setup

- Create the project with the `unity:new-unity-project` skill (it installs the Editor in the
  background while you talk, sets up git). Use a 2D or 3D URP template as fits.
- Apply `gamedev-core:unity-architecture` (folders, asmdefs, input actions with KBM + gamepad,
  `Data/` for tuning).
- Copy `references/CLAUDE.jam.template.md` to the project root as `CLAUDE.md` and fill it in
  with everything from rounds 1–4.
- `.gitignore`, LFS, Force Text, visible meta (see `gamedev-core:owner-assets-git`).
- First commit. Ask about pushing to a remote (backup matters in a jam).

## Hand-off

End with: the brief, the Must list, today's date vs. the next milestone, and the first slice
proposal ("Slice 1: player moves and jumps in a greybox room"). Then continue with
`jam-workflow`.
