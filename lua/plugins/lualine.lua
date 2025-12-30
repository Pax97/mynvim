return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("lualine").setup({
      options = {
        disabled_filetypes = {
          statusline = { "neo-tree" }, -- Ẩn hoàn toàn statusline tại neo-tree nếu bạn muốn tối giản
        },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
          {
            -- Hiển thị kích thước file (hữu ích khi check log hoặc binary)
            "filesize",
            cond = function()
              return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
            end,
          },
        },
      },
      extensions = { "neo-tree" }, -- Tự động tối ưu hóa hiển thị cho Neo-tree
    })
  end,
}
