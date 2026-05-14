#!/usr/bin/env bash

function install_font() {
    local FONT=$1
    printf "Installing Font %s...\n" "$FONT"
    local INSTALL_FONT_DIR="${HOME}/.local/share/fonts/$FONT"
    local SOURCE_FONT_DIR="${DOTFILES_BASE_DIR}/fonts/$FONT"
    if [[ -d $SOURCE_FONT_DIR ]]; then
        printf "Error: Font not found.\n" &> 2
        return 1
    fi
    mkdir -p $INSTALL_FONT_DIR
    if [[ $! != 0 ]]; then
        printf "Error: Could not create output directory.\n" &> 2
        return 1
    fi
    cp -r $SOURCE_FONT_DIR $INSTALL_FONT_DIR
    if [[ $! != 0 ]]; then
        printf "Error: Could not install font.\n" &> 2
        return 1
    fi
}

