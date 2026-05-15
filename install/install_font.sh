#!/usr/bin/env bash

function install_font() {
    local FONT=$1
    printf "Installing Font %s...\n" "$FONT"
    local INSTALL_FONT_DIR="${HOME}/.local/share/fonts"
    local SOURCE_FONT_DIR="${DOTFILES_BASE_DIR}/fonts/$FONT"
    if [[ ! -d $SOURCE_FONT_DIR ]]; then
        printf "Error: Font not found.\n"
        return 1
    fi
    if ! mkdir -p "$INSTALL_FONT_DIR"; then
        printf "Error: Could not create output directory.\n"
        return 1
    fi
    if ! cp -r "$SOURCE_FONT_DIR" "$INSTALL_FONT_DIR"; then
        printf "Error: Could not install font.\n"
        return 1
    fi

    #printf "Installed Font %s...\n" "$(ls $INSTALLED_FONT_DIR)"
}

