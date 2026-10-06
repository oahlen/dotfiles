#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <home>" >&2
  exit 1
fi

home="$1"

out_dir="$(mktemp -d)"
bundle_name="${home}-bundle"
stage_dir="${out_dir}/${bundle_name}"

trap 'rm -rf "$out_dir"' EXIT

echo "Building manifest for home '${home}'..."
nix build -f . "homes.${home}.manifest" -o "${out_dir}/manifest-result"
manifest_path="$(readlink -f "${out_dir}/manifest-result")"

echo "Staging files at their manifest target paths..."
mkdir -p "${stage_dir}/home"
jq -r '.files[] | [.target, (.sources[] | select(.default) | .source)] | @tsv' "$manifest_path" |
  while IFS=$'\t' read -r target source; do
    # target is an absolute path like /home/<user>/...; strip the leading
    # /home/<user> segment and re-root everything under stage_dir/home so
    # the bundle tree mirrors $HOME regardless of the building user.
    rel="${target#/*/*/}"
    dest="${stage_dir}/home/${rel}"
    mkdir -p "$(dirname "$dest")"
    cp -a "$source" "$dest"
  done
chmod -R u+w "${stage_dir}"

cp "$manifest_path" "${stage_dir}/manifest.json"

echo "Archiving bundle..."
mkdir -p dist
tar -C "$out_dir" -cf - "${bundle_name}" | zstd -T0 -q -o "dist/${bundle_name}.tar.zst"

echo "Bundle written to dist/${bundle_name}.tar.zst"
