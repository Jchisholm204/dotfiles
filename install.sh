#!/bin/bash

echo "Installing JC204 Config"
C_DIR=$(pwd)
echo "Installing from $C_DIR"

echo "Setting up Fonts"

FONT_DIR="$HOME/.local/share/fonts"

if [ ! -d "$FONT_DIR" ]; then
    mkdir "$FONT_DIR"
    echo "Created $FONT_DIR"
else
    echo "Skipping Font Directory Creation Already Exists"
fi

echo -n "Install Fonts [y/n]:"
read -r ans

if [ "$ans" == "y" ]; then
    for FDIR in "$C_DIR"/fonts/*; do
        [ -d "$FDIR" ] || continue;
        echo "Copying Font: $(basename "$FDIR")"
        cp "$FDIR"/* $FONT_DIR
    done
fi

echo "Installed Fonts"

echo "Set up ZSH? [y/n]:"
read -r ans
if [ "$ans" == "y" ]; then
    echo "Install OhMyZsh? [y/n]"
    read -r ans
    if [ "$ans" == "y" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
    if [ ! -d  "$HOME/.zshrc" ]; then
        echo "Found OLD ZSH Config: renamed to zshrc-old"
        mv "$HOME"/.zshrc "$HOME"/zshrc-old
    fi
    ln -s $(pwd)/.zshrc "$HOME"
    echo "Created ZSHrc Symlink"
fi
