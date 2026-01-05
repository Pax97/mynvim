return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false, -- neo-tree will lazily load itself
    ---@module 'neo-tree'
    ---@type neotree.Config
    opts = {
      default_component_configs = {
        git_status = {
          symbols = {
            -- Change type
            added = "✚",
            deleted = "✖",
            modified = "",
            renamed = "󰁕",
            -- Status type
            untracked = "U",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
          -- Trỏ màu sắc tương ứng
          highlights = {
            added = "NeoTreeGitAdded",
            modified = "NeoTreeGitModified",
            deleted = "NeoTreeGitDeleted",
            untracked = "NeoTreeGitUntracked",
            ignored = "NeoTreeGitIgnored",
            unstaged = "NeoTreeGitUnstaged",
            staged = "NeoTreeGitStaged",
            conflict = "NeoTreeGitConflict",
          },
        },
      }, -- options go here
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        use_libuv_file_watcher = true,
      },
    },
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}
