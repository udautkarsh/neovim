#!/bin/bash

# =============================================================================
# Neovim Uninstall Script
# Removes Neovim installed by install-neovim.sh
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

echo ""
echo "=============================================="
echo "  Neovim Uninstall Script"
echo "=============================================="
echo ""

# =============================================================================
# Remove Neovim binary
# =============================================================================

print_info "Removing Neovim binary..."

sudo rm -rf /opt/nvim
sudo rm -f /usr/local/bin/nvim

print_status "Neovim binary removed"

# =============================================================================
# Remove lazygit (if installed)
# =============================================================================

if [ -f /usr/local/bin/lazygit ]; then
    print_info "Removing lazygit..."
    sudo rm -f /usr/local/bin/lazygit
    print_status "lazygit removed"
fi

# =============================================================================
# Remove config
# =============================================================================

echo ""
print_info "Removing Neovim config..."

rm -rf ~/.config/nvim

print_status "Config removed (~/.config/nvim)"

# =============================================================================
# Remove user data (plugins, state, cache)
# =============================================================================

print_info "Removing Neovim data..."

rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim

print_status "User data removed"

# =============================================================================
# Done
# =============================================================================

echo ""
echo "=============================================="
print_status "Neovim completely uninstalled!"
echo "=============================================="
echo ""
echo "To reinstall, run:"
echo "  ./scripts/install-neovim.sh"
echo ""