#!/usr/bin/env bash

function install_gitconfig() {
    # Git Aliases
    git config --global alias.bb "!${DOTFILES_BASE_DIR}/shell/git/better-branch.sh"
    git config --global alias.ca "!${DOTFILES_BASE_DIR}/shell/git/clone-all.sh"

    # Push Settings
    git config --global push.autoSetupRemote true

    # Git LFS Filter
    git config --global filter.lfs.clean "git-lfs clean -- %f"
    git config --global filter.lfs.smudge "git-lfs smudge -- %f"
    git config --global filter.lfs.process "git-lfs filter-process"
    git config --global filter.lfs.required true

    # Pager Settings (using bat)
    if which bat &> /dev/null; then
        git config --global pager.diff "bat"
    fi

    printf "Run 'gh auth login' + 'gh auth setup-git' after!"
}

