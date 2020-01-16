# this file is processed on each interactive invocation of bash

# avoid problems with scp -- don't process the rest of the file if non-interactive
[[ $- != *i* ]] && return

# git + return-code aware bash prompt, with some other nice fluff
export PS1='\[\e[01;30m\]\t`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo"\[\e[31m\] ✘ "; fi`\[\e[00;37m\]\u@\H\[\e[01;37m\]:`[[ $(git status 2> /dev/null) =~ Changes\ to\ be\ committed: ]] && echo "\[\e[33m\]" || echo "\[\e[31m\]"``[[ ! $(git status 2> /dev/null) =~ nothing\ to\ commit,\ working\ .+\ clean ]] || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\]\w\[\e[00m\]\$ '

# export PS1='\[\e[01;30m\]\t`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo "\[\e[31m\] ✘ "; fi`\[\e[00;37m\]\u\[\e[01;37m\]:`[[ $(git status 2> /dev/null) =~ Changes\ to\ be\ committed: ]] && echo "\[\e[33m\]" || echo "\[\e[31m\]"``[[ ! $(git status 2> /dev/null) =~ nothing\ to\ commit,\ working\ .+\ clean ]] || echo "\[\e[32m\]"`$(__git_ps1 "(%s)\[\e[00m\]")\[\e[01;34m\]\w\[\e[00m\]\$ '

# History configuration
HISTSIZE=100
HISTCONTROL=ignoreboth

alias mail=mailx

# set vim to be default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Basic aliases to have common ls and grep commands and add colors
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -l"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Strip permissions from group and others when creating new files
umask 077

# CS240 environment + setup
# Add cs240/bin to PATH
export PATH=$PATH:~cs240/bin

