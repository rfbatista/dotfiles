#Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/renan/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
alias nv="/home/renan/nvim/nvim.appimage"
alias jetbrains="/opt/jetbrains-toolbox-1.22.10740/jetbrains-toolbox"

plugins=(git)
 
source $ZSH/oh-my-zsh.sh


###############################################
# asdf setup
###############################################

. $HOME/.asdf/asdf.sh
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

###############################################

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh

export NVM_DIR="/home/renan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Docker configs
export PATH=/usr/bin:$PATH
export DOCKER_HOST=unix:///run/user/1000/docker.sock

#############################
# Work alias
#############################
alias chatclas="cd /home/renan/Desktop/Chatclass"


#############################
# Python
#############################
source /home/renan/anaconda3/bin/activate
