#!/bin/bash

# Extract Makefile targets (ignore comments, special targets, and prerequisites)
targets=$(grep -E '^[a-zA-Z0-9._-]+:' Makefile |
  cut -d':' -f1 |
  grep -v '^.PHONY$' |
  sort -u)

if [ -z "$targets" ]; then
  echo "No targets found in Makefile."
  exit 1
fi

# Let user choose with gum
choice=$(echo "$targets" | gum choose --header "Select a Make target to run:")

if [ -n "$choice" ]; then
  echo "👉 Running: make $choice"
  make "$choice"
else
  echo "No target selected."
fi
