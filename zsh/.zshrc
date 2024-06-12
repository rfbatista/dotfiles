#!/usr/bin/zsh
source $HOME/dotfiles/zsh/antigen.zsh
# . /opt/asdf-vm/asdf.sh

antigen use oh-my-zsh

# THEME
# antigen theme robbyrussell/oh-my-zsh themes/agnoster
antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
# antigen theme robbyrussell

# ANTIGEN BUNDLES
antigen bundle aws
antigen bundle command-not-found
antigen bundle copyfile
# antigen bundle docker
antigen bundle extract
antigen bundle git
antigen bundle node
antigen bundle npm
antigen bundle pip
antigen bundle screen
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

vv() {
  select config in $(fd --max-depth 1 --glob 'nvim-*' ~/.config)
  do NVIM_APPNAME=$(basename $config) nvim $@; break; done
}

# export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
alias swagger='sudo docker run --rm -it  --user $(id -u):$(id -g) -e GOPATH=$(go env GOPATH):/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger'
alias aws='/usr/local/bin/aws'

# POETRY
alias poetry="$HOME/.local/bin/poetry"
fpath+=~/.zfunc
autoload -Uz compinit && compinit

##################
# Tmux
##################
alias tmuxa="tmux attach-session -t 0"

# Enable vi mode
alias httpie="AppImageLauncher /home/renan/Applications/HTTPie-2023.3.6_bc1b7fbc9017d1d0ec6e01c70298ef57.AppImage"
alias ink="/home/renan/Applications/Inkscape-091e20e-x86_64_2bd2bdeb4951060756249f31e3562326.AppImage"
export ZSH="/home/renan/.oh-my-zsh"
alias nv="NVIM_APPNAME=nvim-default $HOME/neovim/build/bin/nvim"
alias config="cd ~/.config/nvim"
alias dotf="cd $HOME/dotfiles"
alias ej="cd $HOME/projetos/education_journey/"
alias proj="cd $HOME/projetos/"
alias stylua="/home/renan/dotfiles/stylua"
alias lg="lazygit"
alias ld="lazydocker"

# export PATH=$PATH:$(/home/renan/.asdf/shims/go env GOPATH)/bin
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

#############################
# Android
#############################
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

#############################
# Python
#############################
# source /home/renan/anaconda3/bin/activate  # commented out by conda initialize


#############################
# Ngrok 
#############################

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
    <prefix> + $ Rename current session
    <prefix> + c Create a new window (with shell)
    <prefix> + w Choose window from a list
    <prefix> + 0 Switch to window 0 (by number )
    <prefix> + , Rename the current window
    <prefix> + % Split current pane horizontally into two panes
    <prefix> + " Split current pane vertically into two panes
    <prefix> + o Go to the next pane
    <prefix> + ; Toggle between the current and previcus pane
    <prefix> + x Close the current pane
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


export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"


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


# Created by `pipx` on 2024-05-05 03:54:36
export PATH="$PATH:/home/rfbatista/.local/bin"
