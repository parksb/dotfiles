return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<LEADER>tt", ":NvimTreeToggle<CR>", desc = "Toggle file tree" },
    { "<LEADER>tc", ":NvimTreeFindFile<CR>", desc = "Find current buffer in file tree" },
    { "<LEADER>tf", ":NvimTreeFocus<CR>", desc = "Focus on file tree" },
    { "<LEADER>tr", ":NvimTreeRefresh<CR>", desc = "Refresh file tree" },
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
    on_attach = function(buf)
      local api = require("nvim-tree.api")
      local function opts(desc)
        return {
          desc = desc,
          buffer = buf,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      api.config.mappings.default_on_attach(buf) -- 기본 키맵

      vim.keymap.set("n", "<C-CR>", api.tree.change_root_to_node, opts("CD"))
      vim.keymap.set("n", "d", api.fs.trash, opts("Trash"))
      vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
    end,
  },
}
