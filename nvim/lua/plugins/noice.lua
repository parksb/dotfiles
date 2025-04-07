return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    local win_width = vim.api.nvim_win_get_width(0)
    require("noice").setup({
      lsp = {
        documentation = {
          opts = {
            size = {
              max_width = win_width - 30,
            },
          },
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      notify = {
        enabled = true,
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
      views = {
        mini = {
          timeout = 3500,
          size = {
            max_width = win_width - 50,
          },
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            kind = "",
            find = "written",
          },
          opts = { skip = true },
        },
      },
    })

    vim.defer_fn(function()
      if EarlyNotifications then
        for _, item in ipairs(EarlyNotifications) do
          vim.notify(item.msg, item.level)
        end
        EarlyNotifications = {}
      end
    end, 1000)
  end,
}
