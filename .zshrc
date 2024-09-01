# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

distro_id=$(cat /etc/*release | grep "^ID=" | cut -d'=' -f2)
if   [ "$distro_id" = "fedora" ]; then
    source /etc/profile.d/modules.sh
elif [ "$distro_id" = "ubuntu" ]; then
    # source /etc/profile.d/modules.sh
    source /opt/ros/humble/setup.zsh
fi


export EDITOR=nvim
export VISUAL=nvim

#alias clear="clear && zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
    sudo
    git
    web-search
    zsh-autosuggestions
    archlinux
    #zsh-syntax-highlighting
    #fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

# Display System info on terminal opening
fastfetch --config examples/9
