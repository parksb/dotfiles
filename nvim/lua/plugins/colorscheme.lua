return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    opts = {
      show_end_of_buffer = true,
      overrides = function(colors)
        return {
          CursorLine = { bg = "#30303c" },
          NvimTreeIndentMarker = { fg = colors.comment },
          GitSignsCurrentLineBlame = { fg = colors.gutter_fg },
        }
      end,
    },
    config = function()
      vim.cmd([[colorscheme dracula]])
    end,
  },
}
