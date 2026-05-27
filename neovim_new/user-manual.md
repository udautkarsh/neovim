# Neovim User Manual

A complete guide to keybindings and navigation in this Neovim configuration.

## Leader Key: `<Space>`

The leader key is `<Space>`. Many commands start with the leader key followed by other keys.

---

## ❓ Which-Key (Keymap Helper)

Press `<Space>` and wait 300ms to see a popup of available keybindings.


| Key              | Action                           |
| ---------------- | -------------------------------- |
| `<Space>?`       | Show buffer-local keymaps        |
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


| Key           | Action                                  |
| ------------- | --------------------------------------- |
| `Alt + Enter` | Go to definition                        |
| `Alt + ←`     | Go back (jump list)                     |
| `Alt + →`     | Go forward (jump list)                  |
| `<Space>gd`   | **Peek definition** (floating window)   |
| `<Space>gD`   | Go to definition                        |
| `<Space>gt`   | Peek type definition                    |
| `<Space>gT`   | Go to type definition                   |
| `<Space>gf`   | **LSP Finder** (refs + implementations) |
| `K`           | Hover documentation                     |
| `<Space>ld`   | Go to definition (legacy)               |
| `<Space>lD`   | Go to declaration                       |
| `<Space>lr`   | Find all references                     |
| `<Space>li`   | Go to implementation                    |
| `<Space>lt`   | Go to type definition                   |
| `<Space>lk`   | Signature help                          |


**Tip:** Hold `Alt` and press `←` multiple times to go back through your navigation history.

---

## 🪟 Window Navigation

Move between split windows using `Ctrl + Arrow` keys.


| Key        | Action                         |
| ---------- | ------------------------------ |
| `Ctrl + ←` | Go to left window              |
| `Ctrl + →` | Go to right window             |
| `Ctrl + ↑` | Go to upper window             |
| `Ctrl + ↓` | Go to lower window             |
| `Ctrl + h` | Go to left window (vim-style)  |
| `Ctrl + j` | Go to lower window (vim-style) |
| `Ctrl + k` | Go to upper window (vim-style) |
| `Ctrl + l` | Go to right window (vim-style) |


---

## 📐 Window Resize

Resize split windows using `Ctrl + Shift + Arrow` keys.


| Key              | Action          |
| ---------------- | --------------- |
| `Ctrl+Shift + ←` | Decrease width  |
| `Ctrl+Shift + →` | Increase width  |
| `Ctrl+Shift + ↑` | Increase height |
| `Ctrl+Shift + ↓` | Decrease height |


---

## ✂️ Window Splits


| Key         | Action            |
| ----------- | ----------------- |
| `<Space>sv` | Split vertical    |
| `<Space>sh` | Split horizontal  |
| `<Space>se` | Equal size splits |
| `<Space>sx` | Close split       |


---

## 📁 File Explorer & Finder


| Key              | Action                      |
| ---------------- | --------------------------- |
| `<Space>e`       | Toggle file explorer        |
| `<Space>;`       | Dashboard                   |
| `<Space>ff`      | Find files                  |
| `<Space>fg`      | Live grep (search in files) |
| `<Space>fw`      | Grep word under cursor      |
| `<Space>fb`      | Find buffers                |
| `<Space>fr`      | Recent files                |
| `<Space>fc`      | Find config files           |
| `<Space>fh`      | Help tags                   |
| `<Space>fk`      | Keymaps                     |
| `<Space>fm`      | Marks                       |
| `<Space>fp`      | Projects                    |
| `<Space>fs`      | LSP Symbols                 |
| `<Space>fd`      | Diagnostics                 |
| `<Space>ft`      | Todo comments               |
| `<Space>/`       | Grep open buffers           |
| `<Space><Space>` | Smart picker (auto-detect)  |


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


| Key         | Action                                  |
| ----------- | --------------------------------------- |
| `Shift + h` | Previous buffer                         |
| `Shift + l` | Next buffer                             |
| `[b`        | Previous buffer                         |
| `]b`        | Next buffer                             |
| `<Space>bb` | Switch to other buffer (last buffer)    |
| `<Space>bd` | Delete buffer                           |
| `<Space>bo` | Delete other buffers                    |
| `<Space>ba` | Delete all buffers                      |
| `<Space>bl` | List buffers (may have slight delay)    |
| `Alt + b`   | **List buffers** (instant, recommended) |
| `<Space>fb` | Find buffers (alternative)              |


**Tip:** Use `Alt+b` for instant buffer list, or `<Space>bl` if you prefer the Space prefix (has 300ms timeout).

