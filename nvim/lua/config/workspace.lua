M = {}

WorkspaceConfig = nil

M.workspace_config = function()
  local config = {}
  local path = vim.fn.getcwd()
  while path ~= "/" do
    local config_path = path .. "/.vim/config.lua"
    if vim.fn.filereadable(config_path) == 1 then
      config = dofile(config_path)
      break
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return config
end

M.linter = function(lang)
  local config = WorkspaceConfig or M.workspace_config()
  if config[lang] and config[lang].linter then
    return config[lang].linter
  end
  return nil
end

M.conform = function(lang)
  local config = WorkspaceConfig or M.workspace_config()
  if config[lang] and config[lang].conform then
    return config[lang].conform
  end
  return nil
end

return M
