#!/bin/bash

# =============================================================================
# Setup Neovim on Remote Machine
# Syncs config and optionally installs Neovim
# Usage: ./setup-remote.sh user@hostname [--no-install]
# =============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() { echo -e "${GREEN}[✓]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }
print_info() { echo -e "${BLUE}[i]${NC} $1"; }

# =============================================================================
# Configuration
# =============================================================================

LOCAL_CONFIG_DIR="$HOME/.config/nvim"
INSTALL_NVIM=true

# Parse arguments
if [ -z "$1" ]; then
    print_error "Usage: $0 <user@host> [--no-install] [remote_config_dir]"
    echo ""
    echo "  --no-install    Skip Neovim installation (only sync config)"
    echo ""
    echo "Examples:"
    echo "  $0 user@example.com"
    echo "  $0 user@example.com --no-install"
    echo "  $0 user@example.com ~/.config/nvim"
    exit 1
fi

# Parse flags
if [[ "$*" == *"--no-install"* ]]; then
    INSTALL_NVIM=false
fi

# Extract remote info
if [[ "$1" == *"@"* ]]; then
    REMOTE="$1"
    REMOTE_USER=$(echo "$1" | cut -d'@' -f1)
    REMOTE_HOST=$(echo "$1" | cut -d'@' -f2)
else
    usage
fi

# Get remote config dir (last non-flag argument)
for arg in "$@"; do
    if [[ "$arg" != "--no-install" && "$arg" != "$1" ]]; then
        REMOTE_CONFIG_DIR="$arg"
        break
    fi
done
REMOTE_CONFIG_DIR="${REMOTE_CONFIG_DIR:-~/.config/nvim}"

# =============================================================================
# Validation
# =============================================================================

if [ ! -d "$LOCAL_CONFIG_DIR" ]; then
    print_error "Local config directory not found: $LOCAL_CONFIG_DIR"
    exit 1
fi

# =============================================================================
# Check SSH connection
# =============================================================================

print_info "Testing SSH connection..."
if ! ssh -o ConnectTimeout=5 "$REMOTE" "echo 'Connected'" &>/dev/null; then
    print_error "Cannot connect to $REMOTE"
    print_info "Make sure SSH is set up and you can connect"
    exit 1
fi
print_status "SSH connection OK"

# =============================================================================
# Sync Config Function
# =============================================================================

sync_config() {
    echo ""
    echo "=============================================="
    echo "  Step 1: Syncing Neovim Config"
    echo "=============================================="
    echo ""
    
    print_info "Syncing config to ${REMOTE_USER}@${REMOTE_HOST}..."
    print_info "Local:  $LOCAL_CONFIG_DIR"
    print_info "Remote: $REMOTE_CONFIG_DIR"
    echo ""

    # Create remote directory if it doesn't exist
    ssh "$REMOTE" "mkdir -p $REMOTE_CONFIG_DIR" 2>/dev/null || true

    # Sync using rsync (exclude lazy-lock.json and other generated files)
    rsync -avz --progress \
        --exclude='lazy-lock.json' \
        --exclude='*.log' \
        --exclude='.git' \
        --exclude='plugin' \
        --exclude='pack' \
        "$LOCAL_CONFIG_DIR/" \
        "${REMOTE}:${REMOTE_CONFIG_DIR}/"

    if [ $? -eq 0 ]; then
        print_status "Config synced successfully!"
    else
        print_error "Sync failed!"
        exit 1
    fi
}

# =============================================================================
# Install Neovim Function
# =============================================================================

