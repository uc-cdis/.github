#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if virtual_env=$(uv run python -c "import sys; print(sys.prefix)" 2>/dev/null); then
    echo "Using uv venv: $virtual_env"
else
    if virtual_env=$(poetry env info --path 2>/dev/null); then
        echo "Using Poetry venv: $virtual_env"
    else
        echo "No suitable virtual environment found (neither uv nor poetry)."
        exit 1
    fi
fi

site_packages_folder=$(find $virtual_env -type d -name "site-packages" -print -quit)
if [ -n "$site_packages_folder" ]; then
  echo "Found 'site-packages' folder at: $site_packages_folder"
else
  echo "No 'site-packages' folder found in provided virtual env: $virtual_env."
  exit 1
fi

echo
echo "Updating $SCRIPT_DIR/.python-lint"
echo "init-hook='import sys; sys.path.append(\"$site_packages_folder\")'"
{
  echo "[MAIN]"
  echo "init-hook='import sys; sys.path.append(\"$site_packages_folder\")'"
  tail -n +3 $SCRIPT_DIR/.python-lint
} > $SCRIPT_DIR/.python-lint.tmp && mv $SCRIPT_DIR/.python-lint.tmp $SCRIPT_DIR/.python-lint
