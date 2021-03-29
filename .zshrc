export ZSH=~/.oh-my-zsh

# configure oh-my-zsh theme
ZSH_THEME="powerlevel10k/powerlevel10k" # load p10k as oh-my-zsh theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # load p10k personal config

# configure oh-my-zsh plugins
plugins=(docker docker-compose git git-flow zsh-nvm zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

# configure zsh-nvm
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true

# load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# add yarn to PATH
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
