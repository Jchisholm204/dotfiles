# JChisholm204's dotfiles
This repo contains the bulk of the dotfiles I use on a daily basis.
- Applications
    - Alacritty (GUI Terminal Client)
    - Gnome (keybinds and basic configuration)
    - GH (GitHub Client/Authenticator)
    - Syncthing
    - Flatseal (FlatPak management GUI)
- Fonts
    - FiraMono NerdFont
- Shell (Apps/Utilities)
    - Git
    - Neovim
    - SSH
    - tmux
    - zsh


>[!WARNING]
>Use at your own risk.

# Installation
To install these dotfiles:
1. Clone this repository somewhere on your system. (eg, `$HOME/dotfiles`)
2. Run the interactive `./install.sh` script.
3. Interactively select install options

Supported Distributions for Package Installation:
- AlmaLinux 10 (Tier 1)
- Fedora 40/41/42 (Tier 1)
- ArchLinux (Not in several years)
- Debian/Ubuntu (Tier 3)

During installation, you will be asked to specify which dotfiles/configurations to apply.
This script can/should not be run headless.
Configuring GUI options on a non GNOME system will not work.

## Post-Install
After installing, the following manual configuration may be required.
1. Setup GH authorization `gh auth login`/`gh auth setup-git`
2. Launch TMUX and execute `<ctrl>-<space> + <shift>-I` to install plugins
3. Open Neovim to install plugins

# Usage

## Alacritty
Alacritty is my terminal of choice.
The Alacritty setup also includes references to the nerdfonts I like to use.
To launch Alacritty, use `<Super>-Q`.

## Git
The Git config contains some basic helper scripts and such I like to use on my machines.
The Git configuration was largely stolen from various sources, so check the readme in the git folder for more information.
Extra Git Commands:
- `git bb`: Better Branch
- `git ca`: Clone all branches from the remote

Extra Git Options:
- LFS Configuration
- Use `bat` as the default pager (You must have previously installed bat)


## Gnome
Gnome configuration is three-part.
1. Interface Configuration (Dark Mode, Fonts, Time/Battery format)
2. Keybindings
3. Extensions (#todo)

### Interface Configuration
- Accent Colors
- Clock Format
- Dark Mode
- Fonts (uses FiraMono)

### Keybindings
- `<Super>-c`: Close Active Window
- `<Super>-f`: Fullscreen toggle
- `<Super>-<shift>-s`: Screenshot
- `<Super>-1`: Switch to Workspace 1
- `<Super>-2`: Switch to Workspace 2
- `<Super>-3`: Switch to Workspace 3
- `<Super>-4`: Switch to Workspace 4
- `<Super>-0`: Switch to Workspace 5
- `<Super>-e`: Open File Explorer
- `<Super>-b`: Open Browser (Google Chrome)
- `<Super>-q`: Open Terminal (Alacritty)

## SSH
My SSH configuration.
You will likely want to delete many of the items in there.

## TMUX
My TMUX (Terminal Multiplexer) configuration.
Uses Vim keybindings and CTRL+SPACE as the prefix key.
This config also includes tmux restore to restart sessions after power loss.

## NeoVim
Source is at [https://github.com/Jchisholm204/neovim](https://github.com/Jchisholm204/neovim).

## ZSH
The most basic OhMyZsh configuration one could possibly think of.
Terminals should be KISS 'ed' (Keep It Stupid Simple) anyway.
