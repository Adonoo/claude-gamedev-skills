---
name: slice-loop
description: The feature loop for game development with Claude — one small vertical slice at a time through plan, implement, verify, playtest, fix and commit (or pull request in a team), with a precise playtest handoff. Use when starting, building, finishing or handing over any game feature, mechanic, level object, UI screen or visual effect, and when deciding whether something is "done".
---

# Slice loop

One feature at a time, all the way through, before starting the next:

```
plan → implement → verify (Claude) → playtest (person) → fix → commit / PR → update status
```

A slice is **vertical**: logic + data + visuals/UI + wiring in the scene, so a person can play
it. "The code is written" is not a finished slice. **Team:** a slice = one issue = one branch =
one pull request (see `gamedev-team:team-workflow`).

## 1. Plan

- Clarify open points first (see `design-partner`). For anything touching several systems, use
  plan mode and show the plan before writing code.
- Name the slice in one line and list what is **in** and **explicitly out**.
- List the **files and folders** it will touch. In a team, anything outside the issue's area is
  flagged now, before building.
- List the **tuning values** you will expose (asset + field + default).
- If the work has independent parts, propose an order and say which part is playable first.

## 2. Implement

- Rules in pure, testable code; MonoBehaviours as glue; values in data assets
  (see `unity-architecture`).
- New content of an existing kind should need **only a new asset**, not a code change.
- Reuse existing patterns before inventing new ones. Match the surrounding code.
- No refactors outside the slice. Spotted something worth fixing elsewhere? Note it as a
  follow-up (issue / status), don't do it now.

## 3. Verify (Claude's part)

Claude verifies **correctness**, not feel:

- It compiles — check the Unity console, not just your own build output.
- Tests pass (pure logic has tests; write the test with the rule).
- It works **in the real scene, loaded from disk**, in Play mode.
- Timing/behavior measured **per frame inside Unity**, not by eyeballing CLI round-trips.
- Visual changes checked on **renders** (3D: several angles, see `unity-3d`).

See `unity-claude-rules` for how to do each safely. Report honestly what was and wasn't verified.

## 4. Playtest handoff

End every slice with a short checklist a person can follow in Play mode. Write it so **someone
who didn't build it** can follow it — in a team it goes into the PR and a teammate runs it too.

```
**Playtest:** <scene to open>
1. <action> → expect <result>
2. <edge case> → expect <result>
**Feel to judge:** <the subjective part, e.g. "does the glide feel too floaty?">
**Tuning:** `<Asset>` → <Field> (default X), <Field> (default Y)
**Not verified by Claude:** <e.g. real gamepad feel, lighting mood>
**Known gaps:** <what is placeholder / not done>
```

Then **wait**. Don't commit and don't start the next slice before the verdict, unless the person
says so.

## 5. Fix

Turn feedback into concrete changes (see `design-partner` → playtest feedback). Re-verify,
hand over again. Repeat until approved.

## 6. Commit / PR & record

- Commit only after approval (or when asked). First commit the person's own changes
  separately, then your files by path (see `owner-assets-git`).
- Team: open or update the PR with the playtest checklist; the slice is done when it's merged.
- Record decisions settled during the slice, new lessons, new recipes (see `project-memory`),
  and update the status.

## Slice sizing

- Good: playable in one session, one new concept to judge. Team: a PR a teammate can review and
  playtest in ~15 minutes.
- Too big: nobody can tell which change caused what they feel. Split it.
- If a slice keeps growing, stop, show what's done, and ask whether to split.
