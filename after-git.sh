#!/usr/bin/env sh

# Run `before-git.sh` first

# exit if any command fails
set -e

systemctl stop --user emacs

cd ~/.doom.d && rm ~/.doom.d/* && git clone git@github.com:rubensseva/doom-config.git ~/.doom.d && ~/.emacs.d/bin/doom sync

systemctl start --user emacs

mkdir -p ~/Code/Ruben
cd ~/Code/Ruben

git clone git@github.com:rubensseva/dotfiles.git

cd dotfiles

sh apply.sh
