#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$script_dir/lib_wsl_bridge.sh"

exercism_bin=$(resolve_exercism_bin || true)

if [[ -z "${exercism_bin:-}" ]]; then
    echo "Unable to find the Exercism CLI. Set EXERCISM_BIN in .wsl-local.env or your shell." >&2
    exit 1
fi

if [[ "$exercism_bin" =~ / ]] && [[ ! -x "$exercism_bin" ]]; then
    echo "Exercism CLI is not executable: $exercism_bin" >&2
    exit 1
fi

"$exercism_bin" "$@"
