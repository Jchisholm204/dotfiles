# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

distro_id=$(cat /etc/*release | grep "^ID=" | cut -d'=' -f2)
# Change source paths depending on distro (Desktop=Ubuntu:Laptop=Fedora)
# Setup for Fedora
if   [ "$distro_id" = "fedora" ]; then
    # Check and source Fedora Module Manager (if it exists)
    # Will be needed to use MPI once installed
    if [ -f "/etc/profile.d/modules.sh" ]; then
        source /etc/profile.d/modules.sh
    fi
    # Check and source ROS2 if it has been installed
    if [ -d "/usr/lib64/ros2-humble" ]; then
        source /usr/lib64/ros2-humble/setup.zsh
    elif [ -d "/usr/lib64/ros2-jazzy" ]; then
        source /usr/lib64/ros2-jazzy/setup.zsh
    fi

# Setup for Ubuntu
elif [ "$distro_id" = "ubuntu" ]; then
    # Attempt to load ROS2 Humble first
    if [ -d "/opt/ros/humble" ]; then
        source /opt/ros/humble/setup.zsh
    # If humble cannot be loaded, attempt to load whatever comes up
    # Do NOT load more than one ROS distro
    elif [ -d "/opt/ros" ]; then
        source "$(ls /opt/ros/* -d | head -n 1)/setup.zsh"
    fi
    # Test and export CUDA
    if [ -d "/usr/local/cuda-*" ]; then
        export PATH=/usr/local/cuda-*/bin${PATH:+:${PATH}}
        export LD_LIBRARY_PATH=/usr/local/cuda-*/lib64\${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
    fi
fi

if [ -d "$HOME/.local/bin/" ]; then
    export PATH=$PATH:$HOME/.local/bin
fi

# Export Function for ModelSim/Quartus if they are installed
# $1 type: quartus or modelsim_ase
function exportAltera() {
    # Validate Arguments
    if [ $# -ne 2 ]; then
        echo "Function exportAltera called with incorrect number of arguments"
        echo 'Expects two arguments: "program" & "version"'
        echo 'Program: "quartus" or "modelsim_ase"'
        echo 'Version: "18.1" or "13.0sp1"'
        return
    fi

    if [ -d "$HOME/altera/$2/$1" ]; then
        export PATH=$PATH:/home/jacob/altera/$2/$1/bin
        # echo "Exported Altera $1"
    elif [ -d "/opt/altera/$2/$1" ]; then
        export PATH=$PATH:/opt/intelFPGA/$2/$1/bin
        # echo "Exported intelFPGA $1"
    elif [ -d "$HOME/intelFPGA/$2/$1" ]; then
        export PATH=$PATH:/home/jacob/intelFPGA/$2/$1/bin
        # echo "Exported intelFPGA $1"
    elif [ -d "/opt/intelFPGA/$2/$1" ]; then
        export PATH=$PATH:/opt/intelFPGA/$2/$1/bin
        # echo "Exported intelFPGA $1"
    else
        echo "Error: $1 $2 not found"
    fi
}

# Only attempt to source modelsim + quartus on fedora
if   [ "$distro_id" = "fedora" ]; then
# Call the function to source the installed versions of modelsim/quartus
exportAltera "quartus" "13.0sp1"
exportAltera "modelsim_ase" "18.1"
fi
unfunction exportAltera

export EDITOR=nvim
export VISUAL=nvim

alias clear="clear && zsh"
alias got=git

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(
    sudo
    git
    web-search
    zsh-autosuggestions
    # archlinux
    # zsh-syntax-highlighting
    # fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"

# Display System info on terminal opening
if [ -f "/bin/fastfetch" ]; then
    fastfetch --config examples/9
elif [ -f "/bin/neofetch" ]; then
    neofetch --ascii_distro tiny
fi

