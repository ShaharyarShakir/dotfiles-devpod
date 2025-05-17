#!/bin/bash
set -e

# Check if tmux is installed with Homebrew
if ! brew list --formula | grep -q "^tmux\$"; then
  echo "tmux is not installed. Installing with Homebrew..."
  brew install tmux
else
  echo "tmux is already installed."
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Check if TPM is already installed
if [ -d "$TPM_DIR" ]; then
  echo "✔ TPM is already installed in $TPM_DIR"
else
  echo "➤ Installing Tmux Plugin Manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo "✅ TPM setup complete!"

echo "➤ Starting tmux session to install plugins..."

tmux new-session -d -s tpm_install_session

# Assuming prefix is C-b (default). Sends prefix + I
tmux send-keys -t tpm_install_session C-b "I" C-m

# Attach to the tmux session so user can see plugin installation
tmux attach -t tpm_install_session

exit 0
