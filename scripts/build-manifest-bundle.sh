#!/usr/bin/env bash

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <home>" >&2
  exit 1
fi

home="$1"

out_dir="$(mktemp -d)"
bundle_name="${home}-bundle"
stage_dir="dist/${bundle_name}"

trap 'rm -rf "$out_dir"' EXIT

rm -rf "$stage_dir"
mkdir -p dist

echo "Building manifest for home '${home}'..."
nix build -f . "homes.${home}.manifest" -o "${out_dir}/manifest-result"
manifest_path="$(readlink -f "${out_dir}/manifest-result")"

echo "Staging files at their manifest target paths..."
mkdir -p "${stage_dir}/home"

jq -r '.files[] | [.target, (.sources[] | select(.default) | .source)] | @tsv' "$manifest_path" |
  while IFS=$'\t' read -r target source; do
    rel="${target#/*/*/}"
    dest="${stage_dir}/home/${rel}"
    mkdir -p "$(dirname "$dest")"
    cp -a "$source" "$dest"
  done

chmod -R u+w "${stage_dir}"

cp "$manifest_path" "${stage_dir}/manifest.json"

echo "Bundle written to ${stage_dir}/"
