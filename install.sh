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

# Set up Zsh config using XDG-style, symlink to ~/.zshrc
echo "###########################################"
echo "Installing zsh config && setting it up"
echo "###########################################"

mkdir -p "$HOME/.config/zsh"
curl -fsSL "https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/refs/heads/main/zsh/.zshrc" -o "$HOME/.config/zsh/.zshrc"
ln -sf "$HOME/.config/zsh/.zshrc" "$HOME/.zshrc"

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
  echo "###########################################"
  echo "Installing packages using Homebrew"
  echo "###########################################"

  # Setup Homebrew in PATH
  HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  if [ -d "$HOMEBREW_PREFIX" ]; then
    echo "Setting up Homebrew in .zshrc..."
    echo "eval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\"" >> "$HOME/.config/zsh/.zshrc"
    eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
  fi

  if ! command -v brew &> /dev/null; then
    echo "brew command still not found, check Homebrew installation path!"
    exit 1
  fi

  # Install packages via Homebrew
  packages=(
    fzf
    zoxide
    ripgrep
    lazygit
    eza
    bat
    tmux
    yazi
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
echo "###########################################"
echo "Package installation complete."
echo "###########################################"

# Tmux Plugin Manager
echo "###########################################"
echo "Setting up tmux + TPM..."
echo "###########################################"

curl -fsSL "https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/tmux/.tmux.conf" -o "$HOME/.tmux.conf"

if [ -f scripts/tmux.sh ]; then
  bash scripts/tmux.sh
else
  echo "scripts/tmux.sh not found! Skipping TPM setup."
fi

# LazyVim
echo
echo "###########################################"
echo "🚀 Installing Neovim plugins (LazyVim)..."
echo "###########################################"

bash scripts/lazyVim.sh

echo
echo "###########################################"
echo "Dotfile setup completed!"
echo "###########################################"

# Source zshrc via symlink
source "$HOME/.zshrc"

echo
echo "###########################################"
echo "################ DONE #####################"
echo "###########################################"
