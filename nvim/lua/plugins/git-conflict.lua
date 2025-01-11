return {
  "akinsho/git-conflict.nvim",
  version = "*",
  event = "BufReadPre",
  config = function()
    vim.api.nvim_set_hl(0, "DiffText", { fg = "#ffffff", bg = "#1d3b40" })
    vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#ffffff", bg = "#1d3450" })
    require("git-conflict").setup()
  end,
}
