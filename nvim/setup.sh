configs=("nvim-default" "nvim-node" "nvim-go")
commons=("autocommands.lua" "filetype.lua" "options.lua")


for key in "${configs[@]}"
do
  if [ ! \( -e "$HOME/.config/$key" \) ]
  then
    echo ln -s "$HOME/dotfiles/nvim/$key" "$HOME/.config/$key"
    ln -s "$HOME/dotfiles/nvim/$key" "$HOME/.config/$key"
  else
    echo "$key config already exists"
  fi
  for common in "${commons[@]}"
  do
    commonfile="$HOME/dotfiles/nvim/$key/lua/user/$common"
    if [ ! \( -e "$commonfile" \) ]
    then
      echo creating symling "$commonfile"
      ln -s "$HOME/dotfiles/nvim/$common" "$commonfile"
    else
      echo "$key commonfile already exists"
    fi
  done
  # for pluginlocal in $(ls $HOME/dotfiles/nvim/plugins/*)
  #   do
  #     pluginname=$(basename $pluginlocal)
  #     pluginfile="$HOME/dotfiles/nvim/$key/lua/user/shared/$pluginname" 
  #     if [ ! \( -e "$pluginfile" \) ]
  #     then
  #       echo creating symling "$pluginfile"
  #       ln -s "$HOME/dotfiles/nvim/plugins/$pluginname" "$pluginfile"
  #     else
  #       echo "$pluginname plugin already exists"
  #   fi
  # done
done
