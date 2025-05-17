curl -fsSL https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/bash/.bashrc -o .bashrc

# installing Homebrew

bash scripts/brew.sh




packages=(
    fzf
    zoxide
    starship
    ripgrep
    neovim
    lazygit
    eza
    bat
    tmux
    curl
)

echo "Installing packages"
for pkg in "${packages[@]}"; do
    if brew list --formula | grep -q "^${pkg}\$"; then
        echo "✔ $pkg is already installed, skipping."
    else
        echo "➤ Installing $pkg..."
        brew install "$pkg"
    fi
done

echo "All packages are installed"


echo "Adding starship config"
mkdir -p ~/.config && touch ~/.config/starship.toml
curl -fsSL https://raw.githubusercontent.com/ShaharyarShakir/dotfiles/main/bash/starship.toml -o  ~/.config/starship.toml

#!/bin/bash
set -e

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




