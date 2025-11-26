export VISUAL='nvim'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='$VISUAL'
fi
#
# zoxide
eval "$(zoxide init zsh)"

setopt COMBINING_CHARS # this is a fix for thai vowels

alias v="nvim"
alias l="ls -CF"
alias la="ls -CaF"
alias ll="ls -ClahF"
alias fastfetch="clear && fastfetch"
alias cp="rsync -ah --progress --no-inc-recursive --ignore-times --inplace" # I love rsync
