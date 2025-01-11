return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "nvim-telescope/telescope.nvim",
  },
  init = function()
    vim.diagnostic.config({
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = "🁢",
      },
      signs = false,
      inlay_hints = {
        enabled = true,
      },
      severity_sort = true,
    })
  end,
  config = function()
    local ensure_installed = {
      lua_ls = require("plugins/langs/lua").lspconfig,
      rust_analyzer = {},
      bashls = {},
      clangd = {},
      cssls = {},
      css_variables = {},
      dockerls = {},
      html = {},
      ts_ls = {},
      eslint = {},
      jsonls = {},
      marksman = {},
      pyright = {},
      yamlls = {},
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(ensure_installed),
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspconfig = require("lspconfig")
    require("mason-lspconfig").setup_handlers({
      function(server)
        lspconfig[server].setup({
          on_attach = function(_, buf)
            local opts = { noremap = true, silent = true, buffer = buf }
            vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions reuse_win=true theme=dropdown<CR>", opts)
            vim.keymap.set("n", "gi", "<CMD>Telescope lsp_implementations reuse_win=true theme=dropdown<CR>", opts)
            vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references theme=dropdown<CR>", opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<LEADER>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, opts)
          end,
          capabilities = vim.deepcopy(capabilities),
          settings = ensure_installed[server],
        })
      end,
    })
  end,
}
