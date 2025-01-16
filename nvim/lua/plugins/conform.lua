return {
  "stevearc/conform.nvim",
  keys = {
    {
      "+",
      function()
        require("conform").format({ acync = true })
      end,
      mode = "",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = require("plugins/langs/lua").conform,
      rust = require("plugins/langs/rust").conform,
      python = require("plugins/langs/python").conform,
      javascript = require("plugins/langs/javascript").conform,
      typescript = require("plugins/langs/typescript").conform,
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    notify_on_error = true,
    notify_no_formatters = true,
  },
}
