---
name: slice-loop
description: The feature loop for game development with Claude — one small vertical slice at a time through plan, implement, verify, owner playtest, fix and commit, with a precise playtest handoff. Use when starting, building, finishing or handing over any game feature, mechanic, level object, UI screen or visual effect, and when deciding whether something is "done".
---

# Slice loop

One feature at a time, all the way through, before starting the next:

```
plan → implement → verify (Claude) → playtest (owner) → fix → commit → update status
```

A slice is **vertical**: logic + data + visuals/UI + wiring in the scene, so the owner can play
it. "The code is written" is not a finished slice.

## 1. Plan

- Clarify open points first (see `design-partner`). For anything touching several systems, use
  plan mode and show the plan before writing code.
- Name the slice in one line and list what is **in** and **explicitly out**.
- List the **tuning values** you will expose (asset + field + default) — the owner will tune
  them later.
- If the work has independent parts, propose an order and say which part is playable first.

## 2. Implement

- Rules in pure, testable code; MonoBehaviours as glue; values in data assets
  (see `unity-architecture`).
- New content of an existing kind should need **only a new asset**, not a code change.
- Reuse existing patterns in the project before inventing new ones. Match the surrounding code.

## 3. Verify (Claude's part)

Claude verifies **correctness**, not feel:

- It compiles — check the Unity console, not just your own build output.
- Tests pass (pure logic has tests; write the test with the rule).
- It works **in the real scene, loaded from disk**, in Play mode — not only in the freshly
  built in-memory state.
- Timing/behavior measured **per frame inside Unity**, not by eyeballing CLI round-trips.
- Visual changes checked on a **render** (camera → PNG, upscaled to judge readability).

See `unity-claude-rules` for how to do each of these safely. Report honestly what was and
wasn't verified.

## 4. Playtest handoff (owner's part)

End every slice with a short checklist the owner can follow in Play mode:

```
**Playtest:** <scene to open>
1. <action> → expect <result>
2. <edge case> → expect <result>
**Feel to judge:** <the subjective part, e.g. "does the glide feel too floaty?">
**Tuning:** `<Asset>` → <Field> (default X), <Field> (default Y)
**Known gaps:** <what is placeholder / not done>
```

Then **wait**. Don't commit and don't start the next slice before the owner's verdict, unless
they say so.

## 5. Fix

Turn feedback into concrete changes (see `design-partner` → playtest feedback). Re-verify,
hand over again. Repeat until the owner approves.

## 6. Commit & record

- Commit only after the owner approves (or asks to commit).
- First commit any owner changes separately, then your own files by path
  (see `owner-assets-git`).
- Update CLAUDE.md: decisions settled during the slice, status line ("approved and committed"),
  new lessons, new "how to add X" recipes (see `project-memory`).

## Slice sizing

- Good: playable in one session, one new concept for the owner to judge.
- Too big: the owner can't tell which change caused what they feel. Split it.
- If a slice keeps growing, stop, show what's done, and ask whether to split.
