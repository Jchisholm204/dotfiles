#!/usr/bin/env bash

function find_topdir() {
    # Helper function to find the base repository directory (pure)
    # Returns by echo, return value indicates git (0) or fallback (1)
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == true ]]; then
        # Return through stdo (fd=1)
        echo "$(git rev-parse --show-toplevel)"
        echo "$(git rev-parse --show-toplevel)" >&2
    else
        # Compatibility layer for tarballs
        printf "WARNING: Git repository not detected.\n" >& 2
        printf "Using: %s as the top level directory.\n" $(pwd) >& 2
        # Return through stdo (fd=1)
        printf "%s" $(pwd)
        return 1
    fi
}

if [[ $(git > /dev/null) ]]; then
    printf "ERROR: Git is not installed. How did you get here?\n" >& 2
    exit 1
fi

export DOTFILES_BASE_DIR=$(find_topdir)
export DOTFILES_SCRIPT_DIR="${DOTFILES_BASE_DIR}/install"

# Source all installation scripts
for SCRIPT in $(ls $DOTFILES_SCRIPT_DIR); do
   source "$DOTFILES_SCRIPT_DIR/$SCRIPT"
done


printf "Installing JC204 Config from %s to %s\n" $DOTFILES_BASE_DIR $HOME


if question "Initialize GIT Submodules?"; then
    git submodule update --init --recursive &> /dev/null
fi

if question "Add COPR Repos?"; then
    sudo dnf copr enable jchisholm204/Alacritty
    sudo dnf copr enable jchisholm204/neovim
    sudo dnf copr enable jchisholm204/JacobEPEL
fi

PACKAGE_LIST=(
    alacritty
    tmux
    gh
    bat
    git-lfs
    google-chrome-stable
    gdb
    valgrind
    syncthing
    flatseal
    zsh
    cmake
    wget
)

if question "Install reccomended packages?"; then
    if question "Bypass Questionaire?"; then
        for PACKAGE in ${PACKAGE_LIST[@]}; do
            install_package $PACKAGE
        done
    else
        for PACKAGE in ${PACKAGE_LIST[@]}; do
            if ! which $PACKAGE > /dev/null; then
                printf "Warning: Required package %s not found.\n" $PACKAGE
                if question "Install ${PACKAGE}?"; then
                    install_package $PACKAGE
                fi
                if ! which $PACKAGE > /dev/null; then
                    printf "Warning: Required package %s not found.\n" $PACKAGE
                fi
            fi
        done
    fi
fi
# Check for all packages being present
for PACKAGE in ${PACKAGE_LIST[@]}; do
    if ! which $PACKAGE > /dev/null; then
        printf "Warning: Required package %s not found.\n" $PACKAGE
    fi
done

if question "Install Fonts?"; then
    install_font 'FiraMono'
fi

if question "Setup Alacritty?"; then
    mkdir -p "$HOME/.config"
    ln -s \
    "${DOTFILES_BASE_DIR}/applications/alacritty" \
    "$HOME/.config/alacritty"
fi

if question "Setup ZSH?"; then
    
    if question "Setup OhMyZsh? (yes)"; then
    	install_ohmyzsh
    fi

    printf "Setting up zshrc\n"
    if [[ -f "$HOME/.zshrc" ]]; then
        if question "Found old zshrc. Backup?"; then
            mv "$HOME/.zshrc" "$HOME/zshrc.bak"
        fi
	rm "${HOME}/.zshrc"
    fi

    ln -s \
        "${DOTFILES_BASE_DIR}/shell/zsh/.zshrc" \
        "${HOME}/.zshrc"
fi

if question "Setup TMUX?"; then
    printf "Setting up tmux\n"
    if [[ -d "$HOME/.tmux.conf" ]]; then
        if question "Found old tmux conf. Backup?"; then
            mv "$HOME/.tmux.conf" "$HOME/.tmux.conf.bak"
        fi
    fi

    ln -s \
        "${DOTFILES_BASE_DIR}/shell/tmux/tmux.conf" \
        "${HOME}/.tmux.conf"

    tmux source $HOME/tmux.conf
    # tmux set -g mouse

    printf "Tmux has been set up.\n"
    printf '->Prefix Key: <Ctrl>-<Space>\n'
    printf '->First Launch: <Prefix>-<Shift>-I\n'
fi

if question "Setup Neovim?"; then
    
    printf "Setting up neovim\n"
    if [[  -d "$HOME/.config/nvim" ]]; then
        if question "Found old nvim config. Backup?"; then
            mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
        fi
	rm -r "${HOME}/.config/nvim"
    fi

    mkdir -p "${HOME}/.config"
    ln -s \
        "${DOTFILES_BASE_DIR}/shell/neovim" \
        "${HOME}/.config/nvim"
fi

if question "Setup Git?"; then
    if [[ ! -d "$HOME/.gitconfig" ]]; then
        if question "Found old git conf. Backup?"; then
            mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
        fi
    fi
    
    install_gitconfig
    
    printf "Don't Forget:\n"
    printf "  git config --global user.name 'Your Name'\n"
    printf "  git config --global user.email 'you@email.com'\n"
fi

if question "Setup SSH Config?"; then
    if [[ ! -d "$HOME/.ssh" ]]; then
        if question "Found old ssh conf. Backup?"; then
            mv "$HOME/.ssh" "$HOME/.ssh.bak"
        fi
    fi

    # Symlink the entire folder
    ln -s \
        "${DOTFILES_BASE_DIR}/shell/ssh" \
        "${HOME}/.ssh"

    # Create the sockets folder
    mkdir -p $HOME/.ssh/sockets
fi

if question "Setup Gnome Settings"; then
    if question "Setup UI?"; then
        install_gnome_interface
    fi
    if question "Setup Custom Keybinds?"; then
        install_gnome_keybindings
    fi
fi

if question "Done. Exec ZSH?"; then
    exec zsh
fi
