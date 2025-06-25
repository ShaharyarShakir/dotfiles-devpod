#!/bin/bash
set -e
# required
rm -rf ~/.config/nvim
echo "📥 Installing LazyVim starter template..."
cp -r "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
ln -s ~/dotfiles/nvim/ ~/.config/

rm -rf "$HOME/.config/nvim/.git"

echo "✅ LazyVim installation complete!"
