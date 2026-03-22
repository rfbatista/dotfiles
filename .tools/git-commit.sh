#!/usr/bin/env bash

set -e

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 <commit message>"
  exit 1
fi

git commit -m "$*"
