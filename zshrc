prompt='%F{blue}%m%f%B.%b%F{green}%n%f%B.%b%F{yellow}%4~%f %Bλ%b '

# Only set to nvim if it is not already set
: ${EDITOR:=nvim}
export EDITOR

# Emacs keybinding mode
bindkey -e

autoload -z edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line # like bash

alias e="${EDITOR}"

alias add="git add"
alias checkout="git checkout"
alias co="git checkout"
alias commit="git commit -v"
alias bl="git branch -l"
alias pull="git pull"
alias push="git push"
alias rebase="git rebase"
alias reset="git reset"
alias st="git status"
alias db="git branch -l | fzf | xargs git branch -d"
alias cob="git branch -l | fzf | xargs git checkout"
alias coba="git branch -la | fzf | xargs git checkout"

alias ls=exa
alias cat=bat

alias pr="hub pull-request"

alias dc="docker-compose"
alias dcup="docker-compose up"
alias dcr="docker-compose run --rm"

alias cp='cp -i'
alias grep='grep --colour'
alias mv='mv -i'
alias open=xdg-open

alias corgi=cargo
alias corgo=cargo
alias yanni=yarn

export LC_ALL=en_US.UTF-8

# Rust
export PATH=~/.cargo/bin:$PATH

# NPM
PATH="$HOME/.node_modules/bin:$PATH"
export npm_config_prefix=~/.node_modules
