#!/usr/bin/zsh

# Clear NVIM setup
# rm ~/.local/share/nvim

# Enable vi mode
alias httpie="AppImageLauncher /home/renan/Applications/HTTPie-2023.3.6_bc1b7fbc9017d1d0ec6e01c70298ef57.AppImage"
alias ink="/home/renan/Applications/Inkscape-091e20e-x86_64_2bd2bdeb4951060756249f31e3562326.AppImage"
export ZSH="/home/renan/.oh-my-zsh"
alias nv="/home/renan/neovim/build/bin/nvim"
alias nvim="/home/renan/neovim/build/bin"
alias jetbrains="/opt/jetbrains-toolbox-1.22.10740/jetbrains-toolbox"
alias config="cd ~/.config/nvim"
alias geny="cd /opt/genymobile/genymotion"

alias dotfiles="cd /home/renan/dotfiles"
alias ej="cd /projetos/education_journey/"
alias kgen="cd /home/renan/kgen"
alias personal="cd $HOME/personal"
alias stylua="/home/renan/dotfiles/stylua"
alias lg="lazygit"
alias ld="lazydocker"

export PATH=$PATH:$(/home/renan/.asdf/shims/go env GOPATH)/bin
plugins=(git asdf vi-mode)
MODE_INDICATOR="%F{white}+%f"
INSERT_MODE_INDICATOR="%F{yellow}+%f"
bindkey -v
#############################
# Architecture Decision Records 
#############################
alias adr="/home/renan/dotfiles/adr-tools/src/adr"

fpath+=~/.zfunc
autoload -Uz compinit && compinit

#############################
# Javscript
#############################
alias ns="npm start"
alias nd="npm run start:dev"
alias ys="yarn start"
alias yd="yarn run start:dev"
alias yb="yarn run build"
alias yde="yarn run debug"
alias ydd="yarn run docker:api"

alias denolint="/home/renan/deno_lint/target/debug/examples/dlint"

ts_setup(){
  command yarn --init 
  command yarn add typescript -D 
  command npx tsc --int 
  command yarn add eslint --dev
  command yarn create @eslint/config
}

#############################
# Linux
#############################
ko(){ 
  command sudo kill $(sudo lsof -t -i:$1)
  # port=$(lsof -i:$1 | grep LISTEN | awk '{print $2}')
  # if [ port ]; then
  #   command echo "Process number: " $(sudo lsof -t -i:$1)
  #   raw_ports=$(sudo lsof -t -i:$1)
  #   command echo "'$raw_ports'"
  #   post_list = (echo $raw_ports | cut -d'' -f2)
  #   for str in $post_list; do
  #     if read -q "Do you wish to kill this process?: ${post_list[$str]} "; then
  #       command echo "Killing the process"
  #       command kill -9 $(str)
  #     else
  #       command echo "'$choice' not 'Y' or 'y'. Exiting..."
  #     fi
  #   done
  # else 
  #   command echo "There is no service attached to this port"
  # fi
}

#############################
# Work alias
#############################
alias chatclass="cd /home/renan/Desktop/Chatclass"
alias study="cd /home/renan/Desktop/Studies"

#############################
# Android
#############################
alias android-studio="sh /home/renan/android-studio/bin/studio.sh"
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

#############################
# Python
#############################
# source /home/renan/anaconda3/bin/activate  # commented out by conda initialize
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"


#############################
# Ngrok 
#############################
alias ngrok-3100="~/dotfiles/ngrok http --region=us --hostname=renanchatclass.ngrok.io 3100"
alias ngrok-4000="~/dotfiles/ngrok http --region=us --hostname=renanchatclass.ngrok.io 4000"
alias ngrok-5000="~/dotfiles/ngrok http --region=us --hostname=renanchatclass.ngrok.io 5000"

#############################
# Fonts 
#############################
alias find-fonts="gucharmap"

#############################
# Google 
#############################
alias chrome='google-chrome --password-store=gnome'

# Polybar
alias start-polybar='polybar -c=$HOME/.config/polybar/config.ini -r i3'

# TMUX
tmux-session(){
  command tmux attach-session -t $1
}
tmux-commands(){
  echo ' 
    tmux ls List sessions
    tmux attach-session -t 0 Attach to session 0
    tmux kill-server kill all sessions
    Ctrl+b c Create a new window (with shell)
    Ctrl+b w Choose window from a list
    Ctrl+b 0 Switch to window 0 (by number )
    Ctrl+b , Rename the current window
    Ctrl+b % Split current pane horizontally into two panes
    Ctrl+b " Split current pane vertically into two panes
    Ctrl+b o Go to the next pane
    Ctrl+b ; Toggle between the current and previcus pane
    Ctrl+b x Close the current pane
  '
}

i3-commands(){
 echo '
General

  startx i3 start i3 from command line
  $mod+<Enter> open a terminal
  $mod+d open dmenu (text based program launcher)
  $mod+r resize mode ( or to leave resize mode)
  $mod+shift+e exit i3
  $mod+shift+r restart i3 in place
  $mod+shift+c reload config file
  $mod+shift+q kill window (does normal close if application supports it)

Windows
  
  $mod+w tabbed layout
  $mod+e vertical and horizontal layout (switches to and between them)
  $mod+s stacked layout
  $mod+f fullscreen

Moving Windows
  
  $mod+shift+<direction key> Move window in direction (depends on direction keys settings)
'
 }

# Studies Folder
alias study-notes="cd /home/renan/Desktop/Studies"

# Portfolio Folder
alias portfolio="cd /home/renan/Desktop/Portfolio"

alias zsh-file="nv /home/renan/dotfiles/.zshrc"

export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"

###############################################
# zsh theme
###############################################

ZSH_THEME="spaceship"
SPACESHIP_PROMPT_ORDER=(
time
dir
exec_time
git
node
golang
elixir
rust
venv
docker
line_sep
char
)
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_TIME_SHOW=true
SPACESHIP_CONDA_SHOW=true # Need to disable native conda prompt: conda config --set changeps1 False

# NODE
SPACESHIP_NODE_PREFIX="node:("
SPACESHIP_NODE_SUFFIX=") "
SPACESHIP_NODE_SYMBOL=""

# GOLANG
SPACESHIP_GOLANG_PREFIX="go:("
SPACESHIP_GOLANG_SUFFIX=") "
SPACESHIP_GOLANG_SYMBOL=""

# DOCKER
SPACESHIP_DOCKER_PREFIX="docker:("
SPACESHIP_DOCKER_SUFFIX=") "
SPACESHIP_DOCKER_SYMBOL=""

# VENV
SPACESHIP_VENV_PREFIX="venv:("
SPACESHIP_VENV_SUFFIX=") "

# PYTHON
SPACESHIP_PYTHON_PREFIX="python:("
SPACESHIP_PYTHON_SUFFIX=") "
SPACESHIP_PYTHON_SYMBOL=""

###############################################
source $ZSH/oh-my-zsh.sh

###############################################
# asdf setup
###############################################

alias asdf-shims="cd /home/renan/.asdf/shims"

if [[ -f "$HOME/.asdf/asdf.sh" ]] then
  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
fi

#. $HOME/.asdf/asdf.sh
# append completions to fpath
#fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
#autoload -Uz compinit && compinit

###############################################

#export NVM_DIR="/home/renan/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Docker configs
export PATH=/usr/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/renan/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/renan/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/renan/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/renan/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

