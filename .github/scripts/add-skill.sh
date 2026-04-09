#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

usage() {
  cat <<'EOF'
Usage:
  add-skill.sh <source> --skill <skill-name> [extra skills add args...]
  add-skill.sh --from-command "npx skills add <source> --skill <skill-name> [...]"

Installs a skill only for GitHub Copilot in the project-scoped standard path
under .agents/skills, then refreshes skills-audit.json.
EOF
}

normalize_pasted_command() {
  local raw_command="$1"

  [[ -n "$raw_command" ]] || {
    usage
    exit 1
  }

  eval "set -- $raw_command"

  if [[ "${1:-}" == "npx" ]]; then
    shift
  fi

  if [[ "${1:-}" == "--yes" ]]; then
    shift
  fi

  [[ "${1:-}" == "skills" ]] || fail "Expected pasted command to start with 'npx skills add' or 'skills add'"
  shift

  [[ "${1:-}" == "add" ]] || fail "Expected pasted command to contain 'skills add'"
  shift

  [[ $# -ge 1 ]] || fail "Expected pasted command to include a source"

  printf '%s\n' "$@"
}

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

if [[ "${1:-}" == "--from-command" ]]; then
  [[ $# -eq 2 ]] || {
    usage
    exit 1
  }

  mapfile -t parsed_args < <(normalize_pasted_command "$2")
  set -- "${parsed_args[@]}"
fi

[[ $# -ge 3 ]] || {
  usage
  exit 1
}

source_ref="$1"
shift

list_only=false
for arg in "$@"; do
  if [[ "$arg" == "--list" ]]; then
    list_only=true
    break
  fi
done

cd "$ROOT_DIR"
npx --yes skills add "$source_ref" --agent github-copilot -y "$@"
if [[ "$list_only" == true ]]; then
  exit 0
fi

"$ROOT_DIR/.github/scripts/audit-skills.sh" --write