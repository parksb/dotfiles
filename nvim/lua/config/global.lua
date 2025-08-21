local M = {}

M.setup = function()
  EarlyNotifications = {} -- 초기 알림 버퍼
  Workspace = require("config.workspace")
  Searcher = require("config.searcher")
end

return M
