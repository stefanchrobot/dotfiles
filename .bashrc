#!/bin/bash

# 
# If not running interactively, don't do anything
# The $- variable contains the currently set shell flags.
# See (run) also:
# 
#   $ help set
#
case $- in
    *i*) ;;
      *) return;;
esac


# 
# Enable "**" to match recursively, i.e.: ls **/*.txt
# 
# https://www.gnu.org/software/bash/manual/bash.html#The-Shopt-Builtin
# 
# If on OSX, upgrade to bash 4.x.x for this to work.
# 
# $ brew install bash
# $ sudo -i
# # echo "$(brew --prefix)/bin/bash" >> /etc/shells
# # exit
# $ chsh -s $(brew --prefix)/bin/bash
# 
shopt -s globstar


# 
# Make sure the terminal wraps the lines correctly after resizing the window.
# From the Bash man page:
#
#   Check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
#
shopt -s checkwinsize


# 
# aliases
# 

# A - include starting with ".", ignore "." and ".."
# F - show "/" at dirs + others
# G - colorize output
# h - use human-readable file sizes, i.e. KB, MB, etc.
# l - use long format, i.e. item per line
alias lsx='ls -AFGhl'
alias tigs='tig status'
alias tiga='tig --all'

alias ssh-agent-start='eval "$(ssh-agent -s)"'

#
# SSH between host (mbp) and guest (vm)
#
alias sshvm='ssh -p 3022 stefan@127.0.0.1'
alias sshmbp='ssh -p 22 stefan@10.0.2.2'
alias sshfsvm='sshfs -p 3022 stefan@127.0.0.1: ~/vm'
alias sshfsmbp='sshfs -p 22 stefan@10.0.2.2: ~/mbp'


# 
# Bash completion
# 
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
elif [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi


# 
# Git
# - Bash completion
# - extended bash prompt
# 
# see sourced files for documentation
# 
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWUPSTREAM="auto,verbose"
GIT_PS1_SHOWCOLORHINTS=1

source ~/.git-completion.bash
source ~/.git-prompt.sh


# 
# Customize Bash prompt
# 
# see: http://unix.stackexchange.com/a/193660
# 
function color_bash_prompt {
  # 
  # Color definitions
  # 
  # usage: \[$(color_name)\]
  # see: http://unix.stackexchange.com/questions/140610/using-variables-to-store-terminal-color-codes-for-ps1#comment227276_140615
  #      http://stackoverflow.com/a/6086978
  # 
  local black="$(tput setaf 0 2>/dev/null || echo '\e[0;30m')"
  local red="$(tput setaf 1 2>/dev/null || echo '\e[0;31m')"
  local green="$(tput setaf 2 2>/dev/null || echo '\e[0;32m')"
  local yellow="$(tput setaf 3 2>/dev/null || echo '\e[0;33m')"
  local blue="$(tput setaf 4 2>/dev/null || echo '\e[0;34m')"
  local magenta="$(tput setaf 5 2>/dev/null || echo '\e[0;35m')"
  local cyan="$(tput setaf 6 2>/dev/null || echo '\e[0;36m')"
  local white="$(tput setaf 7 2>/dev/null || echo '\e[0;37m')"

  local bold_black="$(tput setaf 0 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;30m')"
  local bold_red="$(tput setaf 1 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;31m')"
  local bold_green="$(tput setaf 2 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;32m')"
  local bold_yellow="$(tput setaf 3 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;33m')"
  local bold_blue="$(tput setaf 4 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;34m')"
  local bold_magenta="$(tput setaf 5 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;35m')"
  local bold_cyan="$(tput setaf 6 2>/dev/null)$(tput bold 2>/dev/null || echo '\e[1;36m')"
  local bold_white="$(tput setaf 7 2>/dev/null)$(tput bold 2/dev/null || echo '\e[1;37m')"

  local underline_black="$(tput setaf 0 2>/dev/null)$(tput smul 2>/dev/null || echo '\e[4;30m')"
  local underline_red="$(tput setaf 1 2>/dev/null)$(tput smul 2>/dev/null || echo '\e[4;31m')"
  local underline_green="$(tput setaf 2 2>/dev/null)$(tput smul 2>/dev/null || echo '\e[4;32m')"
  local underline_yellow="$(tput setaf 3 2>/dev/null)$(tput smul 2>/dev/null || echo '\e[4;33m')"
  local underline_blue="$(tput setaf 4 2>/dev/null)$(tput smul 2>/dev/null || echo '\e[4;34m')"
  local underline_magenta="$(tput setaf 5 2>/dev/null)$(tput smul 2>/dev/null || echo '\e[4;35m')"
  local underline_cyan="$(tput setaf 6 2>/dev/null)$(tput smul 2>/dev/null || echo '\e[4;36m')"
  local underline_white="$(tput setaf 7 2>/dev/null)$(tput smul 2>/dev/null || echo '\e[4;37m')"

  local background_black="$(tput setab 0 2>/dev/null || echo '\e[40m')"
  local background_red="$(tput setab 1 2>/dev/null || echo '\e[41m')"
  local background_green="$(tput setab 2 2>/dev/null || echo '\e[42m')"
  local background_yellow="$(tput setab 3 2>/dev/null || echo '\e[43m')"
  local background_blue="$(tput setab 4 2>/dev/null || echo '\e[44m')"
  local background_magenta="$(tput setab 5 2>/dev/null || echo '\e[45m')"
  local background_cyan="$(tput setab 6 2>/dev/null || echo '\e[46m')"
  local background_white="$(tput setab 7 2>/dev/null || echo '\e[47m')"

  local reset="$(tput sgr 0 2>/dev/null || echo '\e[0m')"

  local hash_or_dollar="\[$green\]\\$"
  local username="\[$blue\]\u"
  local colon="\[$green\]:"
  local short_hostname="\[$blue\]\h"
  local working_dir="\[$yellow\]\w"
  local git_prompt_exec='$(__git_ps1 "(%s)")'
  local git_prompt="\[$magenta\]$git_prompt_exec"
  local right_angle="\[$green\]>\[$reset\]"

  # $user:host ~/dir/repo (master)> 
  export PS1="$hash_or_dollar$username$colon$short_hostname $working_dir $git_prompt$right_angle "
}
color_bash_prompt


# 
# Machine-specific extras
# 
if [ -f ~/.bash_extra.sh ]; then
  . ~/.bash_extra.sh
fi

