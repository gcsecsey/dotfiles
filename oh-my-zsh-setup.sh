#!/usr/bin/env bash

# How to install:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/gcsecsey/dotfiles/master/oh-my-zsh-setup.sh)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Change ZSH_THEME to agnoster in .zshrc
sed -i -e 's/ZSH_THEME=\".*\"/ZSH_THEME=\"agnoster\"/g' $HOME/.zshrc

# Download zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
