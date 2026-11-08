#!/usr/bin/env bash
# PreToolUse (Bash): block git commands that hurt a shared Unity repo.
# Active only in team projects (TEAM.md at the project root).
# Opt out of the main-branch checks (e.g. a 1-person team): create .claude/allow-main-commits
# Exit 2 = block; the message on stderr goes back to Claude.

root="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -f "$root/TEAM.md" ] || exit 0

input="$(cat)"
# Pull the "command" string out of the JSON without needing jq (JSON escapes stay escaped).
cmd="$(printf '%s' "$input" | tr '\n' ' ' | sed -nE 's/.*"command"[[:space:]]*:[[:space:]]*"(([^"\\]|\\.)*)".*/\1/p')"
[ -n "$cmd" ] || exit 0
# Only look at commands that call git.
printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])git[[:space:]]' || exit 0
# Ignore quoted text (commit messages, echo strings) so "never use git add -A" doesn't trigger.
cmd="$(printf '%s' "$cmd" | sed -E 's/\\"([^\\]|\\[^"])*\\"/Q/g' | sed -E "s/'[^']*'/Q/g")"

block() {
  echo "Blocked by gamedev-team: $1" >&2
  exit 2
}
has() { printf '%s' "$cmd" | grep -Eq "$1"; }

G='(^|[;&|[:space:]])git[[:space:]]+(-C[[:space:]]+[^[:space:]]+[[:space:]]+)?'

has "${G}add[[:space:]]+([^;&|]*[[:space:]])?(-A|--all|-u|--update|\\.)([[:space:]]|;|&|\\||\$)" \
  && block "stage files by path (git add <file> ...), never -A / --all / -u / '.'. Other people's or the member's own Editor changes may be in the working tree."
has "${G}commit[[:space:]]+([^;&|]*[[:space:]])?-[a-zA-Z]*a" \
  && block "don't use 'git commit -a'; stage files by path first."
has "${G}push[[:space:]]+([^;&|]*[[:space:]])?(--force|--force-with-lease|-f|\\+[^[:space:]]+)([[:space:]=]|;|&|\\||\$)" \
  && block "no force-push on a shared repo. If history really must change, ask the member to coordinate with the team."
has "${G}reset[[:space:]]+([^;&|]*[[:space:]])?--hard" \
  && block "'git reset --hard' destroys uncommitted Editor work. Ask the member; prefer 'git stash' or a new branch."
has "${G}clean[[:space:]]+([^;&|]*[[:space:]])?-[a-zA-Z]*f" \
  && block "'git clean -f' deletes untracked files (new assets, unsaved levels). Ask the member first."
has "${G}(checkout|restore)[[:space:]]+(--[[:space:]]+)?\\.([[:space:]]|;|&|\\||\$)" \
  && block "discarding all changes ('checkout .' / 'restore .') can destroy someone's Editor work. Name the files and ask first."

if [ ! -f "$root/.claude/allow-main-commits" ]; then
  branch="$(git -C "$root" symbolic-ref --short -q HEAD 2>/dev/null)"
  if [ "$branch" = "main" ] || [ "$branch" = "master" ]; then
    has "${G}commit([[:space:]]|\$)" \
      && block "you're on '$branch'. Create a branch first: git switch -c <name>/<issue>-<slug> (uncommitted changes come along)."
    has "${G}push([[:space:]]|\$)" \
      && block "don't push '$branch' directly; push a feature branch and open a PR."
  fi
  has "${G}push[[:space:]]+[^;&|]*[[:space:]:](main|master)([[:space:]]|;|&|\\||\$)" \
    && block "don't push to main/master; open a PR from a feature branch."
fi

exit 0
