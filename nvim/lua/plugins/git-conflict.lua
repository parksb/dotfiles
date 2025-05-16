return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPre",
  init = function()
    vim.api.nvim_set_hl(0, "DiffText", { fg = "#ffffff", bg = "#1d3b40" })
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#ffffff", bg = "#1d3450" })
  end,
  opts = {
    default_mappings = {
      ours = ",o",
      theirs = ",t",
      none = ",0",
      both = ",2",
      next = ",x",
      prev = ",X",
    },
  },
  config = true,
}
