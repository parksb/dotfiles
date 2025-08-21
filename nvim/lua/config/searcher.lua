local M = {}

local state = {
  user_search = {
    mode = nil, -- live_grep | find_files | buffers
    cwd = nil,
  },
  last_search_type = nil, -- "user" | "lsp" | "buffer"
}

function M.user_search(mode, searcher, opts)
  opts = opts or {}

  local cwd = opts.cwd or vim.fn.getcwd()

  -- NvimTree 버퍼에서 검색하면 현재 디렉토리 대상으로 검색한다.
  local buf = vim.api.nvim_buf_get_name(0)
  if vim.fn.fnamemodify(buf, ":t"):match("^NvimTree_") then
    cwd = vim.fn.getcwd()
  end

  opts.cwd = cwd

  -- 같은 모드, 같은 디렉토리인 경우 지난 섬색을 이어서 진행한다.
  if state.user_search.mode == mode and state.user_search.cwd == cwd then
    if state.last_search_type == "user" then
      require("telescope.builtin").resume()
    else
      searcher(opts) -- 마지막 검색이 LSP나 버퍼 검색이었으면 새로 시작한다.
    end
  else
    searcher(opts) -- 다른 모드나 디렉토리면 새로 시작한다.
  end

  state.user_search.mode = mode
  state.user_search.cwd = cwd
  state.last_search_type = "user"
end

-- LSP 검색을 지원한다.
function M.lsp_search(picker_name, opts)
  opts = opts or {}
  require("telescope.builtin")[picker_name](opts)
  state.last_search_type = "lsp"
end

-- 버퍼 내에서 검색한다.
function M.buffer_search(searcher, opts)
  searcher(opts)
  state.last_search_type = "buffer"
end

return M
