---
name: unity-3d
description: Conventions and verification for 3D Unity games built with Claude — units and scale, greyboxing, the character controller choice, cameras, scene composition with prefabs and additive scenes, lighting strategy and baked data, the Blender/FBX art pipeline, animation, physics layers, navigation, performance budgets, and how Claude checks 3D work with multi-angle renders. Use when starting a 3D Unity project, adding 3D content, models, materials, lights, characters, cameras or levels, or verifying anything visual or physical in 3D.
---

# Unity 3D with Claude

Everything in `unity-architecture` and `unity-claude-rules` applies. 3D adds three problems:
**heavy binary assets**, **scenes that conflict badly**, and **visual results Claude can't judge
from one picture**. Decide the items marked *(decide early)* in the kickoff and write each into
a decision record.

## Units, scale, orientation

- **1 Unity unit = 1 metre.** Player height, jump height, door widths in metres in the data
  assets. A reference "scale dummy" prefab (1.8 m capsule, 1 m cube) lives in
  `Prefabs/Debug/` for greyboxing and art checks.
- Imported models: a 1 m cube in Blender must arrive as 1 unit in Unity, Y up, facing +Z.
  Fix the exporter settings once, record them in `.claude/rules/art-import.md`, and keep an
  `AssetPostprocessor` that enforces import settings for `Art/Models/**`.

## Greybox first

- Levels start as **greybox**: ProBuilder (`com.unity.probuilder`) or primitives with a few
  flat greybox materials (floor / wall / hazard / interactable colours). Real art replaces it
  later without changing gameplay colliders.
- Colliders are **simple and separate** from render meshes (box/capsule, or a low-poly
  collision mesh). Never rely on a detailed MeshCollider for the player's ground.

## Character controller *(decide early)*

| Option | Good for | Watch out |
|---|---|---|
| `CharacterController` | classic action/platformer feel, stairs/slopes | not physics-driven; push other bodies yourself |
| Kinematic `Rigidbody` + own casts | precise feel, momentum games, testable model | you write grounding, slopes, steps |
| Dynamic `Rigidbody` | physics-heavy games (rolling, vehicles) | feel is harder to tune, less deterministic |

Whatever you pick: rules in a **pure model** (velocity in, intent in, result out) with EditMode
tests; the component only gathers collisions and applies results. Gameplay in `FixedUpdate`,
visuals interpolated (`Rigidbody.interpolation` or own interpolation).

## Cameras *(decide early)*

Cinemachine 3 for any camera that follows the player. Decide early: first person, third person
orbit, fixed/isometric, side-on. Camera-relative movement input is a model input (pass the
camera's forward/right in), not a `Camera.main` lookup inside the model.

## Scenes that a team can share

- **Bootstrap scene** (persistent: managers, audio, UI root) + **content scenes** loaded
  additively. A level can be split into sub-scenes (`Level01_Layout`, `Level01_Lighting`,
  `Level01_Gameplay`) so two people can work on one level at the same time.
- **Everything reusable is a prefab** (or prefab variant). Scenes contain prefab instances and
  layout, not one-off objects with lots of components.
- One person edits one scene at a time (see the team plugin for claiming/locking scenes).

## Lighting *(decide early)*

- Baked lighting writes **large generated files** (`LightingData.asset`, lightmap textures)
  next to the scene. Every bake by anyone changes them → conflicts and LFS usage.
- Default while prototyping: **realtime lights only, no bakes on feature branches.** When the
  look matters, choose: baked lightmaps / Adaptive Probe Volumes / realtime-only, and who bakes
  (one person, on `main`, before a build).
- Post-processing via URP Volumes (`unity:urp-postprocessing`); profiles are data assets.

## Art pipeline (models, textures, materials)

- Sources (`.blend`, `.psd`, `.spp`, `.kra`) live in `ArtSource/` (Git LFS, lockable). Unity
  gets **exported** files (`.fbx`, `.png`) in `Assets/_Project/Art/`. Don't import `.blend`
  directly: it needs Blender on every machine and re-imports on every save.
- Textures: power-of-two sizes, sensible max size per category (props 1k, hero 2k), sRGB off
  for masks/normal maps. Record these in `.claude/rules/art-import.md`.
- Materials: URP Lit (or one shared custom shader). Few materials, shared, under `Art/Materials`.
- Free asset packs are fine for placeholders: record source and licence in `CREDITS.md` when
  they're added.

## Animation

- Humanoid rigs + Animator for characters with many clips; for simple objects, code-driven
  tweens or Timeline. Animation *state* comes from the model (state, speed), the Animator only
  shows it — gameplay never waits on an animation event unless that's a recorded decision.
- Root motion: off by default (the model owns movement) unless decided otherwise.

## Physics, layers, navigation

- Layers and the collision matrix are a **shared file** (`ProjectSettings/TagManager.asset`,
  `DynamicsManager.asset`): changes in separate, announced commits. Write the layer table in
  CLAUDE.md "Project facts".
- NPC navigation: AI Navigation package (`unity:initialize-ai-navigation`); NavMesh data is
  generated → rebuild by a menu item, don't hand-edit.
- Collision bugs: use `unity:physics-3d-collision`.

## Performance budget

Write a budget once the target platform is known (frame time, draw calls, triangle count per
view, texture memory). Check with the Profiler at each milestone, not only at the end.

## How Claude verifies 3D work

- **Never judge 3D from one render.** For visual changes render at least: the **gameplay
  camera** view, a **top-down orthographic** view (layout, overlaps), and a **free 3/4 angle**
  (silhouette, scale next to the scale dummy). Spawn temporary cameras/objects with
  `HideFlags.HideAndDontSave`, render to a `RenderTexture`, save PNGs.
- Physics/gameplay: measure per fixed step inside Unity and log (positions, velocity, grounded
  state), then read the log. Drive input via a virtual `Gamepad` (see `unity-claude-rules`).
- Scale check for new models: bounds in metres vs the scale dummy, printed in the report.
- Say clearly what was **not** verified: feel, readability in motion, lighting mood — those go
  in the playtest checklist.
