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
        prefix = "",
        severity = vim.diagnostic.severity.ERROR,
      },
      float = {
        border = "single",
      },
      signs = false,
      inlay_hints = {
        enabled = true,
      },
      severity_sort = true,
    })
  end,
  opts = {
    capabilities = {
      general = {
        -- blink.cmp CJK 입력 문제: https://github.com/Saghen/blink.cmp/issues/936
        positionEncodings = { "utf-8" },
      },
    },
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local lspconfig = require("lspconfig")

    local ensure_installed = {
      lua_ls = {
        settings = require("plugins/langs/lua").lspconfig,
      },
      rust_analyzer = {},
      bashls = {},
      clangd = {},
      cssls = {},
      css_variables = {},
      dockerls = {},
      html = {},
      ts_ls = {
        root_dir = lspconfig.util.root_pattern("package.json"),
        single_file_support = false,
      },
      denols = {
        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      },
      jsonls = {},
      marksman = {},
      pyright = {},
      yamlls = {},
    }

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(ensure_installed),
    })

    require("mason-lspconfig").setup_handlers({
      function(server)
        lspconfig[server].setup({
          capabilities = vim.deepcopy(capabilities),

          settings = ensure_installed[server].settings,
          root_dir = ensure_installed[server].root_dir,
          single_file_support = ensure_installed[server].single_file_support,

          on_attach = function(_, buf)
            local opts = function(desc)
              return { noremap = true, silent = true, buffer = buf, desc = desc }
            end
            vim.keymap.set(
              "n",
              "gd",
              "<CMD>Telescope lsp_definitions reuse_win=true theme=dropdown<CR>",
              opts("Go to definition")
            )
            vim.keymap.set(
              "n",
              "gi",
              "<CMD>Telescope lsp_implementations reuse_win=true theme=dropdown<CR>",
              opts("Go to implementation")
            )
            vim.keymap.set("n", "gr", "<CMD>Telescope lsp_references theme=dropdown<CR>", opts("Go to references"))
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Show documentation"))
            vim.keymap.set("n", "X", vim.diagnostic.open_float, opts("Show diagnostics"))
            vim.keymap.set("n", "<LEADER>rn", vim.lsp.buf.rename, opts("Rename symbol"))
            vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, opts("Show code actions"))
          end,
        })
      end,
    })
  end,
}
