eval "$(mise activate zsh)"

HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_DUPS

autoload -Uz compinit && compinit

# Up/Down search history by the typed prefix, not just the first word.
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[OA' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey '^[OB' down-line-or-beginning-search

alias lsx='ls -AFGhl'
alias lg=lazygit
export HOMEBREW_NO_AUTO_UPDATE=1

# $user:host ~/path (main *+$ =)>
source /opt/homebrew/opt/git/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUPSTREAM=auto
setopt PROMPT_SUBST
PS1='%F{green}%(!.#.$)%F{blue}%n%F{green}:%F{blue}%m%f %F{yellow}%~%f %F{magenta}$(__git_ps1 "(%s)")%F{green}>%f '
