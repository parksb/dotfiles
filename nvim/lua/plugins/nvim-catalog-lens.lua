return {
  "parksb/nvim-catalog-lens",
  branch = "main",
  ft = { "json" },
  init = function()
    vim.g.catalog_display = "eol"
  end,
}
