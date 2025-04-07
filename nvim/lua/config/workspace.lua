local M = {}

M.workspace_config = function()
  local config = {}
  local path = vim.fn.getcwd()
  while path ~= vim.fn.expand("~") do
    local config_path = path .. "/.vim/config.lua"
    if vim.fn.filereadable(config_path) == 1 then
      config = dofile(config_path)
      table.insert(EarlyNotifications, {
        msg = "Workspace config found: " .. config_path,
        level = vim.log.levels.INFO,
      })
      break
    end
    path = vim.fn.fnamemodify(path, ":h")
  end
  return config
end

M.linter = function(lang)
  local config = M.config or M.workspace_config()
  if config[lang] and config[lang].linter then
    return config[lang].linter
  end
  return nil
end

M.conform = function(lang)
  local config = M.config or M.workspace_config()
  if config[lang] and config[lang].conform then
    return config[lang].conform
  end
  return nil
end

M.config = M.workspace_config()

return M
