-- lua/plugins/completion.lua
-- Code Completion với blink.cmp
-- Neovim 0.11+ compatible

return {
  "saghen/blink.cmp",
  -- Lazy load khi vào insert mode hoặc command mode
  event = { "InsertEnter" },
  -- Sử dụng prebuilt binaries thay vì build từ source
  version = "1.*",

  dependencies = {
    -- Snippet engine
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        -- Snippet collection
        "rafamadriz/friendly-snippets",
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    ---------------------------------------------------------------------------
    -- KEYMAP - Phím tắt cho completion
    ---------------------------------------------------------------------------
    keymap = {
      preset = "default",
      -- Bạn có thể customize thêm:
      -- ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      -- ["<C-e>"] = { "hide" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },

    ---------------------------------------------------------------------------
    -- APPEARANCE - Giao diện completion menu
    ---------------------------------------------------------------------------
    appearance = {
      highlight_ns = vim.api.nvim_create_namespace('blink_cmp'),
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- Will be removed in a future release
      use_nvim_cmp_as_default = false,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
      kind_icons = {
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',

        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',

        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',

        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',

        Keyword = '󰻾',
        Constant = '󰏿',

        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      },
    },
    ---------------------------------------------------------------------------
    -- COMPLETION - Cấu hình chính
    ---------------------------------------------------------------------------
    cmdline = {
      enabled = false,
    },
    completion = {
      -- Menu hiển thị
      menu = {
        border = "rounded",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },

      -- Documentation popup
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "rounded",
        },
      },

      -- Ghost text (preview completion inline)
      ghost_text = {
        enabled = true,
      },

      -- Khi accept completion
      accept = {
        auto_brackets = {
          enabled = true,
        },
      },

      -- Trigger
      trigger = {
        show_on_insert_on_trigger_character = true,
      },

      -- List behavior
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
    },

    ---------------------------------------------------------------------------
    -- SOURCES - Nguồn completion
    -- Dễ mở rộng: thêm source mới vào đây
    ---------------------------------------------------------------------------
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },

      -- Cấu hình cho từng source
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
          score_offset = 100, -- Ưu tiên cao nhất
        },
        path = {
          name = "Path",
          module = "blink.cmp.sources.path",
          score_offset = 50,
        },
        snippets = {
          name = "Snippets",
          module = "blink.cmp.sources.snippets",
          score_offset = 80,
        },
        buffer = {
          name = "Buffer",
          module = "blink.cmp.sources.buffer",
          score_offset = 30,
          -- Chỉ suggest từ buffer hiện tại
          opts = {
            get_bufnrs = function()
              return { vim.api.nvim_get_current_buf() }
            end,
          },
        },
      },
    },

    ---------------------------------------------------------------------------
    -- SNIPPETS - Tích hợp LuaSnip
    ---------------------------------------------------------------------------
    snippets = {
      preset = "luasnip",
    },

    ---------------------------------------------------------------------------
    -- SIGNATURE - Signature help
    ---------------------------------------------------------------------------
    signature = {
      enabled = true,
      window = {
        border = "rounded",
      },
    },

    ---------------------------------------------------------------------------
    -- FUZZY - Thuật toán matching
    ---------------------------------------------------------------------------
    fuzzy = {
      frecency = {
        enabled = true,
      },
      use_proximity = true,
    },
  },

  ---------------------------------------------------------------------------
  -- CONFIG - Xử lý thêm sau khi setup
  ---------------------------------------------------------------------------
  config = function(_, opts)
    local blink = require("blink.cmp")
    blink.setup(opts)

    -- Tích hợp với autopairs (nếu có)
    local ok_autopairs, autopairs = pcall(require, "nvim-autopairs")
    if ok_autopairs then
      local ok_cmp_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if ok_cmp_autopairs then
        -- blink.cmp tự động xử lý brackets, nhưng autopairs vẫn hoạt động
        -- cho các trường hợp khác
      end
    end
  end,
}
