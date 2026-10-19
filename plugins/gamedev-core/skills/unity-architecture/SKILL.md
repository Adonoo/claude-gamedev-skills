---
name: unity-architecture
description: Code and asset architecture conventions for Unity games built with Claude — project folder layout, assembly definitions, namespaces, pure-logic models with thin MonoBehaviour glue, ScriptableObject data and data-driven content, Input System usage, reproducible editor builders, tests, and C# style. Use when setting up a new Unity project's structure, adding a new system or content type, or when unsure where code, data or art should go.
---

# Unity architecture for Claude-assisted games

Goal: Claude can change rules safely (tests), the user can tune and add content without code
(data), and nothing depends on hidden scene state.

## Layout

```
Assets/_Project/
  Scripts/Runtime/   asmdef Game.Runtime
  Scripts/Editor/    asmdef Game.Editor (Editor only)
  Tests/EditMode/    asmdef referencing Game.Runtime
  Tests/PlayMode/
  Art/  Audio/  Prefabs/  Data/  Scenes/  Settings/  Input/  UI/
ArtSource/           raw source art outside Assets/ (Unity ignores it)
```

- Namespaces mirror folders under `Game` (`Game.Player`, `Game.Level`, `Game.UI`, ...).
- One public type per file, file name = type name.

## The core pattern: pure model + glue

- **Rules live in plain C# classes** (no `MonoBehaviour`, no `Time.deltaTime` inside — pass
  `dt` in). They are EditMode-unit-tested. Example: `PlayerMovementModel`, `RunClock`,
  `LootTable`, `Cooldowns`.
- **MonoBehaviours are thin glue**: read input, call the model, apply results to transforms,
  physics, visuals and UI.
- **Views are dumb**: UI and visuals display state; they don't decide game rules.
- New rule → change the model **and** add a test in the same step.

## Data

- **Tuning and content are ScriptableObjects** under `Data/` (public fields with `[Tooltip]`
  are fine for pure data assets). Designers tune in the Inspector; no gameplay constants in code.
- **Data-driven content**: a new item/enemy/upgrade = a new asset (plus, at most, a small
  behaviour class). No central `switch` that must be edited for each new thing.
- Modifiers that stack: one clear formula, e.g. `(base + Σflat) × (1 + Σpercent)`.
- When gameplay needs modified values (upgrades, difficulty), build a **runtime copy** of the
  base asset; never write the user's asset.
- Changing a default in code only affects newly created assets. To suggest a new value for an
  existing asset, propose it to the user.

## Time, physics, input

- Gameplay in `FixedUpdate` at a fixed rate (e.g. 100 Hz) for deterministic feel; interpolate
  visuals.
- Input via the **Input System** with an `.inputactions` asset and a generated C# class. Never
  `Input.GetKey` or hardcoded keys. Every action gets **keyboard/mouse and gamepad** bindings.
  Latch button presses in the reader and consume them per fixed step.
- Decide early which "time" each system uses (game time vs real time, e.g. for slow-motion,
  pause menus) and write it down.

## Reproducibility

- Test scenes, prefabs and kits are built by **Editor menu scripts** (`Game/Setup/...`), so they
  can be rebuilt. Builders create assets **only if missing** and upgrade existing prefabs
  **non-destructively** (add missing parts, never remove).
- Levels the user builds by hand are theirs; builders never touch them.

## Wiring

- Prefer composition: small single-purpose components.
- Explicit references, ScriptableObject event channels or a tiny service locator for true
  globals (run state, audio). Avoid singleton sprawl.
- No `Find` / `FindObjectOfType` in gameplay code. No allocations in per-frame hot paths.
- Anything that subscribes to a long-lived object (cross-scene state, static events) must
  unsubscribe in `OnDisable` / `OnDestroy`.

## Art & import

- Pixel art: Point filtering, no compression, one PPU for the whole project.
- Placeholder art is fine; keep sprite names stable so real art can replace it without
  re-wiring.
- If the user paints source files (e.g. Aseprite) inside `Assets/`, those files become the
  source and Claude's generated art for the same name steps aside.

## Style

- `[SerializeField] private` over public fields (exception: pure data ScriptableObjects).
- PascalCase types/methods/properties, `_camelCase` private fields, `camelCase` locals.
- Force Text serialization and visible meta files (Project Settings → Editor).