**Note:** Maximum 20 buffers open at once (auto-closes oldest). Change in `lua/config/autocmds.lua`.

---

## 🔀 Git

### Git Sync Status Indicator

In the status line (bottom), next to the branch name, you'll see a git sync indicator:


| Icon         | Meaning                                 |
| ------------ | --------------------------------------- |
| `●`          | Idle (gray)                             |
| `⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏` | Syncing (blue, animated)                |
| `✓`          | Success (green, shows for 2 seconds)    |
| `✗`          | Error (red, click to see error details) |


### Git Commands (Background Operations)

These commands run silently in the background and only show a terminal if they fail.


| Key          | Action                              |
| ------------ | ----------------------------------- |
| `<Space>gp`  | Git pull (background)               |
| `<Space>gP`  | Git push (background)               |
| `<Space>gf`  | Git fetch (background)              |
| `<Space>gg`  | Open Lazygit                        |
| `<Space>gl`  | Git log (project)                   |
| `<Space>gL`  | Git log (current file)              |
| `<Space>gs`  | Git status (picker)                 |
| `<Space>gc`  | Git commits (picker)                |
| `<Space>gd`  | Git diff (picker)                   |
| `<Space>gb`  | Git branches (local only)           |
| `<Space>gbb` | Git branches (all - local + remote) |
| `<Space>gbl` | Git blame line (popup)              |
| `<Space>gB`  | Git browse (open in GitHub/GitLab)  |


**Tip:** Watch the status line indicator when running `<Space>gp` - it will spin during the pull and show a checkmark when complete.

### Inline Git Blame


| Key         | Action                                   |
| ----------- | ---------------------------------------- |
| `<Space>tb` | Toggle inline blame (enabled by default) |


Shows git blame info (author, date) at the end of the current line.

### Hunk Navigation (gitsigns)

A **hunk** is a group of consecutive changed lines.


| Key  | Action                |
| ---- | --------------------- |
| `]h` | Jump to next hunk     |
| `[h` | Jump to previous hunk |


### Hunk Actions


| Key          | Action                     |
| ------------ | -------------------------- |
| `<Space>ghs` | Stage hunk                 |
| `<Space>ghr` | Reset hunk (undo changes)  |
| `<Space>ghS` | Stage entire buffer        |
| `<Space>ghu` | Undo stage hunk            |
| `<Space>ghR` | Reset entire buffer        |
| `<Space>ghp` | Preview hunk (see changes) |
| `<Space>ghd` | Diff this file             |


### Git Status Icons (Explorer)


| Icon | Meaning              |
| ---- | -------------------- |
| `✓`  | Staged               |
| `✗`  | Unstaged/Modified    |
| `★`  | Untracked (new file) |
| ``   | Deleted              |
| `➜`  | Renamed              |


### Gutter Signs (in code)


| Sign        | Meaning        |
| ----------- | -------------- |
| `│` (green) | Added lines    |
| `│` (blue)  | Modified lines |
| `_` (red)   | Deleted lines  |
| `┆`         | Untracked file |


---

## 🔧 LSP Actions (Lspsaga)

Enhanced LSP UI with code actions, rename, and diagnostics.


| Key         | Action                                             |
| ----------- | -------------------------------------------------- |
| `<Space>ca` | **Code action** (Lspsaga - shows in floating menu) |
| `<Space>cr` | **Rename symbol** (Lspsaga)                        |
| `<Space>cR` | Rename symbol (project-wide)                       |
| `<Space>cf` | Format code                                        |
| `<Space>cd` | **Cursor diagnostics** (Lspsaga)                   |
| `<Space>cD` | **Line diagnostics** (Lspsaga)                     |
| `<Space>co` | **Code outline** (symbol tree)                     |
| `<Space>ci` | Incoming calls (call hierarchy)                    |
| `<Space>cO` | Outgoing calls (call hierarchy)                    |
| `<Space>nd` | Generate docstring (Python/JS/TS/Lua)              |
| `[d`        | Previous diagnostic (Lspsaga)                      |
| `]d`        | Next diagnostic (Lspsaga)                          |


**Docstring conventions:**

- Python: Google style
- JavaScript: JSDoc
- TypeScript: TSDoc
- Lua: EmmyLua

---

## 📝 General


