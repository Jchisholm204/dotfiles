{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

# Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "nixos-framework"; # Define your hostname.
# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

# Enable networking
    networking.networkmanager.enable = true;

# Set your time zone.
    time.timeZone = "America/Toronto";

# Select internationalisation properties.
    i18n.defaultLocale = "en_CA.UTF-8";

# Enable the X11 windowing system.
    services.xserver.enable = true;

# Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

# Enable the Hypr Desktop Environment.
# programs.hyprland.enable = true;

# Configure keymap in X11
    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

# Enable CUPS to print documents.
    services.printing.enable = true;

# Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

# Enable touchpad support (enabled default in most desktopManager).
# services.xserver.libinput.enable = true;

# Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jacob = {
        isNormalUser = true;
        description = "Jacob Chisholm";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
#  thunderbird
        ];
        shell = pkgs.zsh;
    };
    users.defaultUserShell = pkgs.zsh;

# Allow unfree packages
    nixpkgs.config.allowUnfree = true;

# Include zsh
    programs.zsh.enable = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
    environment.systemPackages = with pkgs; [
        wget
            htop
            git
            gh
            neovim
            google-chrome
            tmux
            gnome.gnome-tweaks
            alacritty # Terminal
            fastfetch
            teams-for-linux # MS Teams
            zsh
            zsh-autosuggestions
            starship
            libgcc
            gcc
            libclang
            clang-tools
            rust-analyzer
            gnumake
            cmake
            gcc-arm-embedded
            fprintd
            unzip
            nix-ld
            tmux
            syncthing
            ];

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };

    programs.tmux = {
        enable = true;
        clock24 = true;
    };

# List services that you want to enable:
    services.fprintd.enable = true;
    services.fwupd.enable = true;
# Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.syncthing = {
        enable = true;
        openDefaultPorts = true;
    };
# Open ports in the firewall.
# networking.firewall.allowedTCPPorts = [ ... ];
# networking.firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# networking.firewall.enable = false;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.05"; # Did you read the comment?

}
