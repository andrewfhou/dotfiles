# this file is processed on each interactive invocation of bash

# avoid problems with scp -- don't process the rest of the file if non-interactive
[[ $- != *i* ]] && return

# source git auto completion
source ~/.git-prompt.sh

# git aware bash prompt with status code indicator and some other nice fluff
export PS1='\[\e[01;30m\]\t`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo "\[\e[31m\] ✘ "; fi`\[\e[00;37m\]\u@\H\[\e[01;37m\]:`[[ $(git status 2>/dev/null) =~ Changes\ to\ be\ committed: ]] && echo "\[\e[33m\]" || echo "\[\e[31m\]"``[[ ! $(git status 2> /dev/null) =~ nothing\ to\ commit,\ working\ .+\ clean ]] || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\]\w\[\e[00m\]\$ '

# History configuration
HISTSIZE=100
HISTCONTROL=ignoreboth

# set vim to be default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Strip permissions from group and others when creating new files
umask 077

# Load bash aliases file
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

# Add cs240/bin to PATH
export PATH=$PATH:~cs240/bin

