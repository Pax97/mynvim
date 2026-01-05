return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Hàm hỗ trợ: Lấy danh sách các LSP đang hoạt động
    local function lsp_status()
      local clients = vim.lsp.get_clients({ bufnr = 0 })
      if #clients == 0 then
        return "No LSP"
      end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return "󰒋 " .. table.concat(names, ", ")
    end

    -- Hàm hỗ trợ: Lấy danh sách Formatter (Sử dụng conform.nvim)
    local function formatter_status()
      local ok, conform = pcall(require, "conform")
      if not ok then
        return ""
      end
      local formatters = conform.list_formatters(0)
      if #formatters == 0 then
        return ""
      end
      local names = {}
      for _, formatter in ipairs(formatters) do
        table.insert(names, formatter.name)
      end
      return "󰉼 " .. table.concat(names, ", ")
    end

    require("lualine").setup({
      options = {
        theme = "auto", -- Bạn có thể đổi thành theme bạn thích
        globalstatus = true,
        disabled_filetypes = {
          statusline = { "neo-tree" },
        },
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1, -- 0: Just name, 1: Relative path, 2: Absolute path
          },
          {
            "filesize",
            cond = function()
              return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
          },
        },
        lualine_x = {
          {
            formatter_status,
            color = { fg = "#a6e22e", gui = "bold" },
          },
          {
            lsp_status,
            color = { fg = "#61afef", gui = "bold" },
          },
          "encoding",
          "fileformat",
          "filetype",
        },
      },
      extensions = { "neo-tree", "lazy" },
    })
  end,
}
