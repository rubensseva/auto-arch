#!/usr/bin/env sh

# Script to run before a github ssh keys are setup

# What you need to do before this is run:
# - working internet connection
# - user is properly set up with sudo

# exit if any command fails
set -e

cd ~

sudo pacman -Suy

sudo pacman -S --needed base-devel \
    git curl wget xclip ripgrep fd \
    xterm rxvt-unicode kitty zsh \
    vim emacs-nativecomp \
    xorg xorg-apps xorg-xinit \
    noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
    ttf-jetbrains-mono \
    ttf-dejavu \
    i3-gaps i3blocks i3lock i3status \
    bluez bluez-utils pulseaudio pulseaudio-alsa pulseaudio-bluetooth \
    firefox \
    docker docker-compose \
    tlp \
    openssh \
    go clojure leiningen sbcl \
    qbittorrent


git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
~/.emacs.d/bin/doom install --force

# Install yay
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

# enable ntp
timedatectl set-ntp true

# add user to docker group (requires login)
sudo gpasswd -a ruben docker

sudo systemctl enable bluetooth
sudo systemctl start bluetooth

systemctl enable --user pulseaudio
systemctl start --user pulseaudio

sudo systemctl enable docker
sudo systemctl start docker

systemctl enable --user emacs
systemctl start --user emacs

# enable and start tlp (check /etc/tlp.conf for config)
sudo systemctl enable tlp && systemctl start tlp

# Doom emacs golang specific dependencies
go install github.com/nsf/gocode@latest
go install golang.org/x/tools/cmd/godoc@latest
go install golang.org/x/tools/cmd/gorename@latest
go install github.com/x-motemen/gore/cmd/gore@latest
go install golang.org/x/tools/cmd/guru@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/cweill/gotests/gotests@latest
go install github.com/fatih/gomodifytags@latest

# Install google chrome, probably requires prompt
yay -S google-chrome-unstable

# Lastly, install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
