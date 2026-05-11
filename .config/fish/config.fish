set -g theme_title_use_abbreviated_path no
set -g theme_complete_path yes
set -gx EDITOR nvim

# fish startup greeting
set -U fish_greeting ""

# set dotfiles alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

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

# BOBTHEFISH SETTINGS
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_color_scheme base16-dark

# nvim alias
alias vim='nvim'
alias vimdiff='nvim -d'
alias oldvim='\vim'
