-- lua/plugins/lspconfig.lua
-- LSP Configuration - Modular và dễ mở rộng
-- Neovim 0.11+ compatible

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile", "VimEnter" },
  dependencies = {
    "mason-org/mason.nvim",
    {
      "mason-org/mason-lspconfig.nvim",
    },
  },

  config = function()
    ---------------------------------------------------------------------------
    -- 1. CAPABILITIES - Tích hợp với completion plugin
    ---------------------------------------------------------------------------
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- Tích hợp với blink.cmp nếu có
    local ok_blink, blink = pcall(require, "blink.cmp")
    if ok_blink then
      capabilities = blink.get_lsp_capabilities(capabilities)
    end

    ---------------------------------------------------------------------------
    -- 2. ON_ATTACH - Keymaps và settings khi LSP attach vào buffer
    ---------------------------------------------------------------------------
    local on_attach = function(client, bufnr)
      -- Helper để set keymap cho buffer
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc })
      end

      -- Navigation
      -- map("n", "gd", vim.lsp.buf.definition, "Goto Definition")
      -- map("n", "gD", vim.lsp.buf.declaration, "Goto Declaration")
      -- map("n", "gr", vim.lsp.buf.references, "Goto References")
      -- map("n", "gi", vim.lsp.buf.implementation, "Goto Implementation")
      -- map("n", "gt", vim.lsp.buf.type_definition, "Goto Type Definition")

      -- Hover & Signature
      -- map("n", "<leader>k", vim.lsp.buf.hover, "Hover Documentation")
      -- map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

      -- Actions
      -- map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
      -- map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

      -- Diagnostics
      map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
      map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
      map("n", "<leader>d", vim.diagnostic.open_float, "Line Diagnostics")
      map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics to Loclist")

      -- Workspace
      -- map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
      -- map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
      -- map("n", "<leader>wl", function()
      --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      -- end, "List Workspace Folders")
    end

    ---------------------------------------------------------------------------
    -- 3. DIAGNOSTICS
    ---------------------------------------------------------------------------
    vim.diagnostic.config({
      virtual_text = false,
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "󰌵",
        },
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })

    ---------------------------------------------------------------------------
    -- 4. LSP UI - Border cho hover và signature help
    ---------------------------------------------------------------------------
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
    })

    ---------------------------------------------------------------------------
    -- 5. SERVER CONFIGURATIONS
    -- Dễ mở rộng: chỉ cần thêm entry mới vào table này
    -- Mỗi server có thể có settings riêng hoặc dùng default
    ---------------------------------------------------------------------------
    local servers = {
      -- Lua
      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      },

      -- TypeScript/JavaScript
      ts_ls = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },

      -- Python
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      },

      -- CSS
      cssls = {},

      -- HTML
      html = {},

      -- JSON
      jsonls = {
        settings = {
          json = {
            validate = { enable = true },
          },
        },
      },

      -- ESLint
      eslint = {
        on_attach = function(client, bufnr)
          -- Gọi on_attach chung trước
          on_attach(client, bufnr)
          -- Auto fix on save cho ESLint
        end,
      },

      -- Tailwind CSS
      tailwindcss = {},

      -- Go
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      },

      ---------------------------------------------------------------------------
      -- THÊM SERVER MỚI Ở ĐÂY
      -- Ví dụ:
      -- rust_analyzer = {},
      -- clangd = {},
      ---------------------------------------------------------------------------
    }

    ---------------------------------------------------------------------------
    -- 6. SETUP MASON-LSPCONFIG
    ---------------------------------------------------------------------------
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
      automatic_installation = true,
    })

    ---------------------------------------------------------------------------
    -- 7. SETUP TẤT CẢ LSP SERVERS
    ---------------------------------------------------------------------------
    for server_name, server_opts in pairs(servers) do
      -- Merge default config với server-specific config
      local opts = vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        capabilities = capabilities,
      }, server_opts)
      vim.lsp.config(server_name, opts)
      vim.lsp.enable(server_name)
    end

    ---------------------------------------------------------------------------
    -- DEBUG: Uncomment để xem LSP nào đang chạy
    -- vim.api.nvim_create_autocmd("LspAttach", {
    --   callback = function(args)
    --     local client = vim.lsp.get_client_by_id(args.data.client_id)
    --     print("LSP attached: " .. client.name)
    --   end,
    -- })
    ---------------------------------------------------------------------------
  end,
}
