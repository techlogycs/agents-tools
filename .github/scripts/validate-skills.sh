#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
SKILLS_DIR="$ROOT_DIR/.agents/skills"
SKILLS_LOCK_FILE="$ROOT_DIR/skills-lock.json"

usage() {
  cat <<'EOF'
Usage:
  validate-skills.sh --all
  validate-skills.sh --changed <base-ref> <head-ref>

Validates installable skills with `npx skills add <path> --list` and runs
basic repository structure checks on changed markdown files.
EOF
}

log() {
  printf '%s\n' "$*"
}

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

is_zero_sha() {
  [[ "$1" =~ ^0+$ ]]
}

relative_path() {
  local path="$1"
  printf '%s\n' "${path#"$ROOT_DIR"/}"
}

collect_all_skill_dirs() {
  find "$SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d | sort
}

collect_changed_files() {
  local base_ref="$1"
  local head_ref="$2"

  git -C "$ROOT_DIR" diff --name-only "$base_ref" "$head_ref" -- .agents/skills skills-lock.json
}

skills_lock_changed() {
  local base_ref="$1"
  local head_ref="$2"

  if git -C "$ROOT_DIR" diff --quiet "$base_ref" "$head_ref" -- skills-lock.json; then
    return 1
  fi

  return 0
}

collect_changed_markdown_files() {
  local base_ref="$1"
  local head_ref="$2"

  collect_changed_files "$base_ref" "$head_ref" | grep -E '\.md$' || true
}

collect_changed_skill_dirs() {
  local base_ref="$1"
  local head_ref="$2"

  collect_changed_files "$base_ref" "$head_ref" \
    | awk -F/ 'NF >= 3 { print $1 "/" $2 "/" $3 }' \
    | sort -u
}

extract_markdown_links() {
  local file_path="$1"
  { grep -oE '\[[^]]+\]\([^)]*\)' "$file_path" || true; } \
    | while IFS= read -r match; do
        local target="${match#*](}"
        target="${target%)}"
        target="${target%%#*}"
        [[ -n "$target" ]] || continue
        printf '%s\n' "$target"
      done
}

