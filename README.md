# dotfiles-devpod

**A starter template for initializing DevPod environments with my custom dotfiles and preferred tools.**

## 🔧 Features

- Automatically sets up your development environment with:
  - Custom `.bashrc`
  - Personalized `tmux` configuration
  - Themed `starship` prompt
  - LazyVim configuration
- Installs essential development tools using **Homebrew**
  - If Homebrew is unavailable or causes conflicts, falls back to **nix-manager**
- Sets up your project environment with all necessary dependencies

## 📦 Packages Installed

The setup includes installation of the following tools:

- `tmux` – Terminal multiplexer  
- `starship` – Minimal, blazing-fast shell prompt  
- `nvim` – Neovim editor (configured with LazyVim)  
- `zoxide` – Smarter `cd` command  
- `eza` – Modern replacement for `ls`  
- `yazi` – Blazing fast terminal file manager  

## 🚀 Usage

1. Clone this repo into your DevPod project.
2. Run the setup script to initialize dotfiles and install dependencies.
3. Start working in a pre-configured, consistent environment.

## 💡 Notes

- Designed for cross-distro compatibility.
- Automatically adapts to environments where Homebrew cannot be used.
