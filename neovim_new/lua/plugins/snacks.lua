return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- ============================================
    -- ANIMATION
    -- ============================================
    animate = {
      enabled = true,
      duration = 20,
      easing = "linear",
    },

    -- ============================================
    -- BIGFILE - Disable features for large files
    -- ============================================
    bigfile = {
      enabled = true,
      notify = true,
      size = 1.5 * 1024 * 1024, -- 1.5MB
    },

    -- ============================================
    -- BUFDELETE - Delete buffers without messing layout
    -- ============================================
    bufdelete = { enabled = true },

    -- ============================================
    -- DASHBOARD - Start screen
    -- ============================================
    dashboard = {
      enabled = true,
      width = 60,
      row = nil,
      col = nil,
      pane_gap = 4,
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
 ██╗   ██╗██████╗  █████╗ ██╗   ██╗
 ██║   ██║██╔══██╗██╔══██╗╚██╗ ██╔╝
 ██║   ██║██║  ██║███████║ ╚████╔╝
 ██║   ██║██║  ██║██╔══██║  ╚██╔╝
 ╚██████╔╝██████╔╝██║  ██║   ██║
  ╚═════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝

 ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
 ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
 ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
 ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
 ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
 ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        {
          pane = 2,
          section = "recent_files",
          title = "Recent Files",
          indent = 2,
          padding = 1,
          limit = 10,
        },
        {
          pane = 2,
          section = "projects",
          title = "Recent Projects",
          indent = 2,
          padding = 1,
          limit = 10,
          focus = true,  -- Set cursor here on open
        },
        { section = "startup" },
      },
    },

    -- ============================================
    -- DEBUG - Debug utilities
    -- ============================================
    debug = { enabled = true },

    -- ============================================
    -- DIM - Dim inactive code/windows
    -- ============================================
    dim = {
      enabled = true,
      animate = {
        enabled = true,
        duration = {
          step = 20,
          total = 300,
        },
      },
    },

    -- ============================================
    -- EXPLORER - File explorer (replaces nvim-tree)
    -- ============================================
    explorer = {
      enabled = true,
      replace_netrw = true,
      follow_file = true,  -- Follow current file
      -- Keep explorer open when selecting files
      win = {
        wo = {},
        bo = {},
        style = "explorer",
      },
      list = {
        keys = {
          -- Open file but keep explorer open (use 'o' or Enter)
          ["<CR>"] = { "edit", close = false },
          ["o"] = { "edit", close = false },
          -- Use 'O' to open and close explorer
          ["O"] = { "edit", close = true },
        },
      },
    },

    -- ============================================
    -- GIT - Git utilities
    -- ============================================
    git = { enabled = true },

    -- ============================================
    -- GITBROWSE - Open file in GitHub/GitLab
    -- ============================================
    gitbrowse = {
      enabled = true,
      notify = true,
    },

    -- ============================================
    -- IMAGE - Image support in terminal
    -- ============================================
    image = { enabled = true },

    -- ============================================
    -- INDENT - Indent guides (replaces indent-blankline)
    -- ============================================
    indent = {
      enabled = true,
      indent = {
        char = "│",
        only_scope = false,
        only_current = false,
      },
      animate = {
        enabled = true,
        duration = {
          step = 20,
          total = 200,
        },
      },
      scope = {
        enabled = true,
        char = "│",
        underline = false,
      },
      chunk = {
        enabled = true,
        char = {
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
    },

    -- ============================================
    -- INPUT - Better vim.ui.input
    -- ============================================
    input = { enabled = true },

    -- ============================================
    -- LAZYGIT - Lazygit integration
    -- ============================================
    lazygit = { enabled = true },

    -- ============================================
    -- NOTIFIER - Notifications (replaces noice partially)
    -- ============================================
    notifier = {
      enabled = true,
      timeout = 3000,
      style = "compact",
      top_down = true,
    },

    -- ============================================
    -- PICKER - Fuzzy finder (replaces telescope)
    -- ============================================
    picker = {
      enabled = true,
      sources = {},
      layout = {
        cycle = true,
        preset = "default",
      },
      formatters = {
        file = {
          filename_first = true,
        },
      },
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          },
        },
      },
    },

    -- ============================================
    -- PROFILER - Performance profiling
    -- ============================================
    profiler = { enabled = true },

    -- ============================================
    -- QUICKFILE - Quick file loading at startup
    -- ============================================
    quickfile = { enabled = true },

    -- ============================================
    -- RENAME - LSP rename with preview
    -- ============================================
    rename = { enabled = true },

    -- ============================================
    -- SCOPE - Scope detection and text objects
    -- ============================================
    scope = { enabled = true },

    -- ============================================
    -- SCRATCH - Scratch buffers
    -- ============================================
    scratch = { enabled = true },

    -- ============================================
    -- SCROLL - Smooth scrolling
    -- ============================================
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 15, total = 150 },
        easing = "linear",
      },
    },

    -- ============================================
    -- STATUSCOLUMN - Custom statuscolumn
    -- ============================================
    statuscolumn = {
      enabled = true,
      left = { "mark", "sign" },
      right = { "fold", "git" },
      folds = {
        open = false,
        git_hl = false,
      },
      git = {
        patterns = { "GitSign", "MiniDiffSign" },
      },
      refresh = 50,
    },

    -- ============================================
    -- TERMINAL - Terminal integration
    -- ============================================
    terminal = { enabled = true },

    -- ============================================
    -- TOGGLE - Toggle options/features
    -- ============================================
    toggle = { enabled = true },

    -- ============================================
    -- WIN - Window utilities
    -- ============================================
    win = { enabled = true },

    -- ============================================
    -- WORDS - Jump between references
    -- ============================================
    words = {
      enabled = true,
      debounce = 200,
    },

    -- ============================================
    -- ZEN - Zen mode (replaces vim-maximizer)
    -- ============================================
    zen = {
      enabled = true,
      toggles = {
        dim = true,
        git_signs = false,
        diagnostics = false,
      },
      show = {
        statusline = false,
        tabline = false,
      },
      win = { style = "zen" },
      zoom = {
        toggles = {},
        show = { statusline = true, tabline = true },
        win = {
          backdrop = false,
          width = 0,
        },
      },
    },

    -- ============================================
    -- STYLES - Custom window styles
    -- ============================================
    styles = {
      notification = {
        wo = { wrap = true },
      },
      explorer = {
        width = 25,  -- Explorer width (change this to adjust width)
      },
    },
  },

  -- ============================================
  -- KEYMAPS
  -- ============================================
  keys = {
    -- Dashboard
    { "<leader>;", function() Snacks.dashboard() end, desc = "Dashboard" },

    -- Explorer (toggle) - always opens at initial path passed to nvim
    { "<leader>e", function()
      Snacks.explorer({ cwd = vim.g.project_root })
    end, desc = "Toggle Explorer" },

    -- Picker (Fuzzy Finder)
    { "<leader>ff", function() Snacks.picker.files({ cwd = vim.g.project_root }) end, desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.grep({ cwd = vim.g.project_root }) end, desc = "Grep" },
    { "<leader>fw", function() Snacks.picker.grep_word({ cwd = vim.g.project_root }) end, desc = "Grep Word", mode = { "n", "x" } },
    { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent Files" },
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config Files" },
    { "<leader>fh", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>fk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>fm", function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fs", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>ft", function() Snacks.picker.todo_comments() end, desc = "Todo Comments" },
    { "<leader>/", function() Snacks.picker.grep_buffers() end, desc = "Grep Buffers" },
    { "<leader><space>", function() Snacks.picker.smart({ cwd = vim.g.project_root }) end, desc = "Smart Picker" },

    -- Git
    { "<leader>gg", function() Snacks.lazygit({ cwd = Snacks.git.get_root() }) end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.picker.git_log({ cwd = Snacks.git.get_root() }) end, desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log({ file = vim.fn.expand("%:p"), cwd = Snacks.git.get_root() }) end, desc = "Git Log File" },
    { "<leader>gbl", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gs", function() Snacks.picker.git_status({ cwd = Snacks.git.get_root() }) end, desc = "Git Status" },
    { "<leader>gc", function() Snacks.picker.git_log({ cwd = Snacks.git.get_root() }) end, desc = "Git Commits" },
    { "<leader>gd", function() Snacks.picker.git_diff({ cwd = Snacks.git.get_root() }) end, desc = "Git Diff" },
    { "<leader>gb", function()
      -- Local branches only
      local root = Snacks.git.get_root()
      vim.system({ "git", "-C", root, "branch", "--format=%(refname:short)" }, { text = true }, function(obj)
        vim.schedule(function()
          local branches = vim.split(obj.stdout or "", "\n", { trimempty = true })
          vim.ui.select(branches, { prompt = "Switch to branch (local):" }, function(choice)
            if choice then
              vim.system({ "git", "-C", root, "checkout", choice }, { text = true }, function(res)
                vim.schedule(function()
                  if res.code == 0 then
                    vim.cmd("checktime")
                    vim.cmd("edit!")
                    vim.notify("✓ Switched to: " .. choice, vim.log.levels.INFO)
                  else
                    vim.notify("✗ Failed: " .. (res.stderr or ""), vim.log.levels.ERROR)
                  end
                end)
              end)
            end
          end)
        end)
      end)
    end, desc = "Git Branches (Local)" },
    { "<leader>gbb", function()
      -- All branches (local + remote) with remotes/ prefix
      local root = Snacks.git.get_root()
      vim.system({ "git", "-C", root, "branch", "-a" }, { text = true }, function(obj)
        vim.schedule(function()
          local lines = vim.split(obj.stdout or "", "\n", { trimempty = true })
          local branches = {}
          for _, line in ipairs(lines) do
            -- Remove leading * and spaces
            local branch = line:gsub("^%s*%*?%s*", "")
            -- Skip HEAD pointer
            if not branch:match("HEAD") then
              table.insert(branches, branch)
            end
          end

          vim.ui.select(branches, { prompt = "Switch to branch (all):" }, function(choice)
            if choice then
              -- Handle remote branches: remotes/origin/feature -> feature
              local branch = choice:gsub("^remotes/[^/]+/", "")
              vim.system({ "git", "-C", root, "checkout", branch }, { text = true }, function(res)
                vim.schedule(function()
                  if res.code == 0 then
                    vim.cmd("checktime")
                    vim.cmd("edit!")
                    vim.notify("✓ Switched to: " .. branch, vim.log.levels.INFO)
                  else
                    vim.notify("✗ Failed: " .. (res.stderr or ""), vim.log.levels.ERROR)
                  end
                end)
              end)
            end
          end)
        end)
      end)
    end, desc = "Git Branches (All)" },
    { "<leader>gp", function()
      -- Background git pull with status indicator
      local root = Snacks.git.get_root()
      _G.git_sync_status = { state = "syncing", command = "pull", error = "", start_time = vim.loop.hrtime() }

      vim.system({ "git", "-C", root, "pull" }, { text = true }, function(result)
        vim.schedule(function()
          if result.code == 0 then
            -- Success
            _G.git_sync_status = { state = "success", command = "pull", error = "" }
            vim.notify("✓ Git pull completed", vim.log.levels.INFO)
            vim.cmd("checktime")  -- Reload changed files

            -- Reset to idle after 2 seconds
            vim.defer_fn(function()
              _G.git_sync_status = { state = "idle", command = "", error = "" }
            end, 2000)
          else
            -- Error - show terminal with output
            _G.git_sync_status = { state = "error", command = "pull", error = result.stderr or result.stdout or "Unknown error" }
            vim.notify("✗ Git pull failed - check terminal", vim.log.levels.ERROR)

            Snacks.terminal.open("git pull", {
              cwd = root,
              interactive = false,
              win = {
                position = "bottom",
                height = 0.2,
                relative = "win"
              }
            })
          end
        end)
      end)
    end, desc = "Git Pull" },
    { "<leader>gP", function()
      -- Background git push with status indicator
      local root = Snacks.git.get_root()
      _G.git_sync_status = { state = "syncing", command = "push", error = "", start_time = vim.loop.hrtime() }

      vim.system({ "git", "-C", root, "push" }, { text = true }, function(result)
        vim.schedule(function()
          if result.code == 0 then
            -- Success
            _G.git_sync_status = { state = "success", command = "push", error = "" }
            vim.notify("✓ Git push completed", vim.log.levels.INFO)

            -- Reset to idle after 2 seconds
            vim.defer_fn(function()
              _G.git_sync_status = { state = "idle", command = "", error = "" }
            end, 2000)
          else
            -- Error - show terminal with output
            _G.git_sync_status = { state = "error", command = "push", error = result.stderr or result.stdout or "Unknown error" }
            vim.notify("✗ Git push failed - check terminal", vim.log.levels.ERROR)

            Snacks.terminal.open("git push", {
              cwd = root,
              interactive = false,
              win = {
                position = "bottom",
                height = 0.2,
                relative = "win"
              }
            })
          end
        end)
      end)
    end, desc = "Git Push" },
    { "<leader>gf", function()
      -- Background git fetch with status indicator
      local root = Snacks.git.get_root()
      _G.git_sync_status = { state = "syncing", command = "fetch", error = "", start_time = vim.loop.hrtime() }

      vim.system({ "git", "-C", root, "fetch", "--all" }, { text = true }, function(result)
        vim.schedule(function()
          if result.code == 0 then
            -- Success
            _G.git_sync_status = { state = "success", command = "fetch", error = "" }
            vim.notify("✓ Git fetch completed", vim.log.levels.INFO)

            -- Reset to idle after 2 seconds
            vim.defer_fn(function()
              _G.git_sync_status = { state = "idle", command = "", error = "" }
            end, 2000)
          else
            -- Error - show terminal with output
            _G.git_sync_status = { state = "error", command = "fetch", error = result.stderr or result.stdout or "Unknown error" }
            vim.notify("✗ Git fetch failed - check terminal", vim.log.levels.ERROR)

            Snacks.terminal.open("git fetch --all", {
              cwd = root,
              interactive = false,
              win = {
                position = "bottom",
                height = 0.2,
                relative = "win"
              }
            })
          end
        end)
      end)
    end, desc = "Git Fetch" },

    -- Buffers
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    { "<leader>ba", function() Snacks.bufdelete.all() end, desc = "Delete All Buffers" },
    { "<leader>bl", function() Snacks.picker.buffers() end, desc = "List Buffers" },
    { "<A-b>", function() Snacks.picker.buffers() end, desc = "List Buffers" },

    -- Notifications
    { "<leader>un", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>uN", function() Snacks.notifier.hide() end, desc = "Dismiss Notifications" },

    -- Terminal
    { "<leader>tt", function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<c-/>", function() Snacks.terminal() end, desc = "Toggle Terminal" },

    -- Scratch
    { "<leader>.", function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },

    -- Zen Mode
    { "<leader>z", function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>Z", function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },

    -- Words (jump between references)
    { "]]", function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[", function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },

    -- Dim
    { "<leader>ud", function() Snacks.dim() end, desc = "Toggle Dim" },

    -- Toggle options
    { "<leader>uw", function() Snacks.toggle.option("wrap"):toggle() end, desc = "Toggle Wrap" },
    { "<leader>us", function() Snacks.toggle.option("spell"):toggle() end, desc = "Toggle Spelling" },
    { "<leader>ui", function() Snacks.toggle.inlay_hints():toggle() end, desc = "Toggle Inlay Hints" },
    { "<leader>uD", function() Snacks.toggle.diagnostics():toggle() end, desc = "Toggle Diagnostics" },

    -- Rename
    { "<leader>rn", function() Snacks.rename.rename_file() end, desc = "Rename File" },

    -- Profiler
    { "<leader>pp", function() Snacks.profiler.toggle() end, desc = "Toggle Profiler" },
  },

  -- ============================================
  -- INITIALIZATION
  -- ============================================
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup debug functions
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd

        -- Create toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.diagnostics():map("<leader>uD")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>ud")
      end,
    })
  end,
}
