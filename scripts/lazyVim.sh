#!/bin/bash
set -e

NVIM_DIR="$HOME/.config/nvim"

echo "🔍 Checking if $NVIM_DIR exists..."

if [ -e "$NVIM_DIR" ]; then
  if [ -f "$NVIM_DIR" ]; then
    echo "⚠️ $NVIM_DIR is a file. Backing it up and removing..."
    mv "$NVIM_DIR" "${NVIM_DIR}.bak"
  elif [ -d "$NVIM_DIR" ]; then
    echo "⚠️ $NVIM_DIR is a directory. Backing it up to ${NVIM_DIR}.bak"
    mv "$NVIM_DIR" "${NVIM_DIR}.bak"
  else
    echo "⚠️ $NVIM_DIR exists but is not a regular file or directory. Removing it..."
    rm -rf "$NVIM_DIR"
  fi
fi

echo "📥 Installing LazyVim starter template..."
git clone https://github.com/LazyVim/starter "$NVIM_DIR"

echo "🧹 Removing Git history from cloned repo..."
rm -rf "$NVIM_DIR/.git"

echo "✅ LazyVim installation complete!"
echo "➡️  Launch Neovim with: nvim"
