#!/usr/bin/env bash

function install_ohmyzsh() {
    printf "Setting up OhMyZsh\n"
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/ohmyzsh_install.sh &> /dev/null
    chmod +x /tmp/ohmyzsh_install.sh
    /tmp/ohmyzsh_install.sh --unattended
    rm /tmp/ohmyzsh_install.sh

    printf "Setting up Autosuggestions\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        $ZSH_CUSTOM/plugins/zsh-autosuggestions &> /dev/null

    printf "Setting up Syntax Highlighing \n"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        $ZSH_CUSTOM/plugins/zsh-syntax-highlighting &> /dev/null
    return 0
}

