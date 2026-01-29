# Neovim User Manual

A complete guide to keybindings and navigation in this Neovim configuration.

## Leader Key: `<Space>`

The leader key is `<Space>`. Many commands start with the leader key followed by other keys.

---

## ❓ Which-Key (Keymap Helper)

Press `<Space>` and wait 300ms to see a popup of available keybindings.

| Key | Action |
|-----|--------|
| `<Space>?` | Show buffer-local keymaps |
| `<Space>` (wait) | Shows keymap popup automatically |

**Groups shown:**
- `<Space>f` → Find/Files
- `<Space>g` → Git
- `<Space>b` → Buffers
- `<Space>l` → LSP
- `<Space>c` → Code
- `<Space>u` → UI/Toggle
- `<Space>x` → Diagnostics

---

## 🧭 Code Navigation (Lspsaga)

Navigate through code definitions with enhanced LSP UI powered by Lspsaga.

| Key | Action |
|-----|--------|
| `Alt + Enter` | Go to definition |
| `Alt + ←` | Go back (jump list) |
| `Alt + →` | Go forward (jump list) |
| `<Space>gd` | **Peek definition** (floating window) |
| `<Space>gD` | Go to definition |
| `<Space>gt` | Peek type definition |
| `<Space>gT` | Go to type definition |
| `<Space>gf` | **LSP Finder** (refs + implementations) |
| `K` | Hover documentation |
| `<Space>ld` | Go to definition (legacy) |
| `<Space>lD` | Go to declaration |
| `<Space>lr` | Find all references |
| `<Space>li` | Go to implementation |
| `<Space>lt` | Go to type definition |
| `<Space>lk` | Signature help |

**Tip:** Hold `Alt` and press `←` multiple times to go back through your navigation history.

---

## 🪟 Window Navigation

Move between split windows using `Ctrl + Arrow` keys.

| Key | Action |
|-----|--------|
| `Ctrl + ←` | Go to left window |
| `Ctrl + →` | Go to right window |
| `Ctrl + ↑` | Go to upper window |
| `Ctrl + ↓` | Go to lower window |
| `Ctrl + h` | Go to left window (vim-style) |
| `Ctrl + j` | Go to lower window (vim-style) |
| `Ctrl + k` | Go to upper window (vim-style) |
| `Ctrl + l` | Go to right window (vim-style) |

---

## 📐 Window Resize

Resize split windows using `Ctrl + Shift + Arrow` keys.

| Key | Action |
|-----|--------|
| `Ctrl+Shift + ←` | Decrease width |
| `Ctrl+Shift + →` | Increase width |
| `Ctrl+Shift + ↑` | Increase height |
| `Ctrl+Shift + ↓` | Decrease height |

---

## ✂️ Window Splits

| Key | Action |
|-----|--------|
| `<Space>sv` | Split vertical |
| `<Space>sh` | Split horizontal |
| `<Space>se` | Equal size splits |
| `<Space>sx` | Close split |

---

## 📁 File Explorer & Finder

| Key | Action |
|-----|--------|
| `<Space>e` | Toggle file explorer |
| `<Space>;` | Dashboard |
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep (search in files) |
| `<Space>fw` | Grep word under cursor |
| `<Space>fb` | Find buffers |
| `<Space>fr` | Recent files |
| `<Space>fc` | Find config files |
| `<Space>fh` | Help tags |
| `<Space>fk` | Keymaps |
| `<Space>fm` | Marks |
| `<Space>fp` | Projects |
| `<Space>fs` | LSP Symbols |
| `<Space>fd` | Diagnostics |
| `<Space>ft` | Todo comments |
| `<Space>/` | Grep open buffers |
| `<Space><Space>` | Smart picker (auto-detect) |

### Explorer Configuration

To adjust the explorer width, edit `lua/plugins/snacks.lua`:

```lua
styles = {
  explorer = {
    width = 25,  -- Change this number (default: 25-35)
  },
}
```

**Recommended widths:** 25 (compact), 30 (default), 35 (wide)

---

## 📄 Buffers

Working with multiple open files (buffers) in Neovim.

| Key | Action |
|-----|--------|
| `Shift + h` | Previous buffer |
| `Shift + l` | Next buffer |
| `[b` | Previous buffer |
| `]b` | Next buffer |
| `<Space>bb` | Switch to other buffer (last buffer) |
| `<Space>bd` | Delete buffer |
| `<Space>bo` | Delete other buffers |
| `<Space>ba` | Delete all buffers |
| `<Space>bl` | List buffers (may have slight delay) |
| `Alt + b` | **List buffers** (instant, recommended) |
| `<Space>fb` | Find buffers (alternative) |

**Tip:** Use `Alt+b` for instant buffer list, or `<Space>bl` if you prefer the Space prefix (has 300ms timeout).

