-- ~/nvim/init.lua
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/lua/config/settings.vim')
-- Lua config
require("config.maps")
require("config.lazy")

