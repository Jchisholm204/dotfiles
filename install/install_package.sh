#!/usr/bin/env bash

DISTRO=$(cat /etc/*release | grep "^ID=" | cut -d'=' -f2)

function install_package() {
    local PACKAGE=$1
    printf "Installing %s...\n" "$PACKAGE"
    if [[ $DISTRO == "fedora" ]]; then 
        sudo dnf install $PACKAGE
    elif [[ $DISTRO == "almalinux" ]]; then
        sudo dnf install $PACKAGE
    elif [[ $DISTRO == "archlinux" ]]; then
        sudo pacman -Sy $PACKAGE
    elif [[ $DISTRO == "ubuntu" ]]; then
        sudo apt-get install $PACKAGE -y
    else
        printf "Error: Unknown Distro %s\n" $DISTRO &> 2
    fi
    if [[ $! -ne 0 ]]; then
        printf "Error installing package %s\n" $PACKAGE &> 2
        return 1
    fi
    return 0
}
