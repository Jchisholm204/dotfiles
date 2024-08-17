# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source /etc/profile.d/modules.sh

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

