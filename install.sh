#!/bin/bash

set -e

echo "🚀 Starting dotfiles setup..."

# Install zsh using system package manager
echo "📥 Installing zsh..."
if command -v apt-get &> /dev/null; then
    sudo apt-get update
    sudo apt-get install -y zsh
elif command -v yum &> /dev/null; then
    sudo yum install -y zsh
else
    echo "⚠️  Unsupported package manager. Please install zsh manually."
    exit 1
fi

# Install ohmyzsh
echo "📥 Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "✅ Oh My Zsh is already installed"
fi

# Change default shell to zsh
echo "🔧 Changing default shell to zsh..."
ZSH_PATH=$(which zsh)
if [[ ":$SHELL" != *"zsh"* ]]; then
    chsh -s "$ZSH_PATH"
    echo "✅ Default shell changed to zsh"
else
    echo "✅ zsh is already the default shell"
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSHRC_SOURCE="$SCRIPT_DIR/.zshrc"

# Create symlink for .zshrc
echo "🔗 Creating symlink for .zshrc..."
if [ ! -f "$ZSHRC_SOURCE" ]; then
    echo "⚠️  Error: .zshrc not found at $ZSHRC_SOURCE"
    exit 1
fi

if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    echo "📦 Backing up existing .zshrc to .zshrc.backup"
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
fi

ln -sf "$ZSHRC_SOURCE" "$HOME/.zshrc"
echo "✅ Symlink created: ~/.zshrc -> $ZSHRC_SOURCE"

# Source the new .zshrc to setup Homebrew
echo "🔧 Sourcing .zshrc..."
source "$HOME/.zshrc" || true

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    source "$HOME/.zshrc"
else
    echo "✅ Homebrew is already installed"
fi

# Update Homebrew
echo "🔄 Updating Homebrew..."
brew update

# Install lazygit
echo "📥 Installing lazygit..."
brew install lazygit

# Install neovim
echo "📥 Installing neovim..."
brew install neovim

echo ""
echo "✅ Installation complete!"
echo ""
echo "📋 Installed tools:"
echo "  - zsh: $(zsh --version)"
echo "  - Oh My Zsh: ~/.oh-my-zsh"
echo "  - lazygit: $(lazygit --version)"
echo "  - neovim: $(nvim --version | head -n 1)"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo ""
echo "🎉 Setup finished successfully!"
