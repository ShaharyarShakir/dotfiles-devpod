#!/bin/bash
set -euo pipefail

echo "🔧 Checking for Homebrew..."

if ! command -v brew &> /dev/null; then
  echo "🧪 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "✅ Homebrew is already installed."
fi

# Determine the correct shell config file
SHELL_NAME="$(basename "$SHELL")"
if [[ "$SHELL_NAME" == "bash" ]]; then
  SHELL_RC="$HOME/.bashrc"
elif [[ "$SHELL_NAME" == "zsh" ]]; then
  SHELL_RC="$HOME/.zshrc"
else
  echo "⚠️ Unknown shell: $SHELL_NAME. Defaulting to .bashrc"
  SHELL_RC="$HOME/.bashrc"
fi

BREW_PATH_LINE='eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"'

# Add brew to PATH if not already added
if ! grep -Fxq "$BREW_PATH_LINE" "$SHELL_RC"; then
  echo "➕ Adding Homebrew to PATH in $SHELL_RC"
  echo "$BREW_PATH_LINE" >> "$SHELL_RC"
else
  echo "✔ PATH already contains Homebrew entry in $SHELL_RC"
fi

# Apply immediately if in current shell
eval "$BREW_PATH_LINE"
