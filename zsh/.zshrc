fpath=(~/.config/zsh/ ${fpath})

source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Add `skip_global_compinit=1` to ~/.zshenv
# autoload -Uz custom_prompt_setup && custom_prompt_setup 

#Paths
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Aliases
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='ga . && git commit -m '
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

alias vim="nvim"

eval "$(starship init zsh)"
