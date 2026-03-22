#!/usr/bin/env bash
#
# Encrypts a string with a password using OpenSSL and prints a one-line decrypt command.
# Usage: ./openssl-encrypt-and-decrypt-script.sh "your secret string" "your-password"
#

set -e

usage() {
  echo "Usage: $0 \"<string to encrypt>\" \"<password>\""
  exit 1
}

if [[ $# -lt 2 ]]; then
  usage
fi

STRING="$1"
PASSWORD="$2"

# Encrypt the string with OpenSSL (AES-256-CBC, base64 encoded)
ENCRYPTED_BASE64=$(printf '%s' "$STRING" | openssl enc -aes-256-cbc -a -salt -pass "pass:${PASSWORD}")

# Print one-line decrypt command (replace YOUR_PASSWORD when running)
echo "echo '$ENCRYPTED_BASE64' | openssl enc -aes-256-cbc -d -a -salt"
