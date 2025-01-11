return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = true,
  init = function()
    vim.api.nvim_set_hl(0, "ConflictMarkerBegin", {  bg = "#2f7366" })
    vim.api.nvim_set_hl(0, "ConflictMarkerOurs", {  bg = "#2e5049" })
    vim.api.nvim_set_hl(0, "ConflictMarkerTheirs", {  bg = "#344f69" })
    vim.api.nvim_set_hl(0, "ConflictMarkerEnd", {  bg = "#2f628e" })
    vim.api.nvim_set_hl(0, "ConflictMarkerCommonAncestorsHunk", {  bg = "#754a81" })
  end
}
