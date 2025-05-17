#!/bin/bash
set -e

echo "📥 Installing LazyVim starter template..."
git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"

echo "🧹 Removing Git history from cloned repo..."
rm -rf "$HOME/.config/nvim/.git"

echo "✅ LazyVim installation complete!"
echo "➡️  Launch Neovim with: nvim"