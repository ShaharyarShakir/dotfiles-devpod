#!/bin/bash
set -e
echo "###########################################"
echo "Starting installing the dotfiles for devpod"
echo "###########################################"
echo
echo "Adding bashrc from the dotfiles repo"
curl -fsSL https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/bash/.bashrc -o .bashrc

# install Homebrew
echo "###########################################"
echo "Installing Homebrew"
echo "###########################################"
bash scripts/brew.sh

# install packages from txt file
echo "###########################################"
echo "Installing Packages"
echo "###########################################"
PACKAGE_FILE="packages.txt"

if [ ! -f "$PACKAGE_FILE" ]; then
  echo "❌ $PACKAGE_FILE not found!"
  exit 1
fi

echo "📦 Reading packages from $PACKAGE_FILE..."

while IFS= read -r pkg || [[ -n "$pkg" ]]; do
    # Skip empty lines and comments
    [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue

    if brew list --formula | grep -q "^${pkg}\$"; then
        echo "✔ $pkg is already installed, skipping."
    else
        echo "➤ Installing $pkg..."
        brew install "$pkg"
    fi
done < "$PACKAGE_FILE"

echo "✅ All packages are installed."
echo

echo "###########################################"
echo "Adding starship config"
echo "###########################################"
mkdir -p ~/.config && touch ~/.config/starship.toml
curl -fsSL https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/bash/starship.toml -o  ~/.config/starship.toml
echo
echo "📦 Installing tmux & TPM..."
if ! command -v tmux &> /dev/null; then 
  echo "➤ tmux not found, installing with Homebrew..."
  brew install tmux
fi

# Always (re)fetch the latest .tmux.conf
echo "➤ Downloading .tmux.conf..."
curl -fsSL https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/tmux/.tmux.conf -o ~/.tmux.conf

# Run the TPM install script
if [ -f scripts/tmux.sh ]; then
  echo "🚀 Running TPM setup script..."
  bash scripts/tmux.sh
else
  echo "❌ scripts/tmux.sh not found! Make sure you're in the right directory."
  exit 1
fi
echo "###########################################"
echo "Installing plugins for  neovim(LazyVim)"
echo "###########################################"
bash scripts/lazyVim.sh

echo "###########################################"
echo "################ END ######################"
echo "###########################################"





