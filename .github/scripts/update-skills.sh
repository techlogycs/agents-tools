#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)

cd "$ROOT_DIR"
npx --yes skills update
"$ROOT_DIR/.github/scripts/audit-skills.sh" --write