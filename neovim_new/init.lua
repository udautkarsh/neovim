-- ============================================
--  NEOVIM CONFIGURATION
-- ============================================
--  Author: Uday
--  Structure:
--    lua/config/   - Core configuration
--    lua/plugins/  - Plugin specifications
--    lua/utils/    - Helper functions
-- ============================================

-- Load core configuration first
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- Bootstrap and setup lazy.nvim
require("config.lazy")
