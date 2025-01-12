return {
  {
    "Mofiqul/dracula.nvim",
    lazy = false,
    init = function()
      vim.cmd([[colorscheme dracula]])
    end,
    opts = {
      show_end_of_buffer = true,
      overrides = function(colors)
        return {
          CursorLine = { bg = "#30303c" },
          NvimTreeIndentMarker = { fg = colors.comment },
          NvimTreeRootFolder = { fg = colors.purple, bold = true },
          GitSignsCurrentLineBlame = { fg = colors.gutter_fg },
        }
      end,
    },
  },
}
