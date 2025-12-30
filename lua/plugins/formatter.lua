-- lua/plugins/formatter.lua
-- Conform.nvim - Code formatter
-- Neovim 0.11+ compatible

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "ConformInfo" },

  -- Keymaps
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
      end,
      mode = { "n", "v" },
      desc = "Format file or range",
    },
  },

  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    ---------------------------------------------------------------------------
    -- FORMATTERS BY FILETYPE
    -- Dễ mở rộng: thêm filetype mới vào đây
    ---------------------------------------------------------------------------
    formatters_by_ft = {
      -- JavaScript / TypeScript
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },

      -- Web
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      svelte = { "prettier" },

      -- Data formats
      json = { "prettier" },
      yaml = { "prettier" },
      markdown = { "prettier" },
      graphql = { "prettier" },

      -- Lua
      lua = { "stylua" },

      -- Python
      python = { "isort", "black" },

      -- Go
      go = { "gofumpt", "goimports" },

      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },

      -------------------------------------------------------------------------
      -- THÊM FILETYPE MỚI Ở ĐÂY
      -- Ví dụ:
      -- rust = { "rustfmt" },
      -- c = { "clang_format" },
      -------------------------------------------------------------------------

      -- Fallback cho tất cả filetypes
      ["_"] = { "trim_whitespace" },
    },

    ---------------------------------------------------------------------------
    -- FORMAT ON SAVE
    ---------------------------------------------------------------------------
    format_on_save = {
      -- Sử dụng LSP nếu không có formatter riêng
      lsp_fallback = true,
      -- Không format async để đảm bảo đúng thứ tự
      async = false,
      -- Timeout
      timeout_ms = 500,
    },

    ---------------------------------------------------------------------------
    -- FORMATTER OPTIONS
    ---------------------------------------------------------------------------
    formatters = {
      -- Prettier với config file nếu có
      prettier = {
        prepend_args = { "--prose-wrap", "always" },
      },
      -- Stylua
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      -- Black
      black = {
        prepend_args = { "--line-length", "88" },
      },
    },
  },
}
