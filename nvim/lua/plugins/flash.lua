return {
  "folke/flash.nvim",
  enabled = false,
  event = "VeryLazy",
  opts = {
    modes = {
      char = {
        keys = { "f", "F", "t", "T" },
      },
    },
  },
  keys = {
    {
      "<LEADER>f",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    {
      "<LEADER>F",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
    },
  },
}
