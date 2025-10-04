#!/usr/bin/env bash
# This script selects a project using gum and launches a zellij session in that directory.

# Set the projects directory. Change this as needed.
PROJECTS_DIR="${HOME}/projetos"

if [ ! -d "$PROJECTS_DIR" ]; then
  echo "Projects directory not found: $PROJECTS_DIR"
  exit 1
fi

# List all directories under the projects directory.
projects=$(find "$PROJECTS_DIR" -maxdepth 1 -mindepth 1 -type d 2>/dev/null | sort)

if [ -z "$projects" ]; then
  echo "No projects found in $PROJECTS_DIR."
  exit 1
fi

# Use gum to allow the user to select a project.
selected=$(echo "$projects" | gum choose --header "Select a project:")

if [ -z "$selected" ]; then
  echo "No project selected."
  exit 1
fi

echo "Opening project: $selected"
cd "$selected" || exit 1

SESSION_NAME=$(basename "$selected")
if zellij ls | grep -q "$SESSION_NAME"; then
    echo "Resurrecting existing session: $SESSION_NAME"
    exec zellij attach "$SESSION_NAME"
else
    echo "No session found. Creating new session: $SESSION_NAME"
    exec zellij --session "$SESSION_NAME"
fi