check_markdown_links() {
  local file_path="$1"
  local base_dir
  base_dir=$(dirname "$file_path")

  while IFS= read -r target; do
    case "$target" in
      http://*|https://*|mailto:*|\#*|/*|/dev/null|*::*|fn@*|mod@*|struct@*|enum@*|trait@*|type@*|const@*|macro@*)
        continue
        ;;
    esac

    if [[ "$target" != */* && "$target" != *.* ]]; then
      continue
    fi

    local resolved_path="$base_dir/$target"
    if [[ ! -e "$resolved_path" ]]; then
      fail "Broken relative link in $(relative_path "$file_path"): $target"
    fi
  done < <(extract_markdown_links "$file_path")
}

validate_installable_skill() {
  local skill_dir="$1"
  local skill_name
  skill_name=$(basename "$skill_dir")
  local skill_file="$skill_dir/SKILL.md"

  [[ -f "$skill_file" ]] || fail "Expected $skill_name to include SKILL.md"

  local declared_name
  declared_name=$(sed -n 's/^name:[[:space:]]*//p' "$skill_file" | head -n 1)
  [[ -n "$declared_name" ]] || fail "Missing frontmatter name in $(relative_path "$skill_file")"
  [[ "$declared_name" == "$skill_name" ]] || fail "Frontmatter name '$declared_name' does not match directory '$skill_name'"

  if ! grep -q '^description:' "$skill_file"; then
    fail "Missing frontmatter description in $(relative_path "$skill_file")"
  fi

  log "CLI validation: $skill_name"
  npx --yes skills add "$skill_dir" --list >/dev/null

  check_markdown_links "$skill_file"

  if [[ -d "$skill_dir/rules" ]]; then
    while IFS= read -r rule_file; do
      check_markdown_links "$rule_file"
    done < <(find "$skill_dir/rules" -mindepth 1 -maxdepth 1 -type f -name '*.md' | sort)
  fi
}

validate_changed_markdown_files() {
  local files=()
  while IFS= read -r file_path; do
    [[ -n "$file_path" ]] || continue
    files+=("$ROOT_DIR/$file_path")
  done

  if [[ ${#files[@]} -eq 0 ]]; then
    return 0
  fi

  log "Checking changed markdown links"
  local file_path
  for file_path in "${files[@]}"; do
    [[ -f "$file_path" ]] || continue
    check_markdown_links "$file_path"
  done
}

validate_repo_source() {
  log "CLI validation: repository source"
  npx --yes skills add "$ROOT_DIR" --list >/dev/null
}

collect_locked_skill_dirs() {
  [[ -f "$SKILLS_LOCK_FILE" ]] || return 0

  node -e '
    const fs = require("fs");
    const path = require("path");
    const rootDir = process.argv[1];
    const lockPath = process.argv[2];
    const payload = JSON.parse(fs.readFileSync(lockPath, "utf8"));
    for (const skillName of Object.keys(payload.skills || {}).sort()) {
      process.stdout.write(path.join(rootDir, ".agents", "skills", skillName) + "\n");
    }
  ' "$ROOT_DIR" "$SKILLS_LOCK_FILE"
}

main() {
  [[ -d "$SKILLS_DIR" ]] || fail "Skills directory not found: $SKILLS_DIR"

  local mode=""
  local -a skill_dirs=()

  case "${1:-}" in
    --all)
      mode="all"
      while IFS= read -r dir_path; do
        [[ -f "$dir_path/SKILL.md" ]] || continue
        skill_dirs+=("$dir_path")
      done < <(collect_all_skill_dirs)
      ;;
    --changed)
      [[ $# -eq 3 ]] || fail "--changed requires <base-ref> <head-ref>"
      local base_ref="$2"
      local head_ref="$3"

      if [[ -z "$base_ref" || -z "$head_ref" ]] || is_zero_sha "$base_ref"; then
        mode="all"
        while IFS= read -r dir_path; do
          [[ -f "$dir_path/SKILL.md" ]] || continue
          skill_dirs+=("$dir_path")
        done < <(collect_all_skill_dirs)
      else
        mode="changed"
        validate_changed_markdown_files < <(collect_changed_markdown_files "$base_ref" "$head_ref")
        while IFS= read -r dir_path; do
          [[ -n "$dir_path" ]] || continue
          local absolute_dir="$ROOT_DIR/$dir_path"
          [[ -d "$absolute_dir" ]] || continue
          [[ -f "$absolute_dir/SKILL.md" ]] || continue
          skill_dirs+=("$absolute_dir")
        done < <(collect_changed_skill_dirs "$base_ref" "$head_ref")

        if skills_lock_changed "$base_ref" "$head_ref"; then
          while IFS= read -r absolute_dir; do
            [[ -d "$absolute_dir" ]] || continue
            [[ -f "$absolute_dir/SKILL.md" ]] || continue
            skill_dirs+=("$absolute_dir")
          done < <(collect_locked_skill_dirs)
        fi
      fi
      ;;
    *)
      usage
      exit 1
      ;;
  esac

  if [[ ${#skill_dirs[@]} -eq 0 ]]; then
    log "No installable skill changes detected"
    exit 0
  fi

  mapfile -t skill_dirs < <(printf '%s\n' "${skill_dirs[@]}" | awk 'NF' | sort -u)

  if [[ "$mode" == "all" ]]; then
    local skill_file
    log "Checking markdown links across all installable skills"
    while IFS= read -r skill_file; do
      check_markdown_links "$skill_file"
    done < <(find "$SKILLS_DIR" -type f -name '*.md' | sort)
  fi

  validate_repo_source

  local skill_dir
  for skill_dir in "${skill_dirs[@]}"; do
    validate_installable_skill "$skill_dir"
  done

  log "Skill validation completed successfully"
}

main "$@"