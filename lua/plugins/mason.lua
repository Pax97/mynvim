-- lua/plugins/mason.lua
-- Mason - Package manager cho LSP servers, DAP, linters, formatters
-- Chỉ lo việc cài đặt tools, config LSP nằm ở lspconfig.lua

return {
  "mason-org/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
  build = ":MasonUpdate",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },

  config = function()
    ---------------------------------------------------------------------------
    -- 1. MASON UI SETUP
    ---------------------------------------------------------------------------
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded",
      },
      -- Thư mục cài đặt (mặc định)
      -- install_root_dir = vim.fn.stdpath("data") .. "/mason",

      -- Log level
      log_level = vim.log.levels.INFO,
    })

    ---------------------------------------------------------------------------
    -- 2. MASON TOOL INSTALLER
    -- Tự động cài đặt các tools khi khởi động
    -- Dễ mở rộng: thêm tool mới vào đây
    ---------------------------------------------------------------------------
    require("mason-tool-installer").setup({
      ensure_installed = {
        -- Formatters
        "prettier",     -- JS/TS/HTML/CSS/JSON/YAML/Markdown
        "stylua",       -- Lua
        "black",        -- Python
        "isort",        -- Python imports
        "gofumpt",      -- Go
        "goimports",

        -- Linters
        "pylint",       -- Python
      },

      -- Tự động update tools
      auto_update = false,

      -- Chạy on VimEnter
      run_on_start = true,

      -- Delay trước khi bắt đầu cài đặt (ms)
      start_delay = 3000,
    })
  end,
}
