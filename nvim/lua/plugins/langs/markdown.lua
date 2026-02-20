return {
  lsp = {
    marksman = {
      root_dir = function(bufnr, callback)
        local ok, simpesys = pcall(require, "simpesys")
        if ok and simpesys.find_root(vim.api.nvim_buf_get_name(bufnr)) then
          return
        end
        callback(vim.fs.root(bufnr, ".marksman.toml") or vim.fn.getcwd())
      end,
    },
  },
}
