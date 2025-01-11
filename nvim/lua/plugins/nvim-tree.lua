return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<LEADER>tt", ":NvimTreeToggle<CR>" },
    { "<LEADER>tc", ":NvimTreeFindFile<CR>" },
    { "<LEADER>tf", ":NvimTreeFocus<CR>" },
  },
  init = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  opts = {
    renderer = {
      highlight_git = true,
      add_trailing = true,
      indent_markers = {
        enable = true,
      },
      icons = {
        git_placement = "after",
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    git = {
      ignore = false,
    },
    trash = {
      cmd = "trash",
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      api.config.mappings.default_on_attach(bufnr) -- default mappings

      vim.keymap.set("n", "<C-CR>", api.tree.change_root_to_node, opts("CD"))
      vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    end,
  },
}
