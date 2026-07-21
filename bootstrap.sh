#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source_file="$repo_dir/config.toml"
target_dir="${XDG_CONFIG_HOME:-$HOME/.config}/mise"
target_file="$target_dir/config.toml"

mkdir -p "$target_dir"

if [[ -L "$target_file" ]] && [[ "$(readlink "$target_file")" == "$source_file" ]]; then
  echo "Already linked: $target_file -> $source_file"
  exit 0
fi

if [[ -e "$target_file" || -L "$target_file" ]]; then
  backup_file="$target_file.backup.$(date +%Y%m%d%H%M%S)"
  mv "$target_file" "$backup_file"
  echo "Backed up: $target_file -> $backup_file"
fi

ln -s "$source_file" "$target_file"
echo "Linked: $target_file -> $source_file"
