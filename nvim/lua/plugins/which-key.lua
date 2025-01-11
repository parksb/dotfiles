return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  keys = {
    {
      "<LEADER>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  opts = {
    delay = 200,
  },
}