**Note:** Maximum 20 buffers open at once (auto-closes oldest). Change in `lua/config/autocmds.lua`.

---

## 🔀 Git

### Git Sync Status Indicator

In the status line (bottom), next to the branch name, you'll see a git sync indicator:

| Icon | Meaning |
|------|---------|
| `●` | Idle (gray) |
| `⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏` | Syncing (blue, animated) |
| `✓` | Success (green, shows for 2 seconds) |
| `✗` | Error (red, click to see error details) |

### Git Commands (Background Operations)

These commands run silently in the background and only show a terminal if they fail.

| Key | Action |
|-----|--------|
| `<Space>gp` | Git pull (background) |
| `<Space>gP` | Git push (background) |
| `<Space>gf` | Git fetch (background) |
| `<Space>gg` | Open Lazygit |
| `<Space>gl` | Git log (project) |
| `<Space>gL` | Git log (current file) |
| `<Space>gs` | Git status (picker) |
| `<Space>gc` | Git commits (picker) |
| `<Space>gd` | Git diff (picker) |
| `<Space>gb` | Git branches (local only) |
| `<Space>gbb` | Git branches (all - local + remote) |
| `<Space>gbl` | Git blame line (popup) |
| `<Space>gB` | Git browse (open in GitHub/GitLab) |

**Tip:** Watch the status line indicator when running `<Space>gp` - it will spin during the pull and show a checkmark when complete.

### Inline Git Blame

| Key | Action |
|-----|--------|
| `<Space>tb` | Toggle inline blame (enabled by default) |

Shows git blame info (author, date) at the end of the current line.

### Hunk Navigation (gitsigns)

A **hunk** is a group of consecutive changed lines.

| Key | Action |
|-----|--------|
| `]h` | Jump to next hunk |
| `[h` | Jump to previous hunk |

### Hunk Actions

| Key | Action |
|-----|--------|
| `<Space>ghs` | Stage hunk |
| `<Space>ghr` | Reset hunk (undo changes) |
| `<Space>ghS` | Stage entire buffer |
| `<Space>ghu` | Undo stage hunk |
| `<Space>ghR` | Reset entire buffer |
| `<Space>ghp` | Preview hunk (see changes) |
| `<Space>ghd` | Diff this file |

### Git Status Icons (Explorer)

| Icon | Meaning |
|------|---------|
| `✓` | Staged |
| `✗` | Unstaged/Modified |
| `★` | Untracked (new file) |
| `` | Deleted |
| `➜` | Renamed |

### Gutter Signs (in code)

| Sign | Meaning |
|------|---------|
| `│` (green) | Added lines |
| `│` (blue) | Modified lines |
| `_` (red) | Deleted lines |
| `┆` | Untracked file |

---

## 🔧 LSP Actions (Lspsaga)

Enhanced LSP UI with code actions, rename, and diagnostics.

| Key | Action |
|-----|--------|
| `<Space>ca` | **Code action** (Lspsaga - shows in floating menu) |
| `<Space>cr` | **Rename symbol** (Lspsaga) |
| `<Space>cR` | Rename symbol (project-wide) |
| `<Space>cf` | Format code |
| `<Space>cd` | **Cursor diagnostics** (Lspsaga) |
| `<Space>cD` | **Line diagnostics** (Lspsaga) |
| `<Space>co` | **Code outline** (symbol tree) |
| `<Space>ci` | Incoming calls (call hierarchy) |
| `<Space>cO` | Outgoing calls (call hierarchy) |
| `<Space>nd` | Generate docstring (Python/JS/TS/Lua) |
| `[d` | Previous diagnostic (Lspsaga) |
| `]d` | Next diagnostic (Lspsaga) |

**Docstring conventions:**
- Python: Google style
- JavaScript: JSDoc
- TypeScript: TSDoc
- Lua: EmmyLua

---

## 📝 General

| Key | Action |
|-----|--------|
| `<Space>w` | Save file |
| `<Space>q` | Quit |
| `<Space>Q` | Quit all (force) |
| `<Space>l` | Open Lazy (plugin manager) |
| `<Space>.` | Toggle scratch buffer |
| `<Space>S` | Select scratch buffer |
| `<Space>rn` | Rename file |
| `<Space>pp` | Toggle profiler |
| `jk` or `jj` | Exit insert mode |
| `<Esc>` | Clear search highlights |
| `Ctrl + a` | Select all |
| `Alt + c` | Toggle comment (line or selection) |
| `Shift + ←/→/↑/↓` | Visual selection with arrow keys |

---

## ↕️ Move Lines/Blocks (mini.move)

| Key | Action |
|-----|--------|
| `Alt + ↓` | Move line/selection down |
| `Alt + ↑` | Move line/selection up |
| `Alt + ←` | Move line/selection left (indent) |
| `Alt + →` | Move line/selection right (outdent) |
| `Alt + j` | Move line down (legacy) |
| `Alt + k` | Move line up (legacy) |

