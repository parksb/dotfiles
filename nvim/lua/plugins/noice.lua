return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {
    lsp = {
      documentation = {
        opts = {
          size = {
            max_width = vim.api.nvim_win_get_width(0) - 20,
          },
        },
      },
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      bottom_search = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
    cmdline = {
      view = "cmdline",
    },
  },
}
