---
paths:
  - "Assets/**"
  - "ProjectSettings/**"
  - "Packages/**"
---

# Unity Editor lessons for this project

<!-- Loaded when Claude works on Unity files. The general rules are in the
     gamedev-core:unity-claude-rules skill; add only what this project taught us.
     Format: YYYY-MM-DD — what happened — the rule. -->

- The member has the Editor open while Claude works: never switch scenes while their scene is
  unsaved, never interrupt Play mode, never run the test runner over an unsaved scene; use
  additive temp scenes for checks.
- ScriptableObject changes made in Play mode persist on disk: experiment on an `Instantiate`d copy.
- Before deleting or renaming an asset, search all scenes and prefabs for its GUID (incl. scenes
  on other members' branches if they're likely to use it); prefer keeping the GUID.
