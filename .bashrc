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
# http://ezprompt.net/
#
# $user:host ~/dir/repo (master)>
export PS1='\[\e[0;32m\]\$\[\e[0;34m\]\u\[\e[0;32m\]:\[\e[0;34m\]\h\[\e[m\] \[\e[0;33m\]\w\[\e[m\] \[\e[0;35m\]$(__git_ps1 "(%s)")\[\e[0;32m\]>\[\e[m\] \[\e0'

#
# Machine-specific extras
#
if [ -f ~/.bash_extra.sh ]; then
  . ~/.bash_extra.sh
fi

export ERL_AFLAGS="-kernel shell_history enabled"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
