#!/bin/bash

# Define the list of folders to process
FOLDERS=(
    "nvim-python"
    "nvim-ts"
    "nvim-go"
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

# Function to create symlink for whichkey_commands
create_whichkey_symlink() {
    local folder=$1
    local target_path="$HOME/dotfiles/nvim/$folder/lua/plugins/whichkey_commands"
    
    if [ ! -L "$target_path" ]; then
        ln -s "$HOME/dotfiles/nvim/shared/whichkey_commands" "$target_path"
        echo "Created symlink for whichkey_commands in $folder"
    else
        echo "Symlink for whichkey_commands in $folder already exists"
    fi
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
    
    echo "Completed processing $folder"
    echo "---"
done

echo "All symlinks processed!"
