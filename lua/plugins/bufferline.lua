return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("bufferline").setup({
      options = {
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer", -- Tiêu đề hiển thị trên vùng trống của sidebar
            text_align = "left", -- Căn lề cho text
            separator = true, -- Tạo đường kẻ dọc tách biệt với vùng buffer (nếu theme hỗ trợ)
          },
        },
        -- Các cấu hình khác của bạn...
      },
    })
  end,
}
