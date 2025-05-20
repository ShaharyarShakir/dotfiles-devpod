#!/bin/bash
set -e

NVIM_DIR="$HOME/.config/nvim"

if [ -d "$NVIM_DIR" ]; then
  echo "⚠️ $NVIM_DIR already exists. Backing it up to ${NVIM_DIR}.bak"
  mv "$NVIM_DIR" "${NVIM_DIR}.bak"
fi

echo "📥 Installing LazyVim starter template..."
git clone https://github.com/LazyVim/starter "$NVIM_DIR"

echo "🧹 Removing Git history from cloned repo..."
rm -rf "$NVIM_DIR/.git"

echo "✅ LazyVim installation complete!"
echo "➡️  Launch Neovim with: nvim"
