export ZSH="/home/renan/.oh-my-zsh"
alias nv="/home/renan/nvim/nvim.appimage"
alias jetbrains="/opt/jetbrains-toolbox-1.22.10740/jetbrains-toolbox"

alias dotfiles="nv /home/renan/dotfiles/.zshrc"
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

# PYENV
SPACESHIP_PYENV_PREFIX="python:("
SPACESHIP_PYENV_SUFFIX=") "
SPACESHIP_PYENV_SYMBOL=""

###############################################
plugins=(git)
plugins=(asdf)
source $ZSH/oh-my-zsh.sh

###############################################
# asdf setup
###############################################

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

#############################
# Work alias
#############################
alias chatclass="cd /home/renan/Desktop/Chatclass"

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
source /home/renan/anaconda3/bin/activate

#############################
# Ngrok 
#############################
alias ngrok-3100="sh /home/renan/Desktop/start-ngrok-3100.sh"
alias ngrok-4000="sh /home/renan/Desktop/start-ngrok-4000.sh"

