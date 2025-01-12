M = {}

M.ternary = function(condition, a, b)
  if condition then
    return a
  else
    return b
  end
end

M.has = function(a, x)
  for _, v in ipairs(a) do
    if v == x then
      return true
    end
  end
  return false
end

M.is_text_file = function()
  local text_ft = { "plainlatex", "plaintex", "markdown", "plaintext" }
  if M.has(vim.bo.filetype, text_ft) then
    return true
  end
  return false
end

return M
