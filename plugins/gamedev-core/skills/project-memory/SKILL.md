---
name: project-memory
description: Where a game project's shared knowledge lives and how to keep it small and current — a short CLAUDE.md for rules and facts, decision records in docs/decisions, lessons as path-scoped rules in .claude/rules, status in issues or a status file, recipes as project skills. Use at the start and end of every work session, whenever a design question is settled, when a status changes (built / verified / playtested / merged), when a mistake teaches a rule worth keeping, or when CLAUDE.md is getting long.
---

# Project memory

Claude starts every session knowing only what the repo says. That knowledge must be **findable,
short and current**. The biggest trap: CLAUDE.md slowly turns into a changelog. Everything in it
loads into **every** session (and into every teammate's session), so a 50 KB CLAUDE.md costs
context and lowers how well its rules are followed. Claude Code's own guidance is under ~200
lines per CLAUDE.md.

## Where each kind of knowledge goes

| Kind | Where | Loaded |
|---|---|---|
| Working rules, project facts, commands, folder map | `CLAUDE.md` (≤ ~150 lines) | always |
| One person's name, role, experience, preferences | `CLAUDE.local.md` (git-ignored) | always, for that person |
| Locked design / architecture decisions | `docs/decisions/NNNN-short-title.md`, one file each | on demand |
| Lessons about one tool or folder | `.claude/rules/<topic>.md` with `paths:` frontmatter | when matching files are read |
| Lessons that apply everywhere | `.claude/rules/lessons.md` (no `paths:`) | always — keep it short |
| "How to add a new X" recipes | project skill `.claude/skills/add-<x>/SKILL.md` | when relevant |
| Current status, next steps, handoffs | **team:** GitHub issues/PRs · **solo/jam:** `docs/status.md` | on demand |
| Open questions | **team:** issues labelled `decision` · **solo/jam:** `docs/status.md` | on demand |

The jam and solo templates still carry a status section in CLAUDE.md (jam: milestones and
scope too). Until they're migrated, keep that section to the **current state only**, a few
lines; history goes nowhere (git has it).

Rules of thumb: if it's a **procedure**, it's a skill. If it matters only **for some files**,
it's a path-scoped rule. If it **changes every session**, it doesn't belong in CLAUDE.md.

## CLAUDE.md sections (in this order, short)

1. **How we work** — the collaboration rules, imperative, few lines.
2. **Project facts** — engine version, pipeline, input, platforms, VCS, tool paths.
3. **Commands** — how to compile, run tests, build, render a check image.
4. **Map** — top-level folders and what's in them; pointers to `docs/decisions/`,
   `.claude/rules/`, project skills, status.
5. **Concept** — 3–5 lines and the pillars. Details live in decisions.

Templates: `references/CLAUDE.template.md` (here) and the mode plugins' templates.

## Decision records

- One file per decision: `docs/decisions/0007-wall-jump-keeps-speed.md`. One file each means
  two people can record decisions at the same time without merge conflicts. (If two branches
  pick the same number, renumber the later one when merging; the number is only for sorting.)
- Content: date, **decision in one bold line**, context, options considered, why, who decided,
  status (`accepted` / `proposed — awaiting confirmation` / `superseded by 0012`).
- Values the owner finds by playing are marked *tunable*, never fixed in the record.
- Before asking a design question, **search `docs/decisions/` first** (`grep -ril <topic>`), so
  settled things aren't re-asked.
- When something is superseded, edit the old record's status and link the new one. Don't delete.

## Lessons (learned the hard way)

When a mistake cost time, add the rule that would have prevented it — dated, one line of what
happened, the safe alternative — to the matching `.claude/rules/` file. Name the tool, call or
file that bit you. If a lesson is general (not about this project), tell the user it could
improve the shared skills.

## Session routine

- **Start:** read the status (issue / `docs/status.md`), check `git status` (see
  `owner-assets-git`), confirm what this session is for.
- **During:** record decisions as soon as they're settled, not at the end.
- **End:** update status so the next session can pick up cold — "built / verified / awaiting
  playtest / merged" and **what is NOT done**.

## Health check (every ~5 sessions or when it feels slow)

- `wc -l CLAUDE.md` > ~150 → move material out using the table above.
- Finished work described in CLAUDE.md → delete it (git history and PRs keep it).
- Decisions "awaiting confirmation" → ask the decider to confirm or change each.
- Rules that contradict each other → ask which one wins, delete the other.

## Migrating an old, long CLAUDE.md

Don't do it silently. Propose the split first (which section goes where), then: decisions →
one record per topic group (a big group may stay one file at first), lessons → `.claude/rules/`
by tool, status history → delete (git has it) except the current state → `docs/status.md`,
recipes → project skills. Show the new CLAUDE.md line count before and after.

## Rules

- **Dates are absolute** (`2026-10-15`).
- **Record the why.** One line stops later sessions from re-litigating.
- **Don't duplicate** what code or git history already says. Record intent, constraints, traps.
- **Personal vs shared:** CLAUDE.md is shared truth; CLAUDE.local.md is one person's; Claude's
  auto-memory is per machine and never a substitute for the repo.
