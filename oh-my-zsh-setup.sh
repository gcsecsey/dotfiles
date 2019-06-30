#!/usr/bin/env bash

# How to install:
# sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/gcsecsey/dotfiles/master/oh-my-zsh-setup.sh)"

# Install oh-my-zsh
curl -Lo install.sh https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sh install.sh --unattended

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# Download zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions

# Download zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting

# Download zsh-completions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions

# Download powerlevel10k
git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k

# Download and set pure power config
( cd ~ && curl -Lo .purepower https://raw.githubusercontent.com/romkatv/dotfiles-public/master/.purepower )
echo 'source ~/.purepower' >> ~/.zshrc

# Chmod plugins to avoid ZSH COMPFIX errors
chmod 755 ${ZSH_CUSTOM}/plugins/*

# Change plugins in .zshrc
sed -i -e 's/plugins=.*/plugins=(docker git npm zsh-autosuggestions zsh-syntax-highlighting zsh-completions)/g' ${HOME}/.zshrc

# Change ZSH_THEME in .zshrc
sed -i -e 's/ZSH_THEME=.*/ZSH_THEME=\"powerlevel10k\/powerlevel10k\"/g' ${HOME}/.zshrc

