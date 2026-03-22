#!/usr/bin/env bash

set -euo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
# shellcheck disable=SC1091
source "$script_dir/lib_wsl_bridge.sh"

exercism_bin=$(resolve_exercism_bin || true)
if [[ -n "${exercism_bin:-}" ]]; then
    export EXERCISM_BIN="$exercism_bin"
fi

windows_ssh_bin=$(resolve_windows_ssh_bin || true)
windows_ssh_key=$(resolve_windows_ssh_key || true)

if [[ -n "${windows_ssh_bin:-}" ]]; then
    if [[ -n "${windows_ssh_key:-}" ]]; then
        export GIT_SSH_COMMAND="$windows_ssh_bin -i $windows_ssh_key"
    else
        export GIT_SSH_COMMAND="$windows_ssh_bin"
    fi
fi
