#!/bin/bash
set -e

echo "###########################################"
echo "Installing dotfiles and packages for DevPod"
echo "###########################################"
echo

# Setup XDG_CONFIG_HOME for Neovim and Nix
export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME/nixpkgs"

# Symlink dotfiles and configs
ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME/nvim"
ln -sf "$PWD/.bash_profile" "$HOME/.bash_profile"
ln -sf "$PWD/.bashrc" "$HOME/.bashrc"
ln -sf "$PWD/.inputrc" "$HOME/.inputrc"
ln -sf "$PWD/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME/nixpkgs/config.nix"

# Try installing Nix packages
if command -v nix &> /dev/null; then
  echo
  echo "###########################################"
  echo "Installing packages using Nix (from config.nix)"
  echo "###########################################"
  nix-env -iA nixpkgs.myPackages
else
  echo
  echo "⚠️ Nix is not installed. Falling back to Homebrew..."
  echo "###########################################"
  echo "Installing packages using Homebrew"
  echo "###########################################"

  packages=(
    fzf
    zoxide
    starship
    ripgrep
    lazygit
    eza
    bat
    tmux
  )

  for pkg in "${packages[@]}"; do
    if brew list --formula | grep -qx "$pkg"; then
      echo "✔ $pkg is already installed, skipping."
    else
      echo "➤ Installing $pkg..."
      brew install "$pkg"
    fi
  done
fi

echo
echo "✅ Package installation complete."

# Starship config
echo "📦 Setting up starship.toml..."
mkdir -p "$HOME/.config"
curl -fsSL "https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/bash/starship.toml" -o "$HOME/.config/starship.toml"

# Tmux Plugin Manager
echo "📦 Setting up tmux + TPM..."
curl -fsSL "https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/tmux/.tmux.conf" -o "$HOME/.tmux.conf"

if [ -f scripts/tmux.sh ]; then
  bash scripts/tmux.sh
else
  echo "⚠️ scripts/tmux.sh not found! Skipping TPM setup."
fi

# LazyVim
echo
echo "🚀 Installing Neovim plugins (LazyVim)..."
bash scripts/lazyVim.sh

echo
echo "✅ Dotfile setup completed!"
echo "➡️ Now running: source ~/.bashrc"
source "$HOME/.bashrc"

echo "###########################################"
echo "################ DONE #####################"
echo "###########################################"
