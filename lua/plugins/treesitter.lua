-- lua/plugins/treesitter.lua 
return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    branch = "master",
    build = ":TSUpdate",

    -- để lazy.nvim tự require module đúng chuẩn như AstroNvim
    main = "nvim-treesitter.configs",
    -- Auto tag plugin
    dependencies = {
      "windwp/nvim-ts-autotag",
    },

    cmd = {
      "TSBufDisable",
      "TSBufEnable",
      "TSBufToggle",
      "TSDisable",
      "TSEnable",
      "TSToggle",
      "TSInstall",
      "TSInstallInfo",
      "TSInstallSync",
      "TSModuleInfo",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
    },

    -- chống trường hợp plugin khác require treesitter quá sớm
    init = function(plugin)
      require("lazy.core.loader").add_to_rtp(plugin)
      pcall(require, "nvim-treesitter.query_predicates")
    end,

    opts = {
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },

      autotag = { enable = true },

      auto_install = true,

      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "bash",
        "lua",
        "vim",
        "vimdoc",
        "dockerfile",
        "gitignore",
        "c",
        "go",
        "python",
      },

      incremental_selection = {
        enable = true,
        -- bạn tự thêm keymaps nếu cần
      },
    },
    -- vì đã có main + opts, chỉ cần config=true là lazy.nvim tự setup
    config = true,
  },

  -- Rainbow thay cho config "rainbow" cũ (nên dùng rainbow-delimiters)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local rd = require("rainbow-delimiters")
      vim.g.rainbow_delimiters = {
        strategy = {
          [""] = rd.strategy["global"],
          vim = rd.strategy["local"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
        blacklist = { "html" },
      }
    end,
  },
}