Works in normal and visual modes. In visual mode, moves the entire selection.

---

## 🔍 Diagnostics & Quickfix (Trouble)

Pretty diagnostics panel with better visualization.

| Key | Action |
|-----|--------|
| `<Space>xx` | **Workspace diagnostics** (Trouble) |
| `<Space>xX` | Buffer diagnostics (Trouble) |
| `<Space>xs` | Symbols (Trouble) |
| `<Space>xl` | LSP references (Trouble) |
| `<Space>xL` | Location list (Trouble) |
| `<Space>xQ` | Quickfix list (Trouble) |
| `[d` | Previous diagnostic (Lspsaga) |
| `]d` | Next diagnostic (Lspsaga) |
| `[x` | Previous Trouble/Quickfix item |
| `]x` | Next Trouble/Quickfix item |
| `[q` | Previous quickfix |
| `]q` | Next quickfix |

---

## 🔄 Toggles

| Key | Action |
|-----|--------|
| `<Space>z` | Zen mode (distraction-free) |
| `<Space>Z` | Zoom window (maximize) |
| `<Space>uw` | Toggle word wrap |
| `<Space>us` | Toggle spelling |
| `<Space>ud` | Toggle dim inactive windows |
| `<Space>ui` or `<Space>uh` | Toggle inlay hints |
| `<Space>uD` | Toggle diagnostics |
| `<Space>uT` | Toggle treesitter |
| `<Space>ug` | Toggle indent guides |
| `<Space>un` | Show notification history |
| `<Space>uN` | Dismiss all notifications |
| `Alt+Shift+L` | Cycle line number modes: Both → Absolute → Relative → Both |

---

## 🖥️ Terminal

| Key | Action |
|-----|--------|
| `<Space>tt` | Toggle terminal |
| `Ctrl + /` | Toggle terminal (alternative) |
| `<Esc><Esc>` | Exit terminal mode |
| `Ctrl + h/j/k/l` | Navigate windows from terminal |

---

## 📋 Clipboard & Yank

| Key | Action |
|-----|--------|
| `<Space>y` | Yank to system clipboard |
| `<Space>Y` | Yank line to system clipboard |
| `p` (in visual) | Paste without yanking replaced text |

---

## ➕ Add Blank Lines

| Key | Action |
|-----|--------|
| `]<Space>` | Add blank line below |
| `[<Space>` | Add blank line above |

---

## 📑 Tabs

| Key | Action |
|-----|--------|
| `<Space><Tab><Tab>` | New tab |
| `<Space><Tab>]` | Next tab |
| `<Space><Tab>[` | Previous tab |
| `<Space><Tab>x` | Close tab |
| `<Space><Tab>f` | First tab |
| `<Space><Tab>l` | Last tab |

---

## 🔎 Search & Scroll

| Key | Action |
|-----|--------|
| `Ctrl + d` | Scroll down (centered) |
| `Ctrl + u` | Scroll up (centered) |
| `n` | Next search result (centered) |
| `N` | Previous search result (centered) |
| `]]` | Next reference (word under cursor) |
| `[[` | Previous reference (word under cursor) |

---

## 🧩 Bracket / Pair Navigation

| Key | Action |
|-----|--------|
| `%` | Jump to matching bracket/brace/paren |

---

## 🧱 Block / Indent Navigation

Navigate through code blocks using indent levels.

| Key | Action |
|-----|--------|
| `[i` | Jump to start of current indent block |
| `]i` | Jump to end of current indent block |

**Example:** Inside a Python function, press `[i` to jump to the `def` line.

---

## Quick Reference Card

```
╔═══════════════════════════════════════════════════════════════╗
║                    NEOVIM QUICK REFERENCE                      ║
╠═══════════════════════════════════════════════════════════════╣
║  CODE NAVIGATION                                               ║
║    Alt+Enter     → Go to definition                            ║
║    Alt+←/→       → Navigate back/forward                       ║
║                                                                ║
║  WINDOW NAVIGATION                                             ║
║    Ctrl+←/→/↑/↓  → Move between windows                        ║
║    Ctrl+Shift+←/→/↑/↓ → Resize windows                         ║
║                                                                ║
║  FILE EXPLORER                                                 ║
║    Space+e       → Toggle explorer                             ║
║    Space+ff      → Find files                                  ║
║    Space+fg      → Search in files                             ║
║                                                                ║
║  COMMON ACTIONS                                                ║
║    Space+w       → Save file                                   ║
║    Space+q       → Quit                                        ║
║    K             → Hover documentation                         ║
║    Space+ca      → Code actions                                ║
║    Space+cr      → Rename symbol                               ║
╚═══════════════════════════════════════════════════════════════╝
```
