#!/bin/bash
set -e
if ! command -v brew &> /dev/null
then 
echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "Homebrew is already installed"
fi 

# Add brew to PATH only if it's not already there
grep -qxF 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' ~/.bashrc || \
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
