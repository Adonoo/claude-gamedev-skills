---
name: team-sync
description: Prepare and follow up the team's weekly sync for a shared Unity project with Claude — an agenda from GitHub (merged PRs, PRs waiting for review or playtest, stale branches and scene locks, open decision issues, blocked or unassigned work), a joint playtest of main, decisions to take, board grooming, the build captain's weekly build, a short retro that turns mistakes into rules, and a project-memory health check. Use when the user asks for the weekly meeting, an agenda, a team status overview, "what's everyone doing", a retro, or "is the project healthy?".
---

# Team sync (weekly, ~30–45 min)

A short regular meeting keeps four Claudes from drifting into four different games. Claude
prepares it, someone runs it, Claude records the results.

## Before: the agenda (read-only)

```bash
gh pr list --state merged --search "merged:>=$(date -d '-7 days' +%F 2>/dev/null || date -v-7d +%F)"
gh pr list --state open
gh issue list --label decision --state open
gh issue list --state open --search "no:assignee label:slice"
git fetch --prune && git branch -r --sort=-committerdate
git lfs locks
```

Summarise in one screen:

1. **Shipped this week** (merged PRs, one line each, by person).
2. **Waiting** — PRs needing review/playtest (oldest first), with who's asked.
3. **Stale** — branches with no commit in 7+ days, scene locks held 3+ days → ask the holder.
4. **Decisions to take** — open `decision` issues with options and the decider.
5. **Next up** — Ready column; unassigned slices; anyone without work.
6. **Health** — `wc -l CLAUDE.md` (> ~150?), new `.claude/rules` lessons, failing tests on main.

## During

1. **Playtest `main` together** (10 min) — the build captain's build or the start scene. One
   sentence each: best moment, worst moment.
2. **Decide** the open decisions (decider has the final say; ties → vision holder).
3. **Plan the week**: each person picks/gets 1–2 issues; check no two issues touch the same
   files or scenes.
4. **Retro (5 min)**: what slowed us down? What did a Claude get wrong more than once?

## After: record it

- Each decision → a record in `docs/decisions/` (small PR) and the `decision` issue closed with
  a link.
- Retro findings → a rule in `.claude/rules/` (project-specific) or a note for the shared
  skills repo (general). Process changes → `docs/HOW-WE-WORK.md` / `TEAM.md`.
- Board updated; the next build captain named in `TEAM.md`.
- Post a short summary in the team channel (offer the text, ready to paste).
