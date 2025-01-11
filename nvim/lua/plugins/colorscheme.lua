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
      overrides = function(colors)
        return {
          CursorLine = { bg = "#30303c" },
          NvimTreeIndentMarker = { fg = colors.comment, },
        }
      end,
    },
  },
}
