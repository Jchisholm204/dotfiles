#!/usr/bin/env bash

# GNOME Configuration Script
# Generated from gnome_settings.ini

install_gnome_interface() {
    echo "Configuring Desktop Interface..."
    gsettings set org.gnome.desktop.interface accent-color 'purple'
    gsettings set org.gnome.desktop.interface clock-format '12h'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
    gsettings set org.gnome.desktop.interface monospace-font-name 'FiraMono Nerd Font 12'
    gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 11'
    gsettings set org.gnome.desktop.interface show-battery-percentage true
    gsettings set org.gnome.desktop.interface enable-hot-corners false
    gsettings set org.gnome.desktop.interface font-antialiasing 'grayscale'
    gsettings set org.gnome.desktop.interface font-hinting 'slight'
}

install_gnome_keybindings() {
    echo "Configuring Window Manager and Keybindings..."
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 5
    
    # Custom Shortcuts
    gsettings set org.gnome.desktop.wm.keybindings close "['<Super>c']"
    gsettings set org.gnome.desktop.wm.keybindings toggle-maximized "['<Super>f']"
    gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"
    
    # Workspace Navigation
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']"
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-last "['<Super>0']"

    # Media and System Keys
    gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>e']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys search "['<Super>s']"
    gsettings set org.gnome.settings-daemon.plugins.media-keys www "['<Super>b']"

    # Custom Keybindings (Alacritty & Explorer)
    KEY_PATH="org.gnome.settings-daemon.plugins.media-keys.custom-keybinding"
    gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
    "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', \
      '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']"

    # custom0: Alacritty
    gsettings set $KEY_PATH:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name 'Alacritty'
    gsettings set $KEY_PATH:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command 'alacritty'
    gsettings set $KEY_PATH:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding '<Super>q'

    # custom1: Launch File Explorer
    gsettings set $KEY_PATH:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name 'Launch File Explorer'
    gsettings set $KEY_PATH:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command 'nautilus'
    gsettings set $KEY_PATH:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding ''

    # Shell Keybindings
    gsettings set org.gnome.shell.keybindings switch-to-application-1 "[]"
    gsettings set org.gnome.shell.keybindings switch-to-application-2 "[]"
    gsettings set org.gnome.shell.keybindings switch-to-application-3 "[]"
    gsettings set org.gnome.shell.keybindings switch-to-application-4 "[]"
    gsettings set org.gnome.shell.keybindings toggle-quick-settings "[]"
    gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Super>s']"

}
