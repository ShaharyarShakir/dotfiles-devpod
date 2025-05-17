#!/bin/bash
set -euo pipefail

echo "🔧 Checking for Homebrew..."

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 2>/dev/null || true

if ! command -v brew &> /dev/null; then
  echo "🧪 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  echo "🔄 Sourcing Homebrew for this session..."
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
else
  echo "✅ Homebrew is already installed."
fi

echo "🍺 Homebrew is ready to use!"
