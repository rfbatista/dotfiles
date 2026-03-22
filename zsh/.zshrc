#!/usr/bin/zsh
source $HOME/dotfiles/zsh/antigen.zsh

# Load environment variables from ~/.env if present.
if [[ -f "$HOME/dotfiles/.env" ]]; then
  set -a
  source "$HOME/dotfiles/.env"
  set +a
fi

alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'

#############################
# zellij
#############################
# eval "$(zellij setup --generate-auto-start zsh)"
# eval "$(bash $HOME/dotfiles/scripts/zl-list.sh)"
# eval "$(zellij setup --generate-auto-start zsh)"
#!/usr/bin/env bash
alias zl="zellij --config $HOME/dotfiles/zellij/config.kdl"
alias z="$HOME/dotfiles/scripts/zellij-select-project.sh"
alias zls="$HOME/dotfiles/scripts/zl-list.sh"

#############################
# Flutter
#############################
export PATH="$HOME/Public/flutter/bin:$PATH"


# export UV_CACHE_DIR="/mnt/projetos/.cache/uv"
ZSH_THEME="spaceship"
# . /opt/asdf-vm/asdf.sh
alias m="$HOME/dotfiles/scripts/run-makefile.sh"

###########################################################
# AWS
###########################################################
alias aws-ls="aws configure list-profiles"

aws-prof() {
    local company_name="$1"

    if [ -z "$company_name" ]; then
        echo "Usage: aws-prof <company_name>"
        echo "Example: aws-prof enforce"
        return 1
    fi

    # Get profiles that start with the company name
    local matching_profiles=$(aws configure list-profiles | grep "^$company_name")

    if [ -z "$matching_profiles" ]; then
        echo "No profiles found with prefix: $company_name"
        echo "Available profiles:"
        aws configure list-profiles | nl
        return 1
    fi

    # List matching profiles
    echo "AWS profiles matching '$company_name':"
    echo "$matching_profiles" | nl

    # Prompt for profile selection
    echo -n "Enter profile number or name: "
    read selection

    # Handle numeric selection
    if [[ "$selection" =~ ^[0-9]+$ ]]; then
        local profile=$(echo "$matching_profiles" | sed -n "${selection}p")
        if [ -z "$profile" ]; then
            echo "Invalid profile number!"
            return 1
        fi
        export AWS_PROFILE="$profile"
        echo "Set AWS_PROFILE to: $profile"
    else
        # Handle name selection
        if echo "$matching_profiles" | grep -q "^$selection$"; then
            export AWS_PROFILE="$selection"
            echo "Set AWS_PROFILE to: $selection"
        else
            echo "Profile '$selection' not found in matching profiles!"
            return 1
        fi
    fi

    # Verify the profile is set
    echo "Current AWS profile: $AWS_PROFILE"
}

