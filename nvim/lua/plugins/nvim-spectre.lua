return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<LEADER>rr", "<CMD>lua require('spectre').open_visual()<CR>" },
    { "<LEADER>ro", ":lua require('spectre.actions').run_replace()<CR>" },
  },
}
