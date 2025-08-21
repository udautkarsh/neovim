return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { "folke/noice.nvim" },
  },
  opts = {
    defaults = {
      layout_config = {
        vertical = { width = 0.75 },
      },
      path_display = {
        filename_first = { reverse_directories = true },
      },
    },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("noice")

    -- dependencies
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    -- custom git branches picker
    vim.keymap.set("n", "<leader>gb", function()
      local output = vim.fn.systemlist("git branch -a --no-color")

      local branches = {}
      for _, line in ipairs(output) do
        -- remove marker (*) and extra spaces
        local branch = line:gsub("^%*?%s*", "")

        -- skip HEAD refs like "remotes/origin/HEAD -> origin/main"
        if not branch:match("->") and branch ~= "" then
          table.insert(branches, branch)
        end
      end

      pickers
        .new({}, {
          prompt_title = "Git Branches",
          finder = finders.new_table(branches),
          sorter = conf.generic_sorter({}),
          attach_mappings = function(_, map)
            map("i", "<CR>", function(prompt_bufnr)
              local selection = action_state.get_selected_entry().value
              actions.close(prompt_bufnr)

              if selection:match("^remotes/") then
                local b = selection:gsub("^remotes/origin/", "")
                vim.fn.system({ "git", "checkout", "-B", b, selection })
                print("Checked out remote branch as local: " .. b)
              else
                vim.fn.system({ "git", "checkout", selection })
                print("Switched to branch: " .. selection)
              end
            end)
            return true
          end,
        })
        :find()
    end, { desc = "List & checkout branches (local + remote, cleaned)" })
  end,
}



--[[
return {
  'nvim-telescope/telescope.nvim',
  lazy = true,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { "folke/noice.nvim" }, -- Ensure Noice is loaded before extension
  },
  opts = {
    defaults = {
      layout_config = {
        vertical = {
          width = 0.75
        }
      },
      path_display = {
        filename_first = {
          reverse_directories = true
        }
      },
    }
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("noice")
  end,
}
--]]