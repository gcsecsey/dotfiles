#!/usr/bin/env bash

# How to install:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/gcsecsey/dotfiles/master/oh-my-zsh-setup.sh)"

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Download zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Download zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Chmod plugins to avoid ZSH COMPFIX errors
chmod 755 ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/*

# Change plugins in .zshrc
sed -i -e 's/ZSH_THEME=\".*\"/ZSH_THEME=\"avit\"/g' $HOME/.zshrc

# Change ZSH_THEME to agnoster in .zshrc
sed -i -e 's/plugins=\".*\"/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' $HOME/.zshrc