| Key               | Action                             |
| ----------------- | ---------------------------------- |
| `<Space>w`        | Save file                          |
| `<Space>q`        | Quit                               |
| `<Space>Q`        | Quit all (force)                   |
| `<Space>l`        | Open Lazy (plugin manager)         |
| `<Space>.`        | Toggle scratch buffer              |
| `<Space>S`        | Select scratch buffer              |
| `<Space>rn`       | Rename file                        |
| `<Space>pp`       | Toggle profiler                    |
| `jk` or `jj`      | Exit insert mode                   |
| `<Esc>`           | Clear search highlights            |
| `Ctrl + a`        | Select all                         |
| `Alt + c`         | Toggle comment (line or selection) |
| `Shift + ←/→/↑/↓` | Visual selection with arrow keys   |


---

## ↕️ Move Lines/Blocks (mini.move)


| Key       | Action                              |
| --------- | ----------------------------------- |
| `Alt + ↓` | Move line/selection down            |
| `Alt + ↑` | Move line/selection up              |
| `Alt + ←` | Move line/selection left (indent)   |
| `Alt + →` | Move line/selection right (outdent) |
| `Alt + j` | Move line down (legacy)             |
| `Alt + k` | Move line up (legacy)               |


Works in normal and visual modes. In visual mode, moves the entire selection.

---

## 🔍 Diagnostics & Quickfix (Trouble)

Pretty diagnostics panel with better visualization.


| Key         | Action                              |
| ----------- | ----------------------------------- |
| `<Space>xx` | **Workspace diagnostics** (Trouble) |
| `<Space>xX` | Buffer diagnostics (Trouble)        |
| `<Space>xs` | Symbols (Trouble)                   |
| `<Space>xl` | LSP references (Trouble)            |
| `<Space>xL` | Location list (Trouble)             |
| `<Space>xQ` | Quickfix list (Trouble)             |
| `[d`        | Previous diagnostic (Lspsaga)       |
| `]d`        | Next diagnostic (Lspsaga)           |
| `[x`        | Previous Trouble/Quickfix item      |
| `]x`        | Next Trouble/Quickfix item          |
| `[q`        | Previous quickfix                   |
| `]q`        | Next quickfix                       |


---

## 🐞 Debugging Python (DAP)

Debugging is powered by **nvim-dap** + **nvim-dap-python** (which uses
`debugpy`). All keys live under `<Space>D` (capital **D** = *Debug*) and
mirror the single-letter commands you already know from `pdb`.

### Keymaps (pdb-style)


| Key         | Action                                               | pdb          |
| ----------- | ---------------------------------------------------- | ------------ |
| `<Space>Dc` | **Continue** / start a debug session                 | `c`          |
| `<Space>Dn` | Step over (**next** line)                            | `n`          |
| `<Space>Ds` | **Step** into function                               | `s`          |
| `<Space>Dr` | Step out (**return** from function)                  | `r`          |
| `<Space>Db` | Toggle **breakpoint** on current line                | `b`          |
| `<Space>DB` | Conditional breakpoint (prompts for expression)      | `b … , cond` |
| `<Space>Dq` | **Quit** / terminate session                         | `q`          |
| `<Space>Dp` | **Print** / evaluate expression under cursor (hover) | `p`          |
| `<Space>DC` | Run to **C**ursor                                    | `until`      |
| `<Space>Dl` | Run **last** debug configuration                     | —            |
| `<Space>DL` | Pick a **L**aunch configuration                      | —            |
| `<Space>Du` | Toggle the DAP **UI** (variables / stack / scopes)   | —            |
| `<Space>DR` | Toggle the DAP **R**EPL                              | —            |
| `<Space>Dt` | Debug nearest **t**est method (pytest / unittest)    | —            |
| `<Space>DT` | Debug containing **T**est class                      | —            |


> Tip: type `<Space>D` and pause — which-key shows the menu so you don't
> have to memorise them.

### Workflow at a glance

1. Open the Python file.
2. `<Space>Db` on lines you want to stop at.
3. `<Space>Dc` to start. On the **first** run nvim-dap shows a picker
  asking *which* configuration to use; pick one (see below).
4. The DAP UI opens automatically — stack frame, scopes, watches and
  breakpoints appear in side panels.
5. Step with `<Space>Dn` / `<Space>Ds` / `<Space>Dr`, evaluate a value
  with `<Space>Dp` (visual selection also works), terminate with
   `<Space>Dq`.

To re-run the same configuration without the picker, use
`<Space>Dl` (*run last*). To force the picker again, use `<Space>DL`.

---

### 1. Debugging local code

nvim-dap-python registers these launch configurations automatically:


