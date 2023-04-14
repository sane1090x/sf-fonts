#!/usr/bin/env bash

FONT_DIR="/usr/local/share/fonts/otf"

install_fonts() {
  local family=$1
  local font_dir=$2
  cd "/tmp/San-Francisco-family/$family" || exit
  if [ -z "$(ls -A ./*.otf)" ]; then
    echo "No fonts found for $family family"
    return 1
  fi
  sudo mkdir -p "$font_dir/sf-$family"
  sudo cp ./*.otf "$font_dir/sf-$family"
  cd - || exit
}

command -v git >/dev/null 2>&1 || { echo >&2 "Git not found, please install git"; exit 1; }

git clone --depth 1 --filter=blob:none --sparse https://github.com/thelioncape/San-Francisco-family /tmp/San-Francisco-family
cd /tmp/San-Francisco-family || { echo >&2 "Failed to change directory"; exit 1; }

git sparse-checkout init --cone
git sparse-checkout set '*/SF Pro/*' '*/SF Serif/*' '*/SF Mono/*'

install_fonts "Pro" "$FONT_DIR" || { echo >&2 "Failed to install Pro fonts"; exit 1; }
install_fonts "Serif" "$FONT_DIR" || { echo >&2 "Failed to install Serif fonts"; exit 1; }
install_fonts "Mono" "$FONT_DIR" || { echo >&2 "Failed to install Mono fonts"; exit 1; }

rm -rf /tmp/San-Francisco-family/

