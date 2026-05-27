#!/bin/bash

# =============================================================================
# Neovim Installation Script for Ubuntu/Linux
# Installs latest stable Neovim from GitHub releases
# =============================================================================

set -e

# Default: prompt for confirmations
AUTO_YES=false

# Parse flags
for arg in "$@"; do
    case "$arg" in
        -y|--yes)
            AUTO_YES=true
            ;;
    esac
done

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

ask_yes_no() {
    local prompt="$1"
    local default_yes="$2"
    if [ "$AUTO_YES" = true ]; then
        return 0
    fi
    local default_hint="[Y/n]"
    if [ "$default_yes" = false ]; then
        default_hint="[y/N]"
    fi
    read -p "$prompt $default_hint " -n 1 -r
    echo ""
    if [ "$default_yes" = false ]; then
        [[ $REPLY =~ ^[Yy]$ ]]
        return $?
    fi
    [[ ! $REPLY =~ ^[Nn]$ ]]
    return $?
}

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
    if ! ask_yes_no "Do you want to reinstall/upgrade?" false; then
        print_info "Installation cancelled."
        exit 0
    fi
fi

# =============================================================================
# STEP 2: Install dependencies
# =============================================================================

print_info "Installing dependencies..."

sudo apt update
sudo apt install -y curl tar gzip ripgrep fd-find git python3-venv python3-pip build-essential \
  luarocks lua5.1 liblua5.1-0-dev

print_status "Dependencies installed!"

# =============================================================================
# STEP 2b: Install tree-sitter CLI
# Required by nvim-treesitter's main branch (Neovim 0.12+) to compile parsers.
# We download a prebuilt binary from GitHub releases (per the upstream docs,
# `npm` installs are NOT supported).
# =============================================================================

echo ""
if command -v tree-sitter &> /dev/null; then
    TS_VERSION=$(tree-sitter --version 2>/dev/null | head -1)
    print_status "tree-sitter CLI already installed: $TS_VERSION"
else
    if ask_yes_no "Install tree-sitter CLI? (required by nvim-treesitter)" true; then
        print_info "Installing tree-sitter CLI from GitHub releases..."
        TS_TMP=$(mktemp -d)
        pushd "$TS_TMP" >/dev/null

        # Detect architecture
        ARCH=$(uname -m)
        case "$ARCH" in
            x86_64)  TS_ARCH="x64" ;;
            aarch64|arm64) TS_ARCH="arm64" ;;
            *) print_error "Unsupported arch: $ARCH"; popd >/dev/null; rm -rf "$TS_TMP"; exit 1 ;;
        esac

        TS_LATEST=$(curl -s "https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest" \
            | grep -Po '"tag_name": "v\K[^"]*')
        TS_URL="https://github.com/tree-sitter/tree-sitter/releases/download/v${TS_LATEST}/tree-sitter-linux-${TS_ARCH}.gz"

        curl -fLo tree-sitter.gz "$TS_URL"
        gunzip tree-sitter.gz
        chmod +x tree-sitter
        sudo install tree-sitter /usr/local/bin/tree-sitter

        popd >/dev/null
        rm -rf "$TS_TMP"
        print_status "tree-sitter CLI installed: $(tree-sitter --version | head -1)"
    else
        print_warning "Skipping tree-sitter CLI. Treesitter parsers will fail to build."
    fi
fi

# =============================================================================
# STEP 3: Install Node.js (required for most LSP servers)
# =============================================================================

echo ""
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    print_status "Node.js already installed: $NODE_VERSION"
else
    if ask_yes_no "Install Node.js LTS? (required for LSP servers)" true; then
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
if ask_yes_no "Install lazygit (for git integration)?" true; then
    print_info "Installing lazygit..."
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -f lazygit lazygit.tar.gz
    print_status "lazygit installed!"
fi

echo ""
if ask_yes_no "Install Python formatter (ruff)?" true; then
    print_info "Installing ruff..."
    pip3 install --user ruff --break-system-packages
    print_status "ruff installed!"
fi

echo ""
if ask_yes_no "Install Python REPL extras (ipython, jupyter, jupytext, ipykernel)?" true; then
    print_info "Installing ipython, jupyter, jupytext, ipykernel, pynvim, nbformat..."
    pip3 install --user ipython jupyter jupytext ipykernel pynvim nbformat --break-system-packages
    print_status "Python REPL extras installed!"
fi

# =============================================================================
# STEP 6c: Install debugpy (Python debugger backend for nvim-dap-python)
#
# At runtime, the Neovim config tries to install debugpy directly into the
# active project venv (via `uv pip install` or `python -m pip install`).
# Here we make sure a system-level fallback exists so debugging also works
# in plain Python files that have no venv:
#   - prefer Debian/Ubuntu package `python3-debugpy` (no PEP 668 issues)
#   - otherwise install with pip --user --break-system-packages
# =============================================================================

echo ""
if ask_yes_no "Install debugpy (Python debug adapter) at system level as a fallback?" true; then
    if apt-cache show python3-debugpy >/dev/null 2>&1; then
        print_info "Installing python3-debugpy via apt..."
        sudo apt install -y python3-debugpy
    else
        print_info "Installing debugpy via pip (--user, --break-system-packages)..."
        pip3 install --user debugpy --break-system-packages
    fi
    print_status "debugpy installed system-wide!"
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

if ask_yes_no "Setup Neovim config? (will remove old config/plugins)" true; then
    copy_config
fi

# =============================================================================
# STEP 8: Install plugins and parsers
# =============================================================================

echo ""
if ask_yes_no "Install Neovim plugins now? (recommended)" true; then
    print_info "Installing plugins (this may take a minute)..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
    print_status "Plugins installed!"

    # Treesitter (main branch) does not auto-install parsers from a config
    # table. Install them synchronously now so the first file open is clean.
    if command -v tree-sitter &> /dev/null; then
        print_info "Compiling treesitter parsers (this may take a few minutes)..."
        nvim --headless -c "lua \
            local ts = require('nvim-treesitter'); \
            ts.setup({ install_dir = vim.fn.stdpath('data') .. '/site' }); \
            ts.install({ \
              'lua','vim','vimdoc','query','regex','bash', \
              'html','css','javascript','typescript','tsx','json','yaml','toml', \
              'markdown','markdown_inline', \
              'python','go','rust','c','cpp', \
              'dockerfile','diff','gitcommit','gitignore' \
            }):wait(600000)" \
            +qa 2>/dev/null || true
        print_status "Treesitter parsers installed!"
    else
        print_warning "tree-sitter CLI not found; parsers will be installed on first nvim launch."
    fi
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
