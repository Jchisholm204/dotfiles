#!/usr/bin/env bash

function install_ohmyzsh() {
    printf "Setting up OhMyZsh\n"
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/ohmyzsh_install.sh &> /dev/null
    chmod +x /tmp/ohmyzsh_install.sh
    /tmp/ohmyzsh_install.sh --unattended
    rm /tmp/ohmyzsh_install.sh
    
    wget https://starship.rs/install.sh -O /tmp/starship_install.sh &> /dev/null
    chmod +x /tmp/starship_install.sh
    mkdir -p "${HOME}/.local/bin"
    /tmp/starship_install.sh --bin-dir "${HOME}/.local/bin"
    rm /tmp/starship_install.sh

    local ZSH_CUSTOM="${HOME}/.oh-my-zsh/custom"
    mkdir -p $ZSH_CUSTOM

    printf "Setting up Autosuggestions\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git \
        $ZSH_CUSTOM/plugins/zsh-autosuggestions

    printf "Setting up Syntax Highlighing \n"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    return 0
}

