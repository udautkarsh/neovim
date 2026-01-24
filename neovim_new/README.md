# Neovim Configuration

A modern, modular Neovim configuration built with [lazy.nvim](https://github.com/folke/lazy.nvim) and [snacks.nvim](https://github.com/folke/snacks.nvim).

## 📁 Directory Structure

```
neovim/
├── init.lua                         # Entry point
├── README.md                        # This file
├── user-manual.md                   # Keybindings & usage guide
├── scripts/                         # Installation scripts
│   ├── install-neovim.sh            # Install Neovim
│   └── uninstall-neovim.sh          # Uninstall Neovim
└── lua/
    ├── config/                      # Core configuration
    │   ├── options.lua              # Editor settings
    │   ├── keymaps.lua              # Global keybindings
    │   ├── autocmds.lua             # Autocommands
    │   └── lazy.lua                 # Plugin manager setup
    ├── plugins/                     # Plugin specifications
    │   ├── snacks.lua               # Snacks.nvim (UI/UX suite)
    │   └── lsp/                     # LSP configuration
    │       ├── init.lua             # LSP setup (plugin spec)
    │       ├── _servers.lua         # Language servers (config)
    │       └── _keymaps.lua         # LSP keybindings (config)
    └── utils/                       # Helper functions
        └── init.lua                 # Utility library
```

---

## 📂 Folder Explanations

### `init.lua`

The entry point of the configuration. Keeps things minimal and clean:

```lua
require("config.options")   -- Load editor options first
require("config.keymaps")   -- Load global keymaps
require("config.autocmds")  -- Load autocommands
require("config.lazy")      -- Bootstrap and load plugins
```

---

### `lua/config/` — Core Configuration

Contains all non-plugin configuration files.

#### `options.lua`
Editor settings and behavior configuration.

| Category | Settings |
|----------|----------|
| **Line Numbers** | Relative line numbers enabled |
| **Indentation** | 2 spaces, smart indent, auto indent |
| **Search** | Case-insensitive, smart case, incremental |
| **Appearance** | True colors, dark background, cursorline |
| **Clipboard** | System clipboard integration |
| **Splits** | Open right and below |
| **Undo** | Persistent undo history |
| **Performance** | Fast update time (200ms), reduced timeout |

#### `keymaps.lua`
Global keybindings (non-plugin specific).

| Category | Key Examples |
|----------|--------------|
| **General** | `<leader>w` save, `<leader>q` quit, `jk`/`jj` escape |
| **Navigation** | `<C-d>`/`<C-u>` centered scroll, `n`/`N` centered search |
| **Window Nav** | `Ctrl+Arrows` navigate, `<C-hjkl>` vim-style |
| **Window Resize** | `Ctrl+Shift+Arrows` resize splits |
| **Buffers** | `<S-h>`/`<S-l>` prev/next buffer |
| **Move Lines** | `<A-j>`/`<A-k>` move lines up/down |
| **Quickfix** | `[q`/`]q` navigate quickfix list |
| **Diagnostics** | `[d`/`]d` navigate diagnostics |

#### `autocmds.lua`
Automatic commands that trigger on events.

| Autocommand | Description |
|-------------|-------------|
| **Highlight Yank** | Flash yanked text for 200ms |
| **Restore Cursor** | Return to last edit position on file open |
| **Close with q** | Close help, quickfix, etc. with `q` |
| **Text Files** | Enable wrap and spell for markdown, text |
| **JSON Conceal** | Disable conceal for JSON files |
| **Auto Mkdir** | Create parent directories on save |
| **Terminal** | Start in insert mode, hide line numbers |
| **Cursorline** | Only show in active window |
| **Auto Reload** | Check for external file changes on focus |

#### `lazy.lua`
Plugin manager bootstrap and configuration.

| Feature | Description |
|---------|-------------|
| **Auto-install** | Clones lazy.nvim if not present |
| **Plugin Import** | Loads `plugins/` and `plugins/lsp/` |
| **Checker** | Auto-checks for plugin updates (silent) |
| **Performance** | Disables unused built-in plugins |

---

### `lua/plugins/` — Plugin Specifications

Each file returns a lazy.nvim plugin specification table.

#### `snacks.lua`
[Snacks.nvim](https://github.com/folke/snacks.nvim) — A collection of QoL plugins.

| Module | Replaces | Description |
|--------|----------|-------------|
| `animate` | — | Smooth animations |
| `bigfile` | bigfile.nvim | Disable features for large files |
| `bufdelete` | bufdelete.nvim | Delete buffers without layout issues |
| `dashboard` | alpha.nvim | Start screen |
| `debug` | — | Debug utilities (`dd()`, `bt()`) |
| `dim` | — | Dim inactive code/windows |
| `explorer` | nvim-tree | File explorer |
| `git` | — | Git utilities |
| `gitbrowse` | — | Open file in GitHub/GitLab |
| `image` | — | Image support in terminal |
| `indent` | indent-blankline | Indent guides |
| `input` | dressing.nvim | Better `vim.ui.input` |
| `lazygit` | lazygit.nvim | Lazygit integration |
| `notifier` | nvim-notify | Notifications |
| `picker` | telescope.nvim | Fuzzy finder |
| `profiler` | — | Performance profiling |
| `quickfile` | — | Quick file loading |
| `rename` | — | LSP rename with preview |
| `scope` | — | Scope detection |
| `scratch` | — | Scratch buffers |
| `scroll` | — | Smooth scrolling |
| `statuscolumn` | — | Custom statuscolumn |
| `terminal` | toggleterm | Terminal integration |
| `toggle` | — | Toggle options |
| `win` | — | Window utilities |
| `words` | illuminate | Jump between references |
| `zen` | zen-mode | Zen mode / maximize |

**Key Mappings (Snacks):**

| Key | Action |
|-----|--------|
| `<leader>e` | File Explorer |
| `<leader>ff` | Find Files |
| `<leader>fg` | Grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent Files |
| `<leader>gg` | Lazygit |
| `<leader>gb` | Git Blame Line |
| `<leader>bd` | Delete Buffer |
| `<leader>tt` | Toggle Terminal |
| `<leader>z` | Zen Mode |
| `<leader>.` | Scratch Buffer |
| `]]`/`[[` | Next/Prev Reference |

---

### `lua/plugins/lsp/` — LSP Configuration

Modular LSP setup using Mason for automatic server installation.

#### `init.lua`
Main LSP setup file.

| Component | Description |
|-----------|-------------|
| **nvim-lspconfig** | Core LSP client configuration |
| **mason.nvim** | LSP server installer |
| **mason-lspconfig** | Bridge between Mason and lspconfig |
| **fidget.nvim** | LSP progress indicator |
| **Diagnostics** | Virtual text, signs, floating windows |

#### `servers.lua`
Language server configurations.

| Server | Language |
|--------|----------|
| `lua_ls` | Lua (with Neovim API support) |
| `pyright` | Python |
| `ts_ls` | TypeScript/JavaScript |
| `jsonls` | JSON |
| `yamlls` | YAML |
| `bashls` | Bash/Shell |
| `dockerls` | Dockerfile |
| `html` | HTML |
| `cssls` | CSS |
| `tailwindcss` | Tailwind CSS |
| `gopls` | Go |
| `rust_analyzer` | Rust |

**Adding a new server:**

```lua
-- In servers.lua, add:
your_server = {
  settings = {
    -- server-specific settings
  },
},
```

#### `keymaps.lua`
LSP-specific keybindings (set when LSP attaches).

| Key | Action |
|-----|--------|
| `Alt + Enter` | Go to Definition |
| `Alt + ←` | Go Back (jump list) |
| `Alt + →` | Go Forward (jump list) |
| `<leader>ld` | Go to Definition |
| `<leader>lD` | Go to Declaration |
| `<leader>lr` | Find References |
| `<leader>li` | Go to Implementation |
| `<leader>lt` | Go to Type Definition |
| `<leader>lk` | Signature Help |
| `K` | Hover Documentation |
| `<leader>ca` | Code Action |
| `<leader>cr` | Rename |
| `<leader>cf` | Format |
| `<leader>ci` | Toggle Inlay Hints |

---

### `lua/utils/` — Utility Functions

Reusable helper functions available via `require("utils")`.

| Function | Description |
|----------|-------------|
| `has_plugin(name)` | Check if a plugin is installed |
| `get_root()` | Get project root directory |
| `is_git_repo()` | Check if in a git repository |
| `get_visual_selection()` | Get visually selected text |
| `safe_require(module)` | Require without error if missing |
| `augroup(name)` | Create autocommand group |
| `is_gui()` | Check if running in GUI (Neovide, etc.) |
| `toggle_option(opt)` | Toggle a vim option |

**Usage:**

```lua
local utils = require("utils")

if utils.is_git_repo() then
  -- do git stuff
end

local root = utils.get_root()
```

---

## 🚀 Installation

### Step 1: Install Neovim

#### 🍎 macOS

```bash
# Option 1: Homebrew (Recommended)
brew install neovim

# Option 2: Download release manually
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-macos-arm64.tar.gz  # For Apple Silicon
# OR
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-macos-x86_64.tar.gz  # For Intel

tar xzf nvim-macos-*.tar.gz
sudo mv nvim-macos-*/ /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim

# Verify installation
nvim --version
```

#### 🐧 Ubuntu/Linux

There are multiple ways to install Neovim on Ubuntu. Choose one:

#### Option A: AppImage (Recommended - Always Latest)

```bash
# Download the latest AppImage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage

# Extract and install system-wide
./nvim.appimage --appimage-extract
sudo rm -rf /opt/nvim
sudo mv squashfs-root /opt/nvim
sudo ln -sf /opt/nvim/AppRun /usr/local/bin/nvim

# Verify installation
nvim --version
```

#### Option B: Build from Source (Latest Features)

```bash
# Install dependencies
sudo apt update
sudo apt install -y ninja-build gettext cmake unzip curl git build-essential

# Clone and build
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=Release
sudo make install

# Verify installation
nvim --version
```

#### Option C: Using PPA (Not Recommended)

> ⚠️ **Warning:** The `stable` PPA has outdated versions, and the `unstable` PPA 
> installs development builds (e.g., 0.12.0-dev) which may have breaking changes.
> **Prefer Option A (AppImage) or Option B (Build from Source) for stable releases.**

```bash
# If you still want to use PPA:
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

# Verify installation
nvim --version
```

#### Option D: Using the Provided Script

```bash
# From this directory
chmod +x scripts/install-neovim.sh
./scripts/install-neovim.sh
```

#### Install Required Dependencies

```bash
# Essential tools for this config
sudo apt install -y ripgrep fd-find fzf git curl unzip

# For lazygit (optional but recommended)
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz
```

---

### Step 2: Backup Existing Config

```bash
# Backup current Neovim config (if any)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

---

### Step 3: Copy This Configuration

The install script copies the config to `~/.config/nvim`:

```bash
# Using the install script (recommended)
./scripts/install-neovim.sh

# Or manually copy
mkdir -p ~/.config/nvim
cp -r ~/myworks/mylearnings/neovim/neovim/init.lua ~/.config/nvim/
cp -r ~/myworks/mylearnings/neovim/neovim/lua ~/.config/nvim/
```

If `~/.config/nvim` already exists, it will be backed up to `~/.config/nvim.bak.<timestamp>`.

---

### Step 4: Launch Neovim

```bash
nvim
```

**First launch will:**
1. Automatically clone lazy.nvim (plugin manager)
2. Install all configured plugins
3. Download and install LSP servers via Mason

Wait for the installation to complete, then restart Neovim.

---

## 📦 Plugin Management

### How Plugins Work

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

- Plugins are defined in `lua/plugins/*.lua` files
- Each file returns a plugin specification table
- lazy.nvim automatically detects and loads all files in the `plugins/` directory

### Opening the Plugin Manager

```
:Lazy
```

Or press `<leader>l` (Space + l)

### Lazy.nvim Commands

| Command | Description |
|---------|-------------|
| `:Lazy` | Open the lazy.nvim dashboard |
| `:Lazy sync` | Install, update, and clean plugins |
| `:Lazy update` | Update all plugins |
| `:Lazy install` | Install missing plugins |
| `:Lazy clean` | Remove unused plugins |
| `:Lazy check` | Check for plugin updates |
| `:Lazy restore` | Restore plugins to lockfile versions |
| `:Lazy profile` | Show plugin load times |
| `:Lazy health` | Run health checks |

### Adding a New Plugin

Create a new file in `lua/plugins/`:

```lua
-- lua/plugins/my-plugin.lua
return {
  "author/plugin-name",
  event = "VeryLazy",  -- Lazy load on VeryLazy event
  dependencies = {
    -- Other plugins this depends on
  },
  opts = {
    -- Plugin options (passed to setup())
  },
  config = function()
    -- Custom configuration (optional)
  end,
}
```

**Example - Adding a colorscheme:**

```lua
-- lua/plugins/colorscheme.lua
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,  -- Load before other plugins
  opts = {
    flavour = "mocha",
    transparent_background = false,
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
```

**Example - Adding nvim-treesitter:**

```lua
-- lua/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "lua", "python", "javascript", "typescript",
      "html", "css", "json", "yaml", "bash",
      "markdown", "markdown_inline",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
```

**Example - Adding nvim-cmp (completion):**

```lua
-- lua/plugins/completion.lua
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
```

### Removing a Plugin

1. Delete the plugin file from `lua/plugins/`
2. Run `:Lazy clean` to remove unused plugins

### Lazy Loading Events

| Event | When it triggers |
|-------|------------------|
| `VeryLazy` | After UI loads (good for most plugins) |
| `BufReadPre` | Before reading a buffer |
| `BufReadPost` | After reading a buffer |
| `BufNewFile` | When creating a new file |
| `InsertEnter` | When entering insert mode |
| `CmdlineEnter` | When entering command mode |
| `LspAttach` | When LSP attaches to buffer |

### Plugin Lockfile

The file `lazy-lock.json` stores exact plugin versions. Commit this file to ensure reproducible installs:

```bash
# Restore plugins to lockfile versions
:Lazy restore
```

---

## ⌨️ Key Bindings

For a complete list of all keybindings, see the **[User Manual](user-manual.md)**.

### Quick Reference

| Key | Action |
|-----|--------|
| `Alt + Enter` | Go to definition |
| `Alt + ←/→` | Navigate back/forward |
| `Ctrl + ←/→/↑/↓` | Move between windows |
| `<Space>e` | Toggle file explorer |
| `<Space>ff` | Find files |
| `<Space>w` | Save file |
| `K` | Hover documentation |

---

## 🗑️ Uninstalling Neovim

To completely remove Neovim and all related sources:

```bash
chmod +x scripts/uninstall-neovim.sh
./scripts/uninstall-neovim.sh
```

This will:
- Remove apt-installed Neovim
- Remove Neovim PPAs (stable and unstable)
- Remove binaries from `/opt/nvim`, `/usr/local/bin`, `/usr/bin`
- Optionally remove user data (`~/.config/nvim`, `~/.local/share/nvim`, etc.)

---

## 🔧 Troubleshooting

### Plugins not installing

```bash
# Clear cache and reinstall
rm -rf ~/.local/share/nvim
rm -rf ~/.cache/nvim
nvim  # Restart and let lazy.nvim reinstall
```

### LSP servers not working

```bash
# Open Mason and check server status
:Mason

# Reinstall a specific server
:MasonInstall pyright
```

### Check Neovim health

```bash
:checkhealth
```

### View startup time

```bash
nvim --startuptime startup.log
# Or in Neovim
:Lazy profile
```

---

## 📝 License

MIT
