#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"
LAZYVIM_DIR="$DOTFILES/lazyvim"
NVIM_DIR="$DOTFILES/nvim"

echo "🔍 Checking if LazyVim is already installed..."

if [ -d "$LAZYVIM_DIR" ]; then
  echo "✔ LazyVim directory already exists: $LAZYVIM_DIR"
else
  echo "📥 Cloning LazyVim starter template into $LAZYVIM_DIR..."
  git clone https://github.com/LazyVim/starter "$LAZYVIM_DIR"
  rm -rf "$LAZYVIM_DIR/.git"
  echo "✅ LazyVim downloaded."
fi

echo "🔁 Replacing $NVIM_DIR with symlink to LazyVim..."

# Backup existing nvim config if needed
if [ -L "$NVIM_DIR" ] || [ -d "$NVIM_DIR" ]; then
  mv "$NVIM_DIR" "${NVIM_DIR}.bak"
fi

ln -sfn "$LAZYVIM_DIR" "$NVIM_DIR"

# Re-stow your dotfiles (optional)
cd "$DOTFILES"
stow nvim

echo "✅ LazyVim is now set up via Stow!"
echo "➡️  Launch Neovim with: nvim"
