M = {}

M.is_text_file = function()
  local text_ft = { "plainlatex", "plaintex", "markdown", "plaintext" }
  if vim.tbl_contains(text_ft, vim.bo.filetype) then
    return true
  end
  return false
end

return M