install_neovim() {
    echo ""
    echo "=============================================="
    echo "  Step 2: Installing Neovim"
    echo "=============================================="
    echo ""
    
    # Check and install dependencies BEFORE running main install
    print_info "Checking dependencies on remote..."
    echo ""
    
    # Check for Node.js (required for Mason LSP servers)
    print_info "Checking for Node.js..."
    if ! ssh "$REMOTE" "command -v node &> /dev/null"; then
        print_warning "Node.js not found on remote machine"
        print_info "Most LSP servers require Node.js"
        print_info "Attempting to install Node.js..."
        echo ""
        
        if ssh "$REMOTE" "command -v dnf &> /dev/null"; then
            print_info "Installing Node.js 20 via dnf..."
            if ssh -t "$REMOTE" "sudo dnf module reset nodejs -y && sudo dnf module enable nodejs:20 -y && sudo dnf install nodejs -y"; then
                print_status "Node.js installed successfully!"
            else
                print_warning "Failed to install Node.js"
                print_info "LSP servers may not work without it"
            fi
        elif ssh "$REMOTE" "command -v apt-get &> /dev/null"; then
            print_info "Installing Node.js via apt..."
            if ssh -t "$REMOTE" "curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - && sudo apt-get install -y nodejs"; then
                print_status "Node.js installed successfully!"
            else
                print_warning "Failed to install Node.js"
                print_info "LSP servers may not work without it"
            fi
        fi
    else
        NODE_VERSION=$(ssh "$REMOTE" "node --version 2>/dev/null || echo 'unknown'")
        print_status "Node.js found: $NODE_VERSION"
    fi
    
    echo ""
    print_info "Checking for C compiler..."
    if ! ssh "$REMOTE" "command -v gcc &> /dev/null || command -v clang &> /dev/null || command -v cc &> /dev/null"; then
        print_warning "C compiler not found on remote machine"
        print_info "Attempting to install gcc..."
        echo ""
        
        # Detect package manager
        if ssh "$REMOTE" "command -v dnf &> /dev/null"; then
            print_info "Installing gcc, gcc-c++, and make via dnf..."
            print_info "You may be prompted for sudo password..."
            echo ""
            if ssh -t "$REMOTE" "sudo dnf install -y gcc gcc-c++ make"; then
                print_status "C compiler installed successfully!"
            else
                print_error "Failed to install gcc"
                print_info "Please install manually: ssh $REMOTE 'sudo dnf install gcc gcc-c++ make'"
                read -p "Continue anyway? Treesitter parsers will fail. [y/N] " -n 1 -r
                echo ""
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    print_info "Installation cancelled."
                    exit 1
                fi
            fi
        elif ssh "$REMOTE" "command -v apt-get &> /dev/null"; then
            print_info "Installing build-essential via apt..."
            print_info "You may be prompted for sudo password..."
            echo ""
            if ssh -t "$REMOTE" "sudo apt-get update -qq && sudo apt-get install -y build-essential"; then
                print_status "C compiler installed successfully!"
            else
                print_error "Failed to install build-essential"
                print_info "Please install manually: ssh $REMOTE 'sudo apt install build-essential'"
                read -p "Continue anyway? Treesitter parsers will fail. [y/N] " -n 1 -r
                echo ""
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    print_info "Installation cancelled."
                    exit 1
                fi
            fi
        else
            print_warning "Unknown package manager - cannot auto-install gcc"
            print_info "Please install gcc manually before continuing"
            read -p "Continue anyway? Treesitter parsers will fail. [y/N] " -n 1 -r
            echo ""
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                print_info "Installation cancelled."
                exit 1
            fi
        fi
    else
        print_status "C compiler found on remote machine"
    fi
    
    echo ""
    print_info "Installing Neovim..."
    echo ""

    ssh -t "$REMOTE" << 'ENDSSH'
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'
print_status() { echo -e "${GREEN}[✓]${NC} $1"; }
print_info() { echo -e "${BLUE}[i]${NC} $1"; }
print_error() { echo -e "${RED}[✗]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[!]${NC} $1"; }

# Check if already installed
if command -v nvim &> /dev/null; then
    NVIM_VERSION=$(nvim --version | head -1)
    print_info "Neovim already installed: $NVIM_VERSION"
    read -p "Reinstall? [y/N] " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Skipping installation."
        exit 0
    fi
fi

# Check dependencies
command -v curl &> /dev/null || { print_error "curl not found"; exit 1; }
command -v tar &> /dev/null || { print_error "tar not found"; exit 1; }

# Create directories
mkdir -p ~/.local/bin ~/.local/nvim
LOCAL_BIN="$HOME/.local/bin"
LOCAL_NVIM="$HOME/.local/nvim"

# Download and install
print_info "Downloading Neovim..."
TEMP_DIR=$(mktemp -d)
cd "$TEMP_DIR"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

print_info "Extracting..."
tar xzf nvim-linux-x86_64.tar.gz

print_info "Installing to ~/.local/nvim..."
rm -rf "$LOCAL_NVIM"
mv nvim-linux-x86_64 "$LOCAL_NVIM"
ln -sf "$LOCAL_NVIM/bin/nvim" "$LOCAL_BIN/nvim"

# Add to PATH
if ! grep -q '\.local/bin' ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    print_info "Added ~/.local/bin to PATH"
fi

# Cleanup
cd ~
rm -rf "$TEMP_DIR"

print_status "Neovim installed!"
ENDSSH

    # Verify installation
    echo ""
    print_info "Verifying installation..."
    
    if ssh "$REMOTE" "source ~/.bashrc 2>/dev/null; command -v nvim" &>/dev/null; then
        NVIM_VERSION=$(ssh "$REMOTE" "source ~/.bashrc 2>/dev/null; nvim --version | head -1")
        print_status "Neovim installed successfully!"
        echo ""
        echo "  Version: $NVIM_VERSION"
    else
        print_warning "Installation completed, but nvim not in PATH yet"
        print_info "On remote machine, run: source ~/.bashrc"
    fi
}

