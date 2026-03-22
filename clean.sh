#!/bin/bash

# Define the path to your .gitignore file
GITIGNORE_FILE=".gitignore"

# Check if the .gitignore file exists
if [ ! -f "$GITIGNORE_FILE" ]; then
    echo "Error: $GITIGNORE_FILE not found in the current directory."
    exit 1
fi

echo "Staging files to be removed from history based on $GITIGNORE_FILE..."

# Use git filter-repo with the --paths-from-file option
# This command rewrites your repository history.
git filter-repo --paths-from-file "$GITIGNORE_FILE" --invert-paths

if [ $? -eq 0 ]; then
    echo "History rewrite complete. Files in $GITIGNORE_FILE (and those matching patterns) have been removed from all commits."
    echo "Remember to force push the changes to remote repositories if necessary (git push --force-with-lease)."
else
    echo "An error occurred during git filter-repo execution."
fi

