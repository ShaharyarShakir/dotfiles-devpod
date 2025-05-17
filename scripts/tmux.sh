#!/bin/bash
set -euo pipefail

echo "###########################################"
echo "Installing tmux and TPM (Tmux Plugin Manager)"
echo "###########################################"
echo

# Check if tmux is installed with Homebrew
if ! brew list --formula | grep -q "^tmux\$"; then
  echo "➤ tmux is not installed. Installing with Homebrew..."
  brew install tmux
else
  echo "✔ tmux is already installed."
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Check if TPM is already installed
if [ -d "$TPM_DIR" ]; then
  echo "✔ TPM is already installed at $TPM_DIR"
else
  echo "➤ Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi

echo "✅ TPM setup complete."
echo "🚀 Starting temporary tmux session to install plugins..."

SESSION="tpm_install_session"

# Create a detached session
tmux new-session -d -s "$SESSION"

# Sleep a bit to let tmux init before sending keys
sleep 1

# Send prefix + I to install plugins
tmux send-keys -t "$SESSION" C-b "I" C-m

# Wait and kill session automatically after install
sleep 2

# Attach only if script is run interactively
if [ -t 1 ]; then
  echo "📺 Attaching to tmux session to show installation progress..."
  tmux attach-session -t "$SESSION"
  sleep 2
fi

tmux kill-session -t "$SESSION" &>/dev/null || true

echo "✅ Tmux plugins installed successfully!"
