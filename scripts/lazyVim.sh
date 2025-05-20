#!/bin/bash
set -e
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
echo "📥 Installing LazyVim starter template..."
git clone https://github.com/LazyVim/starter "$HOME/.config/nvim"

echo "🧹 Removing Git history from cloned repo..."
rm -rf "$HOME/.config/nvim/.git"

echo "✅ LazyVim installation complete!"
echo "➡️  Launch Neovim with: nvim"