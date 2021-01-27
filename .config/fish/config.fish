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
    sudo rsync -aAX --info=progress2 --delete --exclude-from="/home/mweepigeon/Documents/backup_exclusion_list" /home/mweepigeon /mnt/backups
end
function rsync_restore
    sudo rsync -aAX --info=progress2 --delete --exclude-from="/home/mweepigeon/Documents/backup_exclusion_list" /mnt/backups /home/mweepigeon
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
set -x PATH /home/mweepigeon/Software/ctf-tools/bin $PATH
set -x PATH /home/mweepigeon/.cargo/bin $PATH
set -x PATH /home/mweepigeon/.vim/bundle/vim-superman/bin $PATH

# kdesrc-build initial setup
# kdesrc-build directory path
set -x PATH /home/mweepigeon/kde/src/kdesrc-build $PATH

function kdesrc-run
    source /home/mweepigeon/kde/build/$argv/prefix.sh; and /home/mweepigeon/kde/usr/bin/$argv
end

set NEVER_BUILD_LIST "Qt5 libdbusmenu-qt oxygen oxygen-icons5 kdegames akonadi telepathy-accounts-signon phonon kio-extras"
set ONLY_BUILD_RARELY_LIST "modemmanager-qt networkmanager-qt bluez-qt khtml kdelibs4support gpgme"
set PLASMA_PACKAGE_LIST "plasma-desktop plasma-workspace plasma-framework plasma-integration plasma-nm plasma-pa plasma-thunderbolt plasma-vault plasma-workspace-wallpapers kdeplasma-addons kwin systemsettings kscreen breeze discover kinfocenter kde-cli-tools print-manager plasma-sdk kirigami-gallery"

function kb
    set REPO (basename $PWD)
    kdesrc-build $REPO --no-src --resume-from $REPO
    set ERRORFILE ~/kde/src/log/latest/$REPO/error.log;
    if test -f $ERRORFILE
        cat $ERRORFILE
    end
end

function kbdeps
    set REPO (basename $PWD)
    kdesrc-build $REPO --ignore-modules $NEVER_BUILD_LIST
    set ERRORFILE ~/kde/src/log/latest/$REPO/error.log;
    if test -f $ERRORFILE
        cat $ERRORFILE
    end
end

# BROKEN
function build_plasma
    kdesrc-build $PLASMA_PACKAGE_LIST --include-dependencies --ignore-modules $NEVER_BUILD_LIST $ONLY_BUILD_RARELY_LIST; and echo 'Installing Plasma Dev session...'; and sudo ~/kde/build/plasma-workspace/login-sessions/install-sessions.sh
end

# BROKEN
function build_everything
    kdesrc-build $PLASMA_PACKAGE_LIST dolphin konsole kate gwenview okular spectacle elisa kamoso kup --include-dependencies --ignore-modules $NEVER_BUILD_LIST; and sudo ~/kde/build/plasma-workspace/login-sessions/install-sessions.sh
end

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