###########################################################
# GIT
###########################################################
  select_ssh_key() {
    local key
    echo "Select an SSH key from $HOME/.ssh:"
    select key in "$HOME/.ssh"/*; do
        if [[ -n "$key" ]]; then
            eval $(ssh-agent -s)
            command ssh-add $key
            export GIT_SSH_COMMAND="ssh -i $key -o IdentitiesOnly=yes"
            echo "GIT_SSH_COMMAND set to use key: $key"
            break
        else
            echo "Invalid selection."
        fi
    done
}

###########################################################
# KUBERNETES
###########################################################
alias k="kubectl"
alias mk="minikube"
alias mks="minikube status"

###########################################################
# TERRAFORM
###########################################################
alias t="terraform"
alias tg="terragrunt"

###########################################################
# PYTHON
###########################################################
alias uvr="uv run"

###########################################################
# NEOVIM
###########################################################
# alias nv="NVIM_APPNAME=nvim-default nvim"
alias nv="NVIM_APPNAME=nvim-default nvim"
alias nvjava="NVIM_APPNAME=nvim-java nvim"
alias nvgo="NVIM_APPNAME=nvim-go nvim"
alias nvpy="NVIM_APPNAME=nvim-python nvim"
alias nvts="NVIM_APPNAME=nvim-ts nvim"
alias nvfl="NVIM_APPNAME=nvim-flutter nvim"

###########################################################
# UTILITIES
###########################################################
ko(){
  command sudo kill $(sudo lsof -t -i:$1)
}

export SPACESHIP_CONFIG="$HOME/dotfiles/zsh/spaceship.zsh"

antigen use oh-my-zsh

# THEME
# antigen theme robbyrussell/oh-my-zsh themes/agnoster
# antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship
antigen theme spaceship-prompt/spaceship-prompt
# antigen theme fino-time

# ANTIGEN BUNDLES
antigen bundle aws
antigen bundle azure
antigen bundle command-not-found
antigen bundle copyfile
# antigen bundle docker
antigen bundle extract
antigen bundle git
antigen bundle node
antigen bundle npm
antigen bundle python
antigen bundle pip
antigen bundle screen
antigen bundle unixorn/autoupdate-antigen.zshplugin
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

antigen apply

vv() {
  select config in $(fd --max-depth 1 --glob 'nvim-*' $HOME/dotfiles/nvim )
  do NVIM_APPNAME=$(basename $config) nvim $@; break; done
}

# export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
alias swagger='sudo docker run --rm -it  --user $(id -u):$(id -g) -e GOPATH=$(go env GOPATH):/go -v $HOME:$HOME -w $(pwd) quay.io/goswagger/swagger'
alias aws='/usr/local/bin/aws'

# PODMAN
# podman system service --time=0 &  # start rootless socket if needed
# export DOCKER_HOST=unix:///run/user/$(id -u)/podman/podman.sock
export DOCKER_HOST=unix:///Users/$(whoami)/.local/share/containers/podman/machine/podman.sock
export TESTCONTAINERS_RYUK_DISABLED=true
alias docker="podman"

alias codefusion='./build/codefusion  -m ./model/Meta-Llama-3.1-8B-Instruct-Q8_0.gguf'

# POETRY
# alias poetry="$HOME/.local/bin/poetry"
fpath+=~/.zfunc
autoload -Uz compinit && compinit

##################
# Tmux
##################
alias tmuxa="tmux attach-session -t 0"

alias config="cd ~/.config/nvim"
alias dotf="cd $HOME/dotfiles"
alias ej="cd $HOME/projetos/education_journey/"
alias proj="cd $HOME/projetos/"
alias lg="lazygit"
alias ld="lazydocker"

export GOPATH="$HOME/go"
PATH="$GOPATH/bin:$PATH"

export PATH=$PATH:~/zig

###############################################
# asdf setup
###############################################
export PATH="$HOME/.asdf/shims:$PATH"
export PATH="$HOME/.asdf/bin:$PATH"

if [[ -f "$HOME/.asdf/asdf.sh" ]] then
  source "$HOME/.asdf/asdf.sh"
  source "$HOME/.asdf/completions/asdf.bash"
fi

#############################
# Javascript
#############################
alias ns="npm start"
alias nd="npm run start:dev"
alias ys="yarn start"
alias yd="yarn run start:dev"
alias yb="yarn run build"
alias yde="yarn run debug"
alias ydd="yarn run docker:api"

ts_setup(){
  command yarn --init
  command yarn add typescript -D
  command npx tsc --int
  command yarn add eslint --dev
  command yarn create @eslint/config
}

#############################
# Python
#############################
# source /home/renan/anaconda3/bin/activate  # commented out by conda initialize
alias poetry_shell='. "$(dirname $(poetry run which python))/activate"'
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"

###############################################
# Load machine-specific config (not in git)
###############################################
[[ -f "$HOME/dotfiles/zsh/.zshrc.local" ]] && source "$HOME/dotfiles/zsh/.zshrc.local"
