return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    init = function()
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "● ",
        },
        inlay_hints = {
          enabled = true,
          exclude = { "vue" },
        },
        severity_sort = true,
      })
    end,
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "bashls",
          "clangd",
          "cssls",
          "css_variables",
          "dockerls",
          "html",
          "ts_ls",
          "jsonls",
          "marksman",
          "pyright",
          "yamlls",
        },
      })

      local function on_attach(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<LEADER>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, opts)
      end

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      local lspconfig = require("lspconfig")
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local settings = {}

          -- TODO: Move this to a separate module
          if server_name == "lua_ls" then
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                workspace = {
                  library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                  },
                },
              },
            }
          end

          lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = vim.deepcopy(capabilities),
            settings = settings,
          })
        end,
      })
    end,
  },
}
