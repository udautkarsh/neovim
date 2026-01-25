#!/bin/bash

# =============================================================================
# Neovim Installation Script for Ubuntu/Linux
# Installs latest stable Neovim from GitHub releases
# =============================================================================

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }
print_info() { echo -e "${BLUE}[i]${NC} $1"; }

echo ""
echo "=============================================="
echo "  Neovim Installation Script"
echo "=============================================="
echo ""

# =============================================================================
# STEP 1: Check for existing installation
# =============================================================================

if command -v nvim &> /dev/null; then
    CURRENT_VERSION=$(nvim --version | head -1)
    print_warning "Neovim already installed: $CURRENT_VERSION"
    read -p "Do you want to reinstall/upgrade? [y/N] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Installation cancelled."
        exit 0
    fi
fi

# =============================================================================
# STEP 2: Install dependencies
# =============================================================================

print_info "Installing dependencies..."

sudo apt update
sudo apt install -y curl tar gzip ripgrep fd-find git python3-venv python3-pip build-essential

print_status "Dependencies installed!"

# =============================================================================
# STEP 3: Install Node.js (required for most LSP servers)
# =============================================================================

echo ""
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    print_status "Node.js already installed: $NODE_VERSION"
else
    read -p "Install Node.js LTS? (required for LSP servers) [Y/n] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        print_info "Installing Node.js LTS..."
        curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
        sudo apt-get install -y nodejs
        print_status "Node.js installed: $(node --version)"
    else
        print_warning "Skipping Node.js. Some LSP servers won't work."
    fi
fi

# =============================================================================
# STEP 4: Download Neovim
# =============================================================================

echo ""
print_info "Downloading latest Neovim release..."

# Create temp directory
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"

# Download latest release
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

# Get version info
VERSION=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
print_status "Downloaded version: $VERSION"

# =============================================================================
# STEP 5: Install Neovim
# =============================================================================

print_info "Extracting..."
tar xzf nvim-linux-x86_64.tar.gz

print_info "Installing to /opt/nvim..."
sudo rm -rf /opt/nvim
sudo mv nvim-linux-x86_64 /opt/nvim

# Create symlink in /usr/local/bin
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

# Cleanup
cd ~
rm -rf "$TEMP_DIR"

print_status "Neovim installed!"

# =============================================================================
# STEP 6: Install optional tools (lazygit, ruff)
# =============================================================================

echo ""
read -p "Install lazygit (for git integration)? [Y/n] " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    print_info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -f lazygit lazygit.tar.gz
    print_status "lazygit installed!"
fi

echo ""
read -p "Install Python formatter (ruff)? [Y/n] " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    print_info "Installing ruff..."
    pip3 install --user ruff
    print_status "ruff installed!"
fi

# =============================================================================
# STEP 7: Setup config directory (copy)
# =============================================================================

echo ""

# Hardcoded config path (most reliable)
CONFIG_DIR="$HOME/myworks/mylearnings/neovim/neovim_new"

# Verify config exists
if [ ! -f "$CONFIG_DIR/init.lua" ]; then
    print_error "Could not find config at: $CONFIG_DIR"
    exit 1
fi

print_status "Config source: $CONFIG_DIR"

copy_config() {
    # Clean slate - remove old config and data
    rm -rf ~/.config/nvim
    rm -rf ~/.local/share/nvim
    rm -rf ~/.local/state/nvim
    rm -rf ~/.cache/nvim
    
    # Copy fresh config
    mkdir -p ~/.config/nvim
    cp "$CONFIG_DIR"/init.lua ~/.config/nvim/
    cp -r "$CONFIG_DIR"/lua ~/.config/nvim/
    
    print_status "Config copied to ~/.config/nvim"
}

read -p "Setup Neovim config? (will remove old config/plugins) [Y/n] " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    copy_config
fi

# =============================================================================
# STEP 8: Install plugins and parsers
# =============================================================================

echo ""
read -p "Install Neovim plugins now? (recommended) [Y/n] " -n 1 -r
echo ""

if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    print_info "Installing plugins (this may take a minute)..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    print_status "Plugins installed!"
    print_status "Treesitter parsers will auto-install on first file open."
fi

# =============================================================================
# STEP 9: Verify installation
# =============================================================================

echo ""
print_info "Verifying installation..."

if command -v nvim &> /dev/null; then
    echo ""
    print_status "Installation complete!"
    echo ""
    nvim --version | head -3
    echo ""
    echo "=============================================="
    echo "  Neovim is ready!"
    echo "=============================================="
    echo ""
    echo "  Binary:   /opt/nvim/bin/nvim"
    echo "  Symlink:  /usr/local/bin/nvim"
    echo "  Config:   ~/.config/nvim"
    echo ""
    echo "  Run 'nvim' to start!"
    echo ""
    echo "=============================================="
else
    print_error "Installation failed. Please check the logs above."
    exit 1
fi
