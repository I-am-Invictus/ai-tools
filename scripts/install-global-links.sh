#!/usr/bin/env bash

set -u

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
source_dir="$repo_dir/.agents/skills"
conflicts=0

link_skills() {
  destination=$1
  mkdir -p "$destination"

  for skill_dir in "$source_dir"/*; do
    [ -d "$skill_dir" ] || continue
    skill_name=${skill_dir##*/}
    target="$destination/$skill_name"

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$skill_dir" ]; then
      printf 'Already linked: %s\n' "$target"
    elif [ -e "$target" ] || [ -L "$target" ]; then
      printf 'Conflict, left unchanged: %s\n' "$target" >&2
      conflicts=1
    else
      ln -s "$skill_dir" "$target"
      printf 'Linked: %s\n' "$target"
    fi
  done
}

link_skills "${CODEX_HOME:-${HOME}/.codex}/skills"
link_skills "${HOME}/.agents/skills"
link_skills "${HOME}/.claude/skills"

if [ "$conflicts" -ne 0 ]; then
  printf 'Finished with conflicts; existing installations were preserved.\n' >&2
  exit 1
fi

printf 'All skills linked. Restart Codex, OpenCode, and Claude Code.\n'
