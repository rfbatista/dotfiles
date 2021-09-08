# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/dotfiles/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/renan/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
alias nv="/home/renan/nvim/nvim.appimage"

plugins=(git)
 
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/dotfiles/.p10k.zsh.
[[ ! -f ~/dotfiles/.p10k.zsh ]] || source ~/dotfiles/.p10k.zsh