| Config (picker entry)          | What it does                                           |
| ------------------------------ | ------------------------------------------------------ |
| **Launch file**                | Runs the **currently open** `.py` file under debugpy   |
| **Launch file with arguments** | Same, but prompts for CLI args (space separated)       |
| **Attach remote**              | Connects to an already-running debugpy server (see §2) |


#### Debug the current file

```text
1. Open the file, set breakpoints with <Space>Db
2. <Space>Dc → pick "Launch file"
3. Step with <Space>Dn / <Space>Ds, evaluate with <Space>Dp
4. <Space>Dq to stop
```

#### Debug with CLI arguments

```text
1. <Space>Dc → pick "Launch file with arguments"
2. Type the arguments at the prompt, e.g.  --config dev.yaml --verbose
3. Press Enter — debug session starts
```

#### Debug a pytest / unittest test

Put the cursor anywhere inside the test function and:

```text
<Space>Dt   →  debug just that test function
<Space>DT   →  debug all tests in the surrounding class
```

Requires `pytest` (or `unittest`) installed in the active venv.

#### Run to the cursor (no breakpoint needed)

```text
1. Put cursor on the line you want to inspect
2. <Space>DC
```

#### Python interpreter / venv

debugpy runs inside the **same interpreter** Pyright uses for the
project. Detection order (see `lua/utils/init.lua → get_python_path`):

1. `vim.g.python3_host_prog` (manual override)
2. `$VIRTUAL_ENV`
3. `.venv` / `venv` / `env` / `.virtualenv` walked upward from the file
4. `poetry env info -p`
5. `pipenv --venv`
6. system `python3`

Check what is being used:

```text
:PyVenvShow
```

Switch interpreter (if multiple venvs / conda / pyenv):

```text
<Space>vs        " interactive picker
<Space>vc        " use last cached venv for this cwd
```

---

### 2. Debugging remote code (`debugpy` attach)

Useful when:

- The process runs **inside a Docker container**.
- The code runs on a **different machine** (SSH, VM, edge device).
- You need to debug a long-running service (web app, worker, daemon)
without restarting it from Neovim.

#### Step 1 — install `debugpy` on the remote

```bash
# in the remote's venv
pip install debugpy
```

#### Step 2 — start the program with debugpy listening

**Option A — wait for the debugger to attach before running:**

```bash
python -m debugpy --listen 0.0.0.0:5678 --wait-for-client myapp.py
```

**Option B — start the program, attach later:**

```bash
python -m debugpy --listen 0.0.0.0:5678 myapp.py
```

**Option C — inside the code (handy for services):**

```python
import debugpy
debugpy.listen(("0.0.0.0", 5678))
debugpy.wait_for_client()      # optional: block until VS Code / nvim attaches
debugpy.breakpoint()           # optional: programmatic breakpoint
```

> `0.0.0.0` lets remote machines connect. Use `127.0.0.1` if the
> debugpy server runs on the same host as Neovim.

#### Step 3 — forward the port (if the process is remote)


| Scenario              | Command                                       |
| --------------------- | --------------------------------------------- |
| SSH host              | `ssh -L 5678:localhost:5678 user@remote-host` |
| Docker (host network) | nothing — already reachable                   |
| Docker (bridge)       | `docker run -p 5678:5678 …`                   |
| Docker Compose        | add `ports: ["5678:5678"]` to the service     |
| Kubernetes pod        | `kubectl port-forward pod/my-pod 5678:5678`   |


The goal: `**localhost:5678` on the machine running Neovim** must reach
the debugpy listener.

#### Step 4 — attach from Neovim

```text
1. Open any file from the same project in Neovim
2. (Optional) set breakpoints with <Space>Db   — paths must match what
   debugpy sees on the remote; see "Path mapping" below
3. <Space>Dc  →  pick "Attach remote"
4. Host:  127.0.0.1   (or the forwarded host)
5. Port:  5678
6. Debug session starts — DAP UI shows the remote stack
```

Use `<Space>Dl` to attach again with the same host/port without being
prompted.

#### Path mapping (when local & remote paths differ)

If your code lives at `/app/src/...` on the remote but at
`/home/me/project/src/...` locally, breakpoints won't bind because
debugpy sees different paths. Two options:

1. **Open the project from the matching root** so paths align (easiest
  in Docker where you mount your repo at `/app`: just `cd` to that
   path locally too — usually unnecessary if the structure matches).
2. **Configure `pathMappings`** by editing
  `lua/plugins/dap.lua` and adding a custom configuration:

