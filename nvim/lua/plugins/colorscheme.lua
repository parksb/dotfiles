return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    priority = 9999,
    init = function()
      vim.cmd[[colorscheme dracula]]
    end,
    opts = {
      show_end_of_buffer = true,
      overrides = {
        CursorLine = { bg = "#363844" },
      },
    },
  },
}
