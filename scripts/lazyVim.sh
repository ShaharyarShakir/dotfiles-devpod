#!/bin/bash
set -e
# required
rm -rf ~/.config/nvim
mkdir -p ~/.config/nvim
echo "📥 Installing LazyVim starter template..."
git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"

rm -rf "$HOME/.config/nvim/.git"

echo "✅ LazyVim installation complete!"
