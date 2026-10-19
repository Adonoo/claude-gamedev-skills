---
name: team-workflow
description: Session workflow for a member of a team working on a shared Unity repo with Claude — sync with main, stay inside your own areas, feature branches and small PRs, safe handling of scene/prefab/asset merge conflicts, coordinating shared-file changes and decisions across members, and keeping the shared CLAUDE.md consistent. Use at the start of each session in a team project, before touching shared files, when a merge conflict appears, before opening a PR, or when a design question involves another member's area.
---

# Team workflow

All `gamedev-core` skills apply; this adds the rules that keep several people (and their
Claudes) from stepping on each other.

## Session start

1. Identify the member (`CLAUDE.local.md`). Missing → ask name and areas, offer to create it.
2. `git status` — uncommitted changes? Ask before doing anything with them.
3. `git fetch` and update: on `main` → pull; on a feature branch → rebase/merge `main` in
   (ask which the team uses; record it). Resolve conflicts now, before new work.
4. Read CLAUDE.md: decisions changed since last time? Status of the areas you depend on?
5. Say in 2–3 lines what changed upstream that matters for this member, then propose the slice.

## Working

- **Own areas only.** If the slice needs a change in someone else's area, stop and draft a
  short request for that owner (what, why, smallest change) instead of making it. If the member
  says they've coordinated, make it as a separate, clearly named commit.
- **Shared files** (input actions, ProjectSettings, Packages manifest, shared prefabs, layers/
  tags, CLAUDE.md "How we work"): minimal change, separate commit, mention it in the PR so others
  pull it soon.
- **Scenes**: never edit a scene you don't own. For a new shared object, make a prefab.
- **New packages / engine settings**: ask the member to agree with the team first; they change
  everyone's project.
- Slice loop as usual (`slice-loop`): the playtest handoff goes to the member; anything that
  changes another area's feel also goes to that area's owner.

## Decisions across members

- A question in another member's area → write it into CLAUDE.md "Open questions" with
  **who decides**, and tell the member to ask them. Don't decide it.
- When a decision is made, record it with "Decided by <name>". If two decisions conflict, flag
  it to the member; don't silently pick one.

## Merge conflicts

- **C# / text**: resolve normally, then recompile and run the tests.
- **`.unity` / `.prefab` / `.asset`**: try Unity Smart Merge (mergetool). If it can't:
  take the version of the **area owner**, then redo the other change in the Editor. Never
  hand-merge YAML blindly; never drop a `.meta`.
- **CLAUDE.md**: keep both sides' decisions; if they contradict, keep both, mark them as
  conflicting in Open questions and ask.
- After any conflict: open the affected scenes from disk and check for missing references
  (pink/"Missing" components).

## Pull requests

- One slice per PR, small. Title = the slice. Body: what changed, how it was verified, the
  playtest checklist, shared files touched, decisions made.
- Run the `code-review` skill before opening it; fix real findings.
- Commit attribution and push only with the member's OK. Never force-push shared branches.
- After merge: update CLAUDE.md "Current status" for the area.

## Session end

Update the area's status row and Next; push the branch (if the member agrees) so others can
see work in progress.
