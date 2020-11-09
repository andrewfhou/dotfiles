set -g theme_title_use_abbreviated_path no
set -g theme_complete_path yes
set -gx EDITOR vim

# set PATH /snap/bin $PATH

thefuck --alias | source

# FISH GREETING (FORTUNE)
function fish_greeting
    if not type fortune > /dev/null 2>&1
                apt-get install fortune
    end
    fortune -a
end

function gri
    grep -ri $argv
end

# rsync backup commands
function rsync_backup
    sudo rsync -aAXv --delete --exclude-from="/home/mweepigeon/Documents/backup_exclusion_list" /home/mweepigeon /mnt/backups
end
function rsync_restore
    sudo rsync -aAXv --delete --exclude-from="/home/mweepigeon/Documents/backup_exclusion_list" /mnt/backups /home/mweepigeon
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

funcsave fish_greeting
funcsave fuck

# $PATH directories
set -x PATH /home/mweep/.vim/bundle/vim-superman/bin $PATH

# set sagemath alias
function sage
    /home/mweepigeon/Software/SageMath/sage
end

# set dotfiles alias
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# BOBTHEFISH SETTINGS
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_color_scheme base16-dark

# op25 alias
function op25
    bash /home/mweepigeon/Software/op25/op25.sh
end

