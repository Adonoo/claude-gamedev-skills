#!/usr/bin/env bash
# SessionStart: print a short git context for Claude (stdout is added to the session).
# Offline and fast: no fetch here; the team-workflow skill does the full catch-up.
# Active only in team projects (TEAM.md at the project root).

root="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -f "$root/TEAM.md" ] || exit 0
cd "$root" || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

branch="$(git symbolic-ref --short -q HEAD 2>/dev/null || echo '(detached)')"
upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)"
changes="$(git status --porcelain 2>/dev/null)"
count="$(printf '%s' "$changes" | grep -c . )"

echo "## Team repo context (gamedev-team)"
echo "- Branch: $branch${upstream:+ (tracks $upstream)}"
if [ -n "$upstream" ]; then
  set -- $(git rev-list --left-right --count "HEAD...$upstream" 2>/dev/null)
  [ -n "$1" ] && echo "- Ahead $1 / behind $2 of $upstream (as of the last fetch)"
fi
if [ "$count" -gt 0 ]; then
  echo "- $count uncommitted change(s) — may be the member's Editor work; ask before touching:"
  printf '%s\n' "$changes" | head -n 10 | sed 's/^/    /'
  [ "$count" -gt 10 ] && echo "    …"
fi
if [ "$branch" = "main" ] || [ "$branch" = "master" ]; then
  echo "- On $branch: create a feature branch before any change."
fi
[ -f CLAUDE.local.md ] || echo "- No CLAUDE.local.md: ask the member who they are (team-onboarding)."
if [ -f CLAUDE.md ]; then
  lines="$(wc -l < CLAUDE.md | tr -d ' ')"
  [ "$lines" -gt 150 ] && echo "- CLAUDE.md has $lines lines (target ≤ 150): suggest a project-memory health check."
fi
echo "- Start with the team-workflow session routine (fetch, my issues, reviews, locks)."
exit 0
