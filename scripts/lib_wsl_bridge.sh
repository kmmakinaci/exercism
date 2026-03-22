#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

if [[ -f "$repo_root/.wsl-local.env" ]]; then
    # shellcheck disable=SC1091
    source "$repo_root/.wsl-local.env"
fi

normalize_windows_path() {
    local path_value="${1:-}"

    if [[ -z "$path_value" ]]; then
        return 0
    fi

    if [[ "$path_value" =~ ^[A-Za-z]:\\ ]] && command -v wslpath >/dev/null 2>&1; then
        wslpath -u "$path_value"
        return 0
    fi

    printf '%s\n' "$path_value"
}

resolve_exercism_bin() {
    local candidate="${EXERCISM_BIN:-}"
    local found_path

    if [[ -n "$candidate" ]]; then
        normalize_windows_path "$candidate"
        return 0
    fi

    if command -v exercism >/dev/null 2>&1; then
        printf 'exercism\n'
        return 0
    fi

    candidate='/mnt/c/Users/Mert/Downloads/bin/exercism.exe'
    if [[ -x "$candidate" ]]; then
        printf '%s\n' "$candidate"
        return 0
    fi

    found_path=$(find /mnt/c/Users/Mert/Downloads -maxdepth 4 -iname 'exercism.exe' 2>/dev/null | head -n 1 || true)
    if [[ -n "$found_path" ]] && [[ -x "$found_path" ]]; then
        printf '%s\n' "$found_path"
        return 0
    fi

    return 1
}

resolve_windows_ssh_bin() {
    local candidate="${WINDOWS_SSH_BIN:-}"

    if [[ -n "$candidate" ]]; then
        normalize_windows_path "$candidate"
        return 0
    fi

    candidate='/mnt/c/Windows/System32/OpenSSH/ssh.exe'
    if [[ -x "$candidate" ]]; then
        printf '%s\n' "$candidate"
        return 0
    fi

    return 1
}

resolve_windows_ssh_key() {
    local candidate="${WINDOWS_SSH_KEY:-}"

    if [[ -z "$candidate" ]]; then
        return 1
    fi

    normalize_windows_path "$candidate"
}
