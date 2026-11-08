#!/usr/bin/env bash
# PreToolUse (Write|Edit|MultiEdit): ask before Claude hand-edits Unity YAML (scenes, prefabs,
# assets). The Editor or an Editor script is the safe way; trivial one-field edits are OK once
# the member agrees. Active only in team projects (TEAM.md at the project root).

root="${CLAUDE_PROJECT_DIR:-$PWD}"
[ -f "$root/TEAM.md" ] || exit 0

input="$(cat)"
path="$(printf '%s' "$input" | tr '\n' ' ' | sed -nE 's/.*"file_path"[[:space:]]*:[[:space:]]*"(([^"\\]|\\.)*)".*/\1/p')"
[ -n "$path" ] || exit 0

case "$path" in
  *.unity|*.prefab|*.asset|*.mat|*.anim|*.controller|*.overrideController|*.physicMaterial|*.lighting)
    ;;
  *) exit 0 ;;
esac

name="${path##*/}"
cat <<EOF
{"hookSpecificOutput":{"hookEventName":"PreToolUse","permissionDecision":"ask","permissionDecisionReason":"gamedev-team: hand-editing Unity YAML ($name). Prefer the Editor or an Editor script. Is this a trivial edit, is the file yours (not locked or tuned by someone else), and is it saved and closed in Unity?"}}
EOF
exit 0
