-- ansible-vim plugin configuration
-- This plugin provides syntax highlighting, indentation, and other features for Ansible files in Vim.

return {
    "pearofducks/ansible-vim",
    lazy = false,
    ft = { "yaml.ansible", "ansible" }, -- Only load for Ansible/YAML files
  }
