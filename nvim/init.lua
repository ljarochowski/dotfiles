require("theprimeagen")
require("config.lazy")

-- ============================================
-- LOCAL OVERRIDES (not in repo)
-- ============================================
-- Use ~/.config/nvim/lua/local.lua for machine-specific config
-- This file is NOT tracked by git
pcall(require, 'local')
