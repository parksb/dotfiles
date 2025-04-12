return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPre",
  init = function()
    vim.api.nvim_set_hl(0, "DiffText", { fg = "#ffffff", bg = "#1d3b40" })
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#ffffff", bg = "#1d3450" })
  end,
  opts = {
    default_mappings = false,
  },
  config = function()
    vim.keymap.set("n", ",o", "<Plug>(git-conflict-ours)", { desc = "git-conflict-ours" })
    vim.keymap.set("n", ",t", "<Plug>(git-conflict-theirs)", { desc = "git-conflict-theirs" })
    vim.keymap.set("n", ",b", "<Plug>(git-conflict-both)", { desc = "git-conflict-both" })
    vim.keymap.set("n", ",0", "<Plug>(git-conflict-none)", { desc = "git-conflict-none" })
    vim.keymap.set("n", ",x", "<Plug>(git-conflict-prev-conflict)", { desc = "git-conflict-prev-conflict" })
    vim.keymap.set("n", ",X", "<Plug>(git-conflict-next-conflict)", { desc = "git-conflict-next-conflict" })
  end,
}
