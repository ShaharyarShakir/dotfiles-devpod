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

# Install Homebrew
echo
echo "###########################################"
echo "Installing Homebrew"
echo "###########################################"
bash scripts/brew.sh

# Install packages
echo
echo "###########################################"
echo "Installing Packages"
echo "###########################################"

if [ ! -f "$PACKAGE_FILE" ]; then
  echo "❌ $PACKAGE_FILE not found!"
  exit 1
fi

echo "📦 Reading packages from $PACKAGE_FILE..."

while IFS= read -r pkg || [[ -n "$pkg" ]]; do
    # Skip empty lines and comments
    [[ -z "$pkg" ]] && continue
    [[ "$pkg" == \#* ]] && continue

    if brew list --formula | grep -q "^${pkg}\$"; then
        echo "✔ $pkg is already installed, skipping."
    else
        echo "➤ Installing $pkg..."
        brew install "$pkg"
    fi
done < "$PACKAGE_FILE"

echo "✅ All packages are installed."
echo

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
echo "➡️  You can now run: source ~/.bashrc"
echo
echo "###########################################"
echo "################ END ######################"
echo "###########################################"
