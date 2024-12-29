# Dotfiles Install Script
# Jchisholm204.github.io

# Get the distro ID (for apt install)
distro_id=$(cat /etc/*release | grep "^ID=" | cut -d'=' -f2)

echo "Installing JC204 Config"
C_DIR=$(pwd)
echo "Installing from $C_DIR"

echo "Have git submodules been initialized? [y/n]"
read -r ans
if [ "$ans" == "n" ]; then
    echo "Git submodules must be initialized..Doing it now"
    git submodule init
    git submodule update
fi

# Install Function (for different distros)
install() {
    if [ $1 == "" ]; then
        return 1
    fi
    echo "Installing $1 for $distro_id"
    if [ "$distro_id" = "fedora" ]; then
        sudo dnf install $1
    elif [ "$distro_id" = "ubuntu" ]; then
        sudo apt-get install $1
    elif [ "$distro_id" = "archlinux" ]; then
        pacman -S $1
    fi
    return 0
}

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

echo "Install Alacritty? [y/n]"
read -r ans
if [ "$ans" == "y" ]; then
    install "alacritty"
    if [ ! -d "$HOME/.config/alacritty" ]; then
        echo "Found an old Alacritty Config"
        echo "Would you like to backup? [y/n]"
        read -r ans
        if [ "$ans" == "y" ]; then
            mv "$HOME/.config/alacritty" "$HOME/.config/alacritty.bak"
        else
            rm -r "$HOME/.config/alacritty"
        fi
    fi
    ln -s $(pwd)/alacritty "$HOME/.config/"
fi


echo "Set up ZSH? [y/n]:"
read -r ans
if [ "$ans" == "y" ]; then
    install "zsh"
    echo "Install OhMyZsh? [y/n]"
    read -r ans
    if [ "$ans" == "y" ]; then
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "Cloning zsh-autosuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    fi
    if [ ! -d  "$HOME/.zshrc" ]; then
        echo "Found OLD ZSH Config: renamed to zshrc.bak"
        mv "$HOME"/.zshrc "$HOME"/zshrc.bak
    fi
    ln -s $(pwd)/.zshrc "$HOME"
    echo "Created ZSHrc Symlink"
fi

echo "Set up TMUX [y/n]"
read -r ans
if [ "$ans" == "y" ]; then
    if [ ! $(ls /bin | grep tmux) == "tmux"]; then
        echo "Attempting to install tmux"
        install "tmux"
    else
        echo "TMUX Installation Found"
    fi
    echo "Looking for old TMUX Config"
    if [ ! -d "$HOME/.tmux.conf" ]; then
        echo "Found an old TMUX Config"
        echo "Would you like to backup? [y/n]"
        read -r ans
        if [ "$ans" == "y" ]; then
            mv "$HOME/.tmux.conf" "$HOME/tmux.conf.bak"
        else
            rm "$HOME/.tmux.conf"
        fi
    fi
    ln -s $(pwd)/tmux/tmux.conf $HOME/.tmux.conf
    tmux source $HOME/.tmux.conf
fi

echo "Set up Git? [y/n]"
read -r ans
if [ "$ans" == "y" ]; then
    echo "Looking for old Git Config"
    if [ ! -d "$HOME/.gitconfig" ]; then
        echo "Found an old Git Config"
        echo "Would you like to backup? [y/n]"
        read -r ans
        if [ "$ans" == "y" ]; then
            mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak"
        else
            rm "$HOME/.gitconfig"
        fi
    fi
    ln -s "$(pwd)/git/.gitconfig" "$HOME/.gitconfig"
fi
    
echo "Install Completed."


