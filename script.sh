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
    ez
    bat
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






