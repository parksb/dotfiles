return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    init = function()
      local ensure_installed = {
        "c",
        "bash",
        "comment",
        "cpp",
        "css",
        "diff",
        "dockerfile",
        "fish",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "html",
        "javascript",
        "json",
        "latex",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "scss",
        "sql",
        "rust",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      }

      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          -- Enable treesitter highlighting and disable regex syntax
          pcall(vim.treesitter.start)

          -- Enable treesitter-based indentation
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      local already_installed = require("nvim-treesitter.config").get_installed()
      local parsers_to_install = vim
        .iter(ensure_installed)
        :filter(function(parser)
          return not vim.tbl_contains(already_installed, parser)
        end)
        :totable()

      require("nvim-treesitter").install(parsers_to_install)
    end,
  },
}
