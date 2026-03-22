#!/bin/bash

# Define the list of folders to process
FOLDERS=(
  "nvim-python"
  "nvim-ts"
  "nvim-go"
  "nvim-flutter"
  "nvim-java"
)

# Function to create symlink for keymaps.lua
create_keymaps_symlink() {
  local folder=$1
  local target_path="$HOME/dotfiles/nvim/$folder/lua/config/keymaps.lua"

  # Delete existing symlink if it exists
  if [ -L "$target_path" ]; then
    rm "$target_path"
    echo "Removed existing symlink for keymaps.lua in $folder"
  fi

  ln -s "$HOME/dotfiles/nvim/shared/keymaps.lua" "$target_path"
  echo "Created symlink for keymaps.lua in $folder"
}

create_plugins() {
  local folder=$1
  local target_path="$HOME/dotfiles/nvim/$folder/lua/plugins"
  local source_path="$HOME/dotfiles/nvim/shared/plugins"
  local shared_link="$target_path/shared"

  # Create the target folder if it doesn't exist
  if [ ! -d "$target_path" ]; then
    mkdir -p "$target_path"
    echo "Created directory: $target_path"
  fi

  # Remove old individual file symlinks pointing into shared/plugins
  for file in "$source_path"/*; do
    local base
    base=$(basename "$file")
    local old_link="$target_path/$base"
    if [ -L "$old_link" ]; then
      rm "$old_link"
      echo "Removed old file symlink $base in $folder"
    fi
  done

  # Create a single directory symlink: lua/plugins/shared → shared/plugins
  if [ -L "$shared_link" ]; then
    rm "$shared_link"
    echo "Removed existing shared symlink in $folder"
  fi

  ln -s "$source_path" "$shared_link"
  echo "Symlinked shared/ → $folder/lua/plugins/shared"
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

    # Delete existing symlink if it exists
    if [ -L "$target_file" ]; then
      rm "$target_file"
      echo "Removed existing symlink for $base in $folder"
    fi

    ln -s "$file" "$target_file"
    echo "Symlinked $base → $folder"
  done
}

create_ai_symlink() {
  local folder=$1
  local target_path="$HOME/dotfiles/nvim/$folder/lua/ai"

  # Delete existing symlink if it exists
  if [ -L "$target_path" ]; then
    rm "$target_path"
    echo "Removed existing symlink for ai in $folder"
  fi

  ln -s "$HOME/dotfiles/nvim/shared/ai/" "$target_path"
  echo "Created symlink for ai in $folder"
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
