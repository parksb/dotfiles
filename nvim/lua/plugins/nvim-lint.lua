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
    -- TODO: linter 설정을 각 언어 파일로 옮기기.
    require("lint").linters_by_ft = {
      fish = { "fish" },
      sh = { "shellcheck" },
      rust = { "clippy" },
      javascript = { "eslint" },
      typescript = { "eslint" },
    }
  end,
}
