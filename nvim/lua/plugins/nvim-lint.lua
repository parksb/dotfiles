return {
  "mfussenegger/nvim-lint",
  event = "BufReadPre",
  init = function()
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
  config = function()
    require("lint").linters_by_ft = {
      fish = require("plugins/langs/fish").linter,
      sh = require("plugins/langs/shell-script").linter,
      rust = require("plugins/langs/rust").linter,
      javascript = require("plugins/langs/javascript").linter,
      typescript = require("plugins/langs/javascript").linter,
    }
  end,
}
