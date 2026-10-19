---
name: unity-claude-rules
description: Safety and verification rules for Claude working inside a Unity project while the user has the Editor open — driving the Editor through the Unity CLI instead of editing YAML, keeping .meta files and GUIDs, checking compile errors, not disturbing the user's Play mode or unsaved scenes, testing scenes loaded from disk, measuring per frame, simulating input with a virtual gamepad, and rendering screenshots for visual checks. Use before any change to Unity scenes, prefabs, assets or scripts, and whenever verifying behavior in Play mode.
---

# Working in Unity with Claude

The user works in the Editor **at the same time** as Claude. Most damage comes from forgetting
that. For CLI command syntax, use the official `unity:unity-cli` skill; this skill is about
**what to do and what never to do**.

## Editing assets

- **Drive the live Editor** (`unity command ...`, `eval`) or write Editor scripts instead of
  hand-editing `.unity` / `.prefab` / `.asset` YAML. Trivial YAML edits only (one field).
- **Every asset keeps its `.meta`.** Move/rename inside Unity (or move the `.meta` along), so
  GUIDs and references survive.
- **Before deleting or renaming a generated asset**, check that no scene references it —
  including the user's **new, unsaved** scenes. Prefer keeping GUIDs (replace the content,
  keep the file).
- Reproducible content (test rooms, prefabs, kits) is **built by Editor menu scripts** that
  create assets **only if missing**. Overwriting needs an explicit, separately named menu item.
- **Never write into the user's data assets** from code defaults or in Play mode:
  ScriptableObject changes made in Play mode **persist**. For experiments, use an
  `Instantiate`d runtime copy.

## Compile & console

- After every code change: recompile, then read the console. Not done until it's clean.
- If the CLI can't connect, the Editor may be in **Safe Mode** (compile errors): fix the
  errors in source, don't fall back to blind YAML edits.

## Respect the user's session

- **Never interrupt the user's Play mode.** If they're playing, wait until it has been stopped
  for a while.
- **While the user's open scene is dirty (unsaved)**: never switch scenes (`OpenScene` /
  `NewScene` Single), never run the test runner. Use **additive temp scenes** for checks and
  close them afterwards.
- Ask before anything that reloads domains or reimports a lot while they're mid-work.

## Verifying behavior

- **Test scenes loaded from disk** (reopen the saved scene), not only the in-memory state you
  just built.
- **Simulate like the real thing**: model tests must feed inputs/collisions the way the real
  component reports them (e.g. a wall hit every physics step while holding into the wall).
- **Measure per frame inside Unity** (hook `Application.onBeforeRender`, a component, or model
  events from an `eval`) and read the log afterwards. One CLI round-trip takes seconds — far too
  coarse for gameplay timing.
- **Input**: simulated key presses are unreliable while Unity is unfocused. Drive the model
  directly, or add a virtual `Gamepad` (`InputSystem.AddDevice<Gamepad>()` + `QueueStateEvent`),
  which reaches an unfocused Editor. Remove the device afterwards.
- **Visuals**: render a temporary camera into a `RenderTexture`, save a PNG, upscale (e.g. 3×)
  and look at it. Spawn temporary objects with `HideFlags.HideAndDontSave` so the scene stays
  clean. Some systems (2D lights, UI Toolkit) update late in the frame — force their update or
  wait a frame before capturing.
- **Feel is not verifiable by Claude.** Say what you measured; the owner judges the feel.

## CLI / eval gotchas

- Eval snippets have no `using`s: fully qualify types, call extension methods statically.
- Keep data between evals with `AppDomain.CurrentDomain.SetData/GetData`.
- Long scripts: write them to a file and run that file, instead of inline shell heredocs with
  mixed quotes.
- Recompile status may report "up to date" rather than "completed" — know what "done" looks like
  before polling.

## When something goes wrong

Add the lesson to CLAUDE.md "Verification lessons" with the date and what happened
(see `project-memory`). Tell the user plainly what broke and what you did about it.
