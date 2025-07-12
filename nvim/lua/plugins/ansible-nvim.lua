-- ansible-vim plugin configuration
-- This plugin provides syntax highlighting, indentation, and other features for Ansible files in Vim.

return {
  -- Syntax highlighting and filetype support
  {
    "pearofducks/ansible-vim",
    lazy = false,
    ft = { "yaml.ansible", "ansible" },
  },

  -- Runtime execution of Ansible playbooks/roles
  {
    "mfussenegger/nvim-ansible",
    ft = { "yaml.ansible", "yaml" },
    keys = {
      {
        "<leader>ta",
        function()
          require("ansible").run()
        end,
        desc = "Run Ansible Playbook/Role",
        silent = true,
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "yaml", "yaml.ansible" },
        callback = function()
          -- Set proper comment string and ensure correct filetype
          vim.opt_local.commentstring = "# %s"
          vim.opt_local.filetype = "yaml.ansible"
        end,
      })
    end,
  },
}
