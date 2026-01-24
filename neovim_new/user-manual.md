# Neovim User Manual

A complete guide to keybindings and navigation in this Neovim configuration.

## Leader Key: `<Space>`

The leader key is `<Space>`. Many commands start with the leader key followed by other keys.

---

## 🧭 Code Navigation

Navigate through code definitions and jump history. Hold `Alt` and press arrow keys to navigate back/forward quickly.

| Key | Action |
|-----|--------|
| `Alt + Enter` | Go to definition |
| `Alt + ←` | Go back (jump list) |
| `Alt + →` | Go forward (jump list) |
| `<Space>ld` | Go to definition |
| `<Space>lD` | Go to declaration |
| `<Space>lr` | Find all references |
| `<Space>li` | Go to implementation |
| `<Space>lt` | Go to type definition |
| `<Space>lk` | Signature help |
| `K` | Hover documentation |

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
| `<Space>ff` | Find files |
| `<Space>fg` | Live grep (search in files) |
| `<Space>fb` | Find buffers |
| `<Space>fr` | Recent files |
| `<Space>fh` | Help tags |
| `<Space>fk` | Keymaps |
| `<Space><Space>` | Smart picker |

---

## 📄 Buffers

| Key | Action |
|-----|--------|
| `Shift + h` | Previous buffer |
| `Shift + l` | Next buffer |
| `[b` | Previous buffer |
| `]b` | Next buffer |
| `<Space>bd` | Delete buffer |
| `<Space>bb` | Switch to other buffer |

---

## 🔀 Git

### Git Commands (snacks.nvim)

| Key | Action |
|-----|--------|
| `<Space>gg` | Open Lazygit |
| `<Space>gl` | Git log |
| `<Space>gL` | Git log (current file) |
| `<Space>gb` | Git blame line |
| `<Space>gB` | Git browse (open in GitHub/GitLab) |
| `<Space>gs` | Git status (picker) |
| `<Space>gc` | Git commits (picker) |
| `<Space>gd` | Git diff (picker) |

### Hunk Navigation (gitsigns)

A **hunk** is a group of consecutive changed lines.

| Key | Action |
|-----|--------|
| `]h` | Jump to next hunk |
| `[h` | Jump to previous hunk |

### Hunk Actions

| Key | Action |
|-----|--------|
| `<Space>hs` | Stage hunk |
| `<Space>hr` | Reset hunk (undo changes) |
| `<Space>hS` | Stage entire buffer |
| `<Space>hu` | Undo stage hunk |
| `<Space>hR` | Reset entire buffer |
| `<Space>hp` | Preview hunk (see changes) |
| `<Space>hb` | Blame line (who changed it) |
| `<Space>hB` | Toggle inline blame |
| `<Space>hd` | Diff this file |

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

## 🔧 LSP Actions

| Key | Action |
|-----|--------|
| `<Space>ca` | Code action (quick fixes) |
| `<Space>cr` | Rename symbol |
| `<Space>cf` | Format code |
| `<Space>ci` | Toggle inlay hints |
| `<Space>cd` | Line diagnostics |

---

## 📝 General

| Key | Action |
|-----|--------|
| `<Space>w` | Save file |
| `<Space>q` | Quit |
| `<Space>Q` | Quit all (force) |
| `<Space>l` | Open Lazy (plugin manager) |
| `jk` or `jj` | Exit insert mode |
| `<Esc>` | Clear search highlights |
| `Ctrl + a` | Select all |

---

## ↕️ Move Lines

| Key | Action |
|-----|--------|
| `Alt + j` | Move line down |
| `Alt + k` | Move line up |

Works in normal, insert, and visual modes.

---

## 🔍 Diagnostics & Quickfix

| Key | Action |
|-----|--------|
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `[q` | Previous quickfix |
| `]q` | Next quickfix |
| `<Space>xl` | Open location list |
| `<Space>xq` | Open quickfix list |

---

## 🔄 Toggles

| Key | Action |
|-----|--------|
| `<Space>z` | Zen mode |
| `<Space>Z` | Zoom window |
| `<Space>uw` | Toggle word wrap |
| `Alt+Shift+L` | Cycle line number modes: Both → Absolute → Relative → Both |
| `<Space>us` | Toggle spelling |
| `<Space>ud` | Toggle dim inactive |
| `<Space>ui` | Toggle inlay hints |

---

## 🖥️ Terminal

| Key | Action |
|-----|--------|
| `<Space>tt` | Toggle terminal |
| `<Esc><Esc>` | Exit terminal mode |

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
