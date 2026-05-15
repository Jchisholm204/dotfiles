#!/usr/bin/env bash

function question(){
    local PROMPT=$1
    local ans='-'
    until [[ $ans == 'y' || $ans == 'n' ]]; do
        printf "%s [y/n]: " "$PROMPT"
        read -r ans
    done
    if [[ $ans == 'y' ]]; then
        return 0
    else
        return 1
    fi
}

