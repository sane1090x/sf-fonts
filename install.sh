#!/usr/bin/env bash

FONT_DIR="/tmp/San-Francisco-family"
SYSTEM_FONT_LOCATION="/usr/local/share/fonts/otf"
FONT_URL="https://github.com/thelioncape/San-Francisco-family.git"
FONTS=("SF Pro" "SF Serif" "SF Mono")

clone_repo() {
    echo
    echo "### Cloning repo... ###"
    echo

    git clone -n --depth=1 --filter=tree:0 $FONT_URL $FONT_DIR
    cd $FONT_DIR || exit
    git sparse-checkout set --no-cone "${FONTS[@]}"
    git checkout
}

copy_files() {
    echo
    echo "### Copying files... ###"
    echo
    sudo mkdir -p $SYSTEM_FONT_LOCATION/sf-{pro,serif,mono}

    sudo cp $FONT_DIR/SF\ Pro/*.otf $SYSTEM_FONT_LOCATION/sf-pro
    sudo cp $FONT_DIR/SF\ Serif/*.otf $SYSTEM_FONT_LOCATION/sf-serif
    sudo cp $FONT_DIR/SF\ Mono/*.otf $SYSTEM_FONT_LOCATION/sf-mono

    echo
    echo "### Done! ###"
    echo
}

if ! command -v git >/dev/null; then
    echo "Install git"
    exit 1
fi

clone_repo
copy_files
