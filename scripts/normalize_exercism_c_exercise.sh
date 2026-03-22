#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
exercise_arg="${1:-}"

if [[ -z "$exercise_arg" ]]; then
    echo "Usage: $0 c/<exercise-name> | /absolute/path/to/c/<exercise-name>" >&2
    exit 1
fi

exercise_dir="$exercise_arg"
if [[ "$exercise_dir" != /* ]]; then
    exercise_dir="$repo_root/$exercise_dir"
fi

makefile="$exercise_dir/makefile"
shared_framework_dir="$repo_root/c/test-framework"
local_framework_dir="$exercise_dir/test-framework"
local_metadata_dir="$exercise_dir/.exercism"

if [[ ! -d "$exercise_dir" ]]; then
    echo "Exercise directory not found: $exercise_dir" >&2
    exit 1
fi

if [[ ! -d "$shared_framework_dir" ]]; then
    if [[ ! -d "$local_framework_dir" ]]; then
        echo "Shared test framework is missing, and no local copy was found in $exercise_dir" >&2
        exit 1
    fi

    mkdir -p "$shared_framework_dir"
    cp "$local_framework_dir/unity.c" "$shared_framework_dir/unity.c"
    cp "$local_framework_dir/unity.h" "$shared_framework_dir/unity.h"
    cp "$local_framework_dir/unity_internals.h" "$shared_framework_dir/unity_internals.h"
fi

if [[ -f "$makefile" ]]; then
    if ! grep -Fq 'CFLAGS += -I..' "$makefile"; then
        sed -i '/CFLAGS += -DUNITY_SUPPORT_64 -DUNITY_OUTPUT_COLOR/a CFLAGS += -I..' "$makefile"
    fi

    sed -E -i 's@(^|[[:space:]])test-framework/unity\.c([[:space:]])@\1../test-framework/unity.c\2@g' "$makefile"
fi

rm -rf "$local_framework_dir" "$local_metadata_dir"

echo "Normalized $(realpath --relative-to="$repo_root" "$exercise_dir")"
