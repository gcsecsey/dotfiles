#!/usr/bin/env bash

# How to install:
# sudo bash -c "$(wget https://raw.githubusercontent.com/gcsecsey/dotfiles/master/install.sh -O -)"

# Ask for the administrator password upfront
sudo -v

# Make sure we’re using the latest repositories
apt update

# Install apps
apps=(
	curl
	git
	nodejs
	npm
	python
	python3
	python3-pip
	zsh
)

apt install -y "${apps[@]}"

# Set up oh-my-zsh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/gcsecsey/dotfiles/master/oh-my-zsh-setup.sh)"

git init
git remote add origin git@github.com:gcsecsey/dotfiles.git
git pull origin master

# Symlink SSH keys from Windows
ln -s "$(wslpath "$(wslvar USERPROFILE)")/.ssh" ~/.ssh

# Symlink dotfiles
for file in $(ls -A); do
  if [ "$file" != ".git" ] && \
     [ "$file" != "install.sh" ] && \
     [ "$file" != "oh-my-zsh-setup.sh" ] && \
     [ "$file" != "README.md" ] && \
     [ "$file" != "images" ]; then
      ln -sf $PWD/$file $HOME/
  fi
done
