return {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_maps = {
      ["Visual Cursors"] = "<C-m>",
    }
  end,
}
