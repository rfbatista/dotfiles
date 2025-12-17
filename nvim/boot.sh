#!/bin/bash

# Define the list of folders to process
FOLDERS=(
  "nvim-python"
  "nvim-ts"
  "nvim-go"
  "nvim-flutter"
)

# Function to create symlink for keymaps.lua
create_keymaps_symlink() {
  local folder=$1
  local target_path="$HOME/dotfiles/nvim/$folder/lua/config/keymaps.lua"

  if [ ! -L "$target_path" ]; then
    ln -s "$HOME/dotfiles/nvim/shared/keymaps.lua" "$target_path"
    echo "Created symlink for keymaps.lua in $folder"
  else
    echo "Symlink for keymaps.lua in $folder already exists"
  fi
}

create_plugins() {
  local folder=$1
  local target_path="$HOME/dotfiles/nvim/$folder/lua/plugins"
  local source_path="$HOME/dotfiles/nvim/shared/plugins"

  # Create the target folder if it doesn't exist
  if [ ! -d "$target_path" ]; then
    mkdir -p "$target_path"
    echo "Created directory: $target_path"
  fi

  # Symlink each file from source
  for file in "$source_path"/*; do
    local base
    base=$(basename "$file")
    local target_file="$target_path/$base"

    if [ ! -L "$target_file" ]; then
      ln -s "$file" "$target_file"
      echo "Symlinked $base → $folder"
    else
      echo "Symlink for $base already exists in $folder"
    fi
  done
}

# Function to create symlink for whichkey_commands
create_whichkey_symlink() {
  local folder=$1
  local target_path="$HOME/dotfiles/nvim/$folder/lua/plugins/whichkey_commands"
  local source_path="$HOME/dotfiles/nvim/shared/whichkey_commands"

  # Create the target folder if it doesn't exist
  if [ ! -d "$target_path" ]; then
    mkdir -p "$target_path"
    echo "Created directory: $target_path"
  fi

  # Symlink each file from source
  for file in "$source_path"/*; do
    local base
    base=$(basename "$file")
    local target_file="$target_path/$base"

    if [ ! -L "$target_file" ]; then
      ln -s "$file" "$target_file"
      echo "Symlinked $base → $folder"
    else
      echo "Symlink for $base already exists in $folder"
    fi
  done
}

create_ai_symlink() {
  local folder=$1
  local target_path="$HOME/dotfiles/nvim/$folder/lua/ai"

  if [ ! -L "$target_path" ]; then
    ln -s "$HOME/dotfiles/nvim/shared/ai/" "$target_path"
    echo "Created symlink for ai in $folder"
  else
    echo "Symlink for ai in $folder already exists"
  fi
}

# Process each folder in the defined list
for folder in "${FOLDERS[@]}"; do
  echo "Processing folder: $folder"

  # Check if the folder exists
  if [ ! -d "$HOME/dotfiles/nvim/$folder" ]; then
    echo "Warning: Folder $HOME/dotfiles/nvim/$folder does not exist, skipping..."
    continue
  fi

  # Create necessary directories if they don't exist
  mkdir -p "$HOME/dotfiles/nvim/$folder/lua/config"
  mkdir -p "$HOME/dotfiles/nvim/$folder/lua/plugins"

  # Create symlinks
  create_keymaps_symlink "$folder"
  create_whichkey_symlink "$folder"
  create_ai_symlink "$folder"
  create_plugins "$folder"

  echo "Completed processing $folder"
  echo "---"
done

echo "All symlinks processed!"
