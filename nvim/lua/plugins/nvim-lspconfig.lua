return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
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
    local function opts(desc)
      return { noremap = true, silent = true, desc = desc }
    end

    local servers = {
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
      vtsls = {
        root_dir = function(_, callback)
          local deno_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
          local root_dir = vim.fs.root(0, { "tsconfig.json", "jsconfig.json", "package.json" })
          if root_dir and deno_dir == nil then
            callback(root_dir)
          end
        end,
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
      },
      denols = {
        root_dir = function(_, callback)
          local root_dir = vim.fs.root(0, { "deno.json", "deno.jsonc" })
          if root_dir then
            callback(root_dir)
          end
        end,
        root_markers = { "deno.json", "deno.jsonc" },
      },
      jsonls = {},
      marksman = {},
      pyright = {},
      yamlls = {},
    }

    for server, config in pairs(servers) do
      vim.lsp.config(server, config)
    end

    vim.keymap.set("n", "gd", function()
      Searcher.lsp_search("lsp_definitions", { reuse_win = true, theme = "dropdown" })
    end, opts("Go to definition"))

    vim.keymap.set("n", "gi", function()
      Searcher.lsp_search("lsp_implementations", { reuse_win = true, theme = "dropdown" })
    end, opts("Go to implementation"))

    vim.keymap.set("n", "gr", function()
      Searcher.lsp_search("lsp_references", { theme = "dropdown" })
    end, opts("Go to references"))

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "single" })
    end, opts("Show documentation"))

    vim.keymap.set("n", "X", vim.diagnostic.open_float, opts("Show diagnostics"))
    vim.keymap.set("n", "<LEADER>rn", vim.lsp.buf.rename, opts("Rename symbol"))
    vim.keymap.set("n", "<LEADER>ca", vim.lsp.buf.code_action, opts("Show code actions"))

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
    })
  end,
}