```lua
local dap = require("dap")
dap.configurations.python = dap.configurations.python or {}
table.insert(dap.configurations.python, {
  type = "python",
  request = "attach",
  name = "Attach remote (Docker)",
  connect = { host = "127.0.0.1", port = 5678 },
  pathMappings = {
    { localRoot = vim.fn.getcwd(),  remoteRoot = "/app" },
  },
  justMyCode = false,
})
```

After saving, restart Neovim and the new entry shows up in the
configuration picker (`<Space>DL`).

#### Common remote pitfalls


| Symptom                                                        | Likely cause                           | Fix                                         |
| -------------------------------------------------------------- | -------------------------------------- | ------------------------------------------- |
| `Connection refused`                                           | debugpy not listening / wrong port     | check the `--listen` flag and port-forward  |
| Session attaches but breakpoints are *unbound* (hollow circle) | Path mismatch between local and remote | add `pathMappings` (see above)              |
| Stuck at "waiting for client"                                  | `--wait-for-client` was used           | run `<Space>Dc` → Attach remote             |
| Can't step into stdlib / site-packages                         | `justMyCode = true` (default)          | set `justMyCode = false` in a custom config |


---

### Useful DAP commands


| Command                | Purpose                                   |
| ---------------------- | ----------------------------------------- |
| `:DapShowLog`          | Open the DAP log (debugging the debugger) |
| `:DapContinue`         | Same as `<Space>Dc`                       |
| `:DapTerminate`        | Same as `<Space>Dq`                       |
| `:DapToggleBreakpoint` | Same as `<Space>Db`                       |
| `:Mason`               | Verify `debugpy` is installed             |


---

## 🔄 Toggles


| Key                        | Action                                                     |
| -------------------------- | ---------------------------------------------------------- |
| `<Space>z`                 | Zen mode (distraction-free)                                |
| `<Space>Z`                 | Zoom window (maximize)                                     |
| `<Space>uw`                | Toggle word wrap                                           |
| `<Space>us`                | Toggle spelling                                            |
| `<Space>ud`                | Toggle dim inactive windows                                |
| `<Space>ui` or `<Space>uh` | Toggle inlay hints                                         |
| `<Space>uD`                | Toggle diagnostics                                         |
| `<Space>uT`                | Toggle treesitter                                          |
| `<Space>ug`                | Toggle indent guides                                       |
| `<Space>un`                | Show notification history                                  |
| `<Space>uN`                | Dismiss all notifications                                  |
| `Alt+Shift+L`              | Cycle line number modes: Both → Absolute → Relative → Both |


---

## 🖥️ Terminal


| Key              | Action                         |
| ---------------- | ------------------------------ |
| `<Space>tt`      | Toggle terminal                |
| `Ctrl + /`       | Toggle terminal (alternative)  |
| `<Esc><Esc>`     | Exit terminal mode             |
| `Ctrl + h/j/k/l` | Navigate windows from terminal |


---

## 📋 Clipboard & Yank


| Key             | Action                              |
| --------------- | ----------------------------------- |
| `<Space>y`      | Yank to system clipboard            |
| `<Space>Y`      | Yank line to system clipboard       |
| `p` (in visual) | Paste without yanking replaced text |


---

## ➕ Add Blank Lines


| Key        | Action               |
| ---------- | -------------------- |
| `]<Space>` | Add blank line below |
| `[<Space>` | Add blank line above |


---

## 📑 Tabs


| Key                 | Action       |
| ------------------- | ------------ |
| `<Space><Tab><Tab>` | New tab      |
| `<Space><Tab>]`     | Next tab     |
| `<Space><Tab>[`     | Previous tab |
| `<Space><Tab>x`     | Close tab    |
| `<Space><Tab>f`     | First tab    |
| `<Space><Tab>l`     | Last tab     |


---

## 🔎 Search & Scroll


| Key        | Action                                 |
| ---------- | -------------------------------------- |
| `Ctrl + d` | Scroll down (centered)                 |
| `Ctrl + u` | Scroll up (centered)                   |
| `n`        | Next search result (centered)          |
| `N`        | Previous search result (centered)      |
| `]]`       | Next reference (word under cursor)     |
| `[[`       | Previous reference (word under cursor) |


---

## 🧩 Bracket / Pair Navigation


| Key | Action                               |
| --- | ------------------------------------ |
| `%` | Jump to matching bracket/brace/paren |


---

## 🧱 Block / Indent Navigation

Navigate through code blocks using indent levels.


| Key  | Action                                |
| ---- | ------------------------------------- |
| `[i` | Jump to start of current indent block |
| `]i` | Jump to end of current indent block   |


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

