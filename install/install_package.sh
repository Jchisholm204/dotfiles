#!/usr/bin/env bash

DISTRO=$(cat /etc/*release | grep "^ID=" | cut -d'=' -f2)

function install_package() {
    local PACKAGE=$1
    printf "Installing %s...\n" "$PACKAGE"

    # Strip any potential hidden carriage returns or trailing whitespace from DISTRO
    # Strip trailing space, newlines, literal single/double quotes
    local CLEAN_DISTRO=$(echo "$DISTRO" | tr -d '\r\n[:space:]"'\''')

    case "$CLEAN_DISTRO" in
        "fedora")
            sudo dnf install -y "$PACKAGE"
            ;;
        "almalinux")
            sudo dnf install -y "$PACKAGE"
            ;;
        "archlinux")
            sudo pacman -Sy $PACKAGE
            ;;
        "ubuntu")
            sudo apt-get install $PACKAGE -y
            ;;
        *)
            printf "Error: Unknown Distro \"%s\"\n" "$CLEAN_DISTRO" >&2
            return 1
            ;;
    esac

    # Check the exit code of the dnf command ($?)
    if [[ $? -ne 0 ]]; then
        printf "Error installing package %s\n" "$PACKAGE" >&2
        return 1
    fi

    return 0
}
