-- Whatever dateDMY
local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- NeoTree
map("n", "<leader>r", "<CMD>Neotree toggle<CR>")
map("n", "<leader>e", "<CMD>Neotree focus<CR>")