# =============================================================================
# Main
# =============================================================================

echo ""
echo "=============================================="
echo "  Setup Neovim on Remote Machine"
echo "=============================================="
echo ""
print_info "Remote: ${REMOTE_USER}@${REMOTE_HOST}"
print_info "Config: $REMOTE_CONFIG_DIR"
print_info "Install Neovim: $INSTALL_NVIM"
echo ""
echo "Prerequisites will be installed automatically:"
echo "  1. Node.js (for LSP servers)"
echo "  2. GCC (for Treesitter parsers)"
echo "  3. Neovim (latest stable)"
echo ""
print_warning "Manual installation commands (if auto-install fails):"
echo ""
echo "  Rocky Linux 9:"
echo "    sudo dnf module enable nodejs:20 -y"
echo "    sudo dnf install nodejs gcc gcc-c++ make -y"
echo ""
print_info "Uninstall"
echo ""
echo "ssh admin@manual-head-0 "rm -rf ~/.local/nvim ~/.local/bin/nvim ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim ~/.local/state/nvim""
echo ""

# Step 1: Sync config
sync_config

# Step 2: Install Neovim (if requested)
if [ "$INSTALL_NVIM" = true ]; then
    install_neovim
fi

# Final summary
echo ""
echo "=============================================="
echo "  Setup Complete!"
echo "=============================================="
echo ""
print_status "Neovim config synced to remote machine"
if [ "$INSTALL_NVIM" = true ]; then
    print_status "Neovim installed on remote machine"
fi
echo ""
print_info "Next steps on remote machine (ssh ${REMOTE_USER}@${REMOTE_HOST}):"
echo ""
echo "  1. Activate Neovim:"
echo "     source ~/.bashrc"
echo "     nvim --version"
echo ""
echo "  2. Install plugins:"
echo "     nvim -c 'Lazy sync'"
echo ""
print_warning "Manual installation commands (if auto-install fails):"
echo ""
echo "  Rocky Linux 9:"
echo "    sudo dnf module enable nodejs:20 -y"
echo "    sudo dnf install nodejs gcc gcc-c++ make -y"
echo ""
