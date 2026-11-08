---
name: team-workflow
description: Session workflow for one member of a team working on a shared Unity repo with Claude — session start (who am I, what changed on main, what's waiting for me), claiming an issue and locking scenes, staying inside the issue's files, feature branches and small PRs with a teammate playtest, handoff notes in the issue, coordinating shared files and cross-member decisions, and safe handling of scene/prefab/asset merge conflicts. Use at the start of each session in a team project ("let's continue", "what's next"), when picking up or finishing an issue, before touching shared files, when a merge conflict appears, before opening or reviewing a PR, or when a question involves another member's work.
---

# Team workflow

All `gamedev-core` skills apply; this adds what keeps several people (and their Claudes) from
stepping on each other. Status lives in **GitHub issues and PRs**, not in CLAUDE.md.

## Session start

1. **Who am I?** Read `CLAUDE.local.md` (name, GitHub handle, experience). Missing → ask and
   offer to create it from the team plugin's template.
2. `git status` — uncommitted changes? Ask before doing anything with them.
3. **Catch up** (read-only):
   ```bash
   git fetch --prune
   git log --oneline HEAD..origin/main            # what landed on main
   git diff --stat HEAD...origin/main -- docs/decisions .claude ProjectSettings Packages
   gh issue list --assignee @me --state open
   gh pr list --search "review-requested:@me is:open"
   gh pr list --label needs-playtest --state open
   git lfs locks
   ```
4. Update the branch: on `main` → `git pull --ff-only`; on a feature branch → merge or rebase
   `main` in (the way recorded in `TEAM.md`). Resolve conflicts now, before new work.
5. Tell the member in 3–5 lines: what changed upstream that matters to them (new decisions,
   shared-file changes, packages), what's waiting for them, and a suggestion. **Unblock others
   first**: a pending review or playtest usually beats starting new work.

## Picking up work

- Take an issue from **Ready** (beginners: `good-first-issue`). Assign yourself:
  `gh issue edit <n> --add-assignee @me`; move it to **In progress**.
- Branch `<name>/<n>-<slug>` from fresh `main`.
- List the files/scenes the slice will touch (see `slice-loop` → plan). **Lock** every scene
  you'll edit: `git lfs lock <path>`. Locked by someone else → stop, tell the member, suggest
  asking that person or splitting the work (prefab instead of scene edit, additive sub-scene).
- Comment on the issue: "Started — plan: …, touching: …".

## Working

- **Stay inside the issue.** A needed change in another person's files → draft a short request
  for them (what, why, smallest change) as an issue comment instead of making it. If the member
  says it's coordinated, make it as a separate, clearly named commit.
- **Shared files** — input actions, `ProjectSettings/`, `Packages/manifest.json`, layers/tags,
  shared prefabs, `CLAUDE.md`, `.claude/`: minimal change, separate commit, called out in the PR.
  New packages or engine settings need a decision first (architecture decider).
- **Data assets**: check who tuned them last (`git log -3 -- <file>`); propose, don't change.
- Slice loop as usual. The playtest handoff goes to the member **and** into the PR.

## Session end — always leave a handoff

Even mid-slice, so anyone (including your own next session) can pick up cold:

1. Commit work in progress on the branch (with the member's OK) and push it. Open a **draft PR**
   early — it shows others what's coming.
2. Comment on the issue:
   ```
   **Handoff YYYY-MM-DD** — done: … · verified: … · NOT done: … · next: … · questions for: @who …
   ```
3. Keep scene locks only while the branch still needs them; unlock otherwise.

## Pull requests

- One slice per PR, small (a teammate can review + playtest in ~15 min). Fill the PR template:
  what changed, how Claude verified it, the playtest checklist, shared files touched, decisions
  recorded, what's not done.
- Before marking ready: compile, tests, re-read the diff for stray files (`git diff --stat
  origin/main...`), and ask Claude for a review of the diff in a fresh session or subagent;
  fix real findings.
- Add label `needs-playtest`, request the reviewer per `TEAM.md`.
- **Reviewing someone else's PR**: check out the branch, run their playtest checklist, answer
  in player words ("jump feels floaty after the slide"), and read the diff with Claude
  (explain it to a beginner reviewer). Approve, or request changes with concrete reasons.
- Merge (squash) only when approved and playtested; delete the branch, unlock scenes, close the
  issue, move the card.

## Decisions across members

- A question outside the member's issue → a `decision` issue (template) that names the decider
  and the options. Don't decide it here.
- When decided: a record in `docs/decisions/` ("Decided by <name>"), committed in the PR that
  needs it, or as its own small PR. Two records that conflict → flag both, don't pick one.

## Merge conflicts

- **C# / text**: resolve normally, then recompile and run the tests.
- **`.unity` / `.prefab` / `.asset`**: try Unity Smart Merge (`git mergetool`). If it can't:
  take the version of the **file's owner**, then redo the other change in the Editor. Never
  hand-merge YAML blindly; never drop a `.meta`.
- **Decision records / CLAUDE.md**: keep both sides; contradictions → `decision` issue.
- After any conflict: open the affected scenes from disk and look for missing references
  (pink materials, "Missing" scripts/prefabs).

## Never (enforced by the plugin's hooks where possible)

`git add -A` / `.` / `--all`, `commit -a`, committing or pushing on `main`, force-push,
`reset --hard`, `clean -f`, `checkout -- .`. Hand-editing scene/prefab YAML needs explicit OK.
