#!/usr/bin/env bash

function install_gitconfig() {
    echo "[alias]" >> $HOME/.gitconfig
    echo "\tbb = !${DOTFILES_BASE_DIR}/shell/git/better-branch.sh" >> $HOME/.gitconfig
    echo "\tca = !${DOTFILES_BASE_DIR}/shell/git/clone-all.sh" >> $HOME/.gitconfig
    echo "[push]" >> $HOME/.gitconfig
    echo "\tautoSetupRemote = true" >> $HOME/.gitconfig
    echo "[filter "lfs"]" >> $HOME/.gitconfig
    echo "\tclean = git-lfs clean -- %f" >> $HOME/.gitconfig
    echo "\tsmudge = git-lfs smudge -- %f" >> $HOME/.gitconfig
    echo "\tprocess = git-lfs filter-process" >> $HOME/.gitconfig
    echo "\trequired = true" >> $HOME/.gitconfig
    echo "[pager]" >> $HOME/.gitconfig
    echo "\tdiff = bat" >> $HOME/.gitconfig

    printf "Run 'gh auth login' + 'gh auth setup-git' after!"
}

