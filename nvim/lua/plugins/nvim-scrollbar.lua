return {
  "petertriho/nvim-scrollbar",
  event = "VeryLazy",
  opts = {
    show_in_active_only = true,
    handlers = {
      gitsigns = true,
    },
    marks = {
      GitAdd = {
        color = "#50fa7b",
      },
      GitChange = {
        color = "#ffb86c",
      },
      GitDelete = {
        color = "#ff5555",
      },
    },
  },
}
