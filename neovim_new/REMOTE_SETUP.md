# Setting Up Neovim on Remote Machines

## 🚀 **Quick Setup**

### **One-Command Setup (Recommended)**
```bash
# From local machine - syncs config AND installs Neovim
cd /path/to/neovim_new/scripts
./setup-remote.sh user@hostname

# Or sync config only (skip Neovim installation)
./setup-remote.sh user@hostname --no-install
```

### **Manual Installation (Alternative)**
```bash
# SSH into remote and install manually
ssh user@hostname
mkdir -p ~/.local/bin ~/.local/nvim
cd /tmp
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz
mv nvim-linux-x86_64 ~/.local/nvim
ln -sf ~/.local/nvim/bin/nvim ~/.local/bin/nvim
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
nvim --version
```

### **3. Install Plugins**
```bash
# On remote machine
nvim -c "Lazy sync"
```

---

## 📋 **Alternative Methods**

### **Using Git (Recommended for multiple machines)**
```bash
# On remote machine
git clone <your-repo-url> ~/dotfiles
cp -r ~/dotfiles/neovim_new/* ~/.config/nvim/
nvim -c "Lazy sync"
```

### **Manual rsync (Alternative)**
```bash
rsync -avz --progress \
    --exclude='lazy-lock.json' \
    --exclude='*.log' \
    --exclude='plugin' \
    ~/.config/nvim/ \
    user@hostname:~/.config/nvim/
```

---

## 🔧 **Troubleshooting**

### **Mason LSP Installation Failed**
If you see: `[mason-lspconfig.nvim] failed to install cssls`

**Cause:** Node.js is missing (most LSP servers require it)

**On Rocky Linux:**
```bash
sudo dnf module enable nodejs:20 -y
sudo dnf install nodejs -y
```

**On Ubuntu/Debian:**
```bash
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs -y
```

**Then retry in Neovim:**
```vim
:MasonInstall cssls pyright ruff
```

### **C Compiler Missing (Treesitter Error)**
If you see: `No C compiler found! "cc", "gcc", "clang"...`

**On Rocky Linux:**
```bash
sudo dnf install gcc gcc-c++ make
```

**On Ubuntu/Debian:**
```bash
sudo apt install build-essential
```

**Why?** Treesitter parsers need to be compiled. After installing gcc, restart Neovim.

### **Neovim not found after install:**
```bash
source ~/.bashrc
which nvim
```

### **Plugins not installing:**
```bash
rm -rf ~/.local/share/nvim/lazy
nvim -c "Lazy sync"
```

### **LSP servers not working:**
```bash
nvim -c "Mason"
# Install: :MasonInstall pyright ruff-lsp
```

### **Treesitter parsers missing:**
```bash
nvim -c "TSInstall python"
```

---

## 📝 **Notes**

- **lazy-lock.json** is machine-specific, don't sync it
- **plugin/** directory is generated, exclude it
- **Mason tools** and **Treesitter parsers** need to be installed on each machine
- Use `setup-remote.sh` for automated setup (syncs config and installs Neovim)
