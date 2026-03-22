#!/usr/bin/env bash

set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
exercise="${1:-}"
script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
exercise_dir="$repo_root/c/$exercise"

if [[ -z "$exercise" ]]; then
    echo "Usage: $0 <exercise-name>" >&2
    exit 1
fi

cd "$repo_root"

set +e
"$script_dir/exercism_cli.sh" download --track=c --exercise="$exercise"
download_status=$?
set -e

if [[ $download_status -ne 0 ]]; then
    if [[ -d "$exercise_dir" ]]; then
        echo "Download command returned a non-zero status, but $exercise_dir exists. Continuing with normalization." >&2
    else
        echo "Download failed and the exercise directory was not created: $exercise_dir" >&2
        exit $download_status
    fi
fi

"$repo_root/scripts/normalize_exercism_c_exercise.sh" "c/$exercise"
