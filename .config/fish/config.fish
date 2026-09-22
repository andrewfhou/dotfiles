set -g theme_title_use_abbreviated_path no
set -g theme_complete_path yes
set -gx EDITOR nvim

# fish startup greeting
set -U fish_greeting ""

# set dotfiles alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# set grep -ri alias
function gri
    grep -ri $argv
end

# THE FUCK
function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    # history --delete $fucked_up_command
    # history --merge ^ /dev/null
  end
end

# set nvim alias
alias vim='nvim'
alias vimdiff='nvim -d'
alias oldvim='\vim'

# ruby gem installation path
set -gx GEM_HOME $HOME/gems

starship init fish | source

# Added by `rbenv init` on Wed Aug 12 02:26:48 PM EDT 2026
status --is-interactive; and rbenv init - --no-rehash fish | source
