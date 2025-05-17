#!/bin/bash
set -e

echo "###########################################"
echo "Starting installing the dotfiles for DevPod"
echo "###########################################"
echo

# Paths
PACKAGE_FILE="packages.txt"
BASHRC_URL="https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/bash/.bashrc"
STARSHIP_URL="https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/bash/starship.toml"
TMUX_CONF_URL="https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/tmux/.tmux.conf"

echo "📥 Adding .bashrc from the dotfiles repo"
curl -fsSL "$BASHRC_URL" -o "$HOME/.bashrc"

# Use Nix if available, else fall back to Homebrew
if command -v nix &> /dev/null; then
  echo
  echo "###########################################"
  echo "Installing packages using Nix"
  echo "###########################################"
  nix-env -iA nixpkgs.myPackages
else
  echo
  echo "###########################################"
  echo "Nix not found, installing packages with Homebrew"
  echo "###########################################"

  # Define your packages here
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
echo "✅ All packages are installed."

# Starship Config
echo "###########################################"
echo "Adding starship config"
echo "###########################################"
mkdir -p "$HOME/.config"
curl -fsSL "$STARSHIP_URL" -o "$HOME/.config/starship.toml"
echo

# Tmux + TPM
echo "📦 Installing tmux & TPM..."
if ! command -v tmux &> /dev/null; then 
  echo "➤ tmux not found, installing with Homebrew..."
  brew install tmux
fi

echo "➤ Downloading .tmux.conf..."
curl -fsSL "$TMUX_CONF_URL" -o "$HOME/.tmux.conf"

if [ -f scripts/tmux.sh ]; then
  echo "🚀 Running TPM setup script..."
  bash scripts/tmux.sh
else
  echo "❌ scripts/tmux.sh not found! Make sure you're in the right directory."
  exit 1
fi

# LazyVim Setup
echo
echo "###########################################"
echo "Installing plugins for Neovim (LazyVim)"
echo "###########################################"
bash scripts/lazyVim.sh
echo
echo "✅ Dotfile setup completed!"
echo "➡️ Now running: source ~/.bashrc"
source "$HOME/.bashrc"
echo "###########################################"
echo "################ END ######################"
echo "###########################################"
