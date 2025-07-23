#!/bin/bash

set -e

echo "✅ Installing dependencies..."
sudo apt update && sudo apt install -y git curl unzip

echo "📁 Creating temporary directory..."
cd "$(mktemp -d)"

OS="$(uname | tr '[:upper:]' '[:lower:]')"
ARCH="$(uname -m)"

echo "🔍 Detecting architecture..."
case "$ARCH" in
  x86_64) ARCH="amd64" ;;
  aarch64 | arm64) ARCH="arm64" ;;
  *) echo "❌ Unsupported architecture: $ARCH"; exit 1 ;;
esac

KREW="krew-${OS}_${ARCH}"
KREW_TAR="${KREW}.tar.gz"
DOWNLOAD_URL="https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW_TAR}"

echo "⬇️ Downloading Krew from $DOWNLOAD_URL..."
curl -fsSLO "$DOWNLOAD_URL"

echo "📦 Extracting..."
tar zxvf "$KREW_TAR"

echo "🚀 Installing Krew..."
./"$KREW" install krew

echo "🛠️ Updating PATH in .zshrc..."
SHELL_RC="${HOME}/.zshrc"
echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> "$SHELL_RC"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

echo "✅ Krew installed successfully!"
echo "👉 Please run: source $SHELL_RC"
echo "👉 Then verify with: kubectl krew version"

