return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local builtin = require("telescope.builtin")
    local last_search_mode = nil -- live_grep | find_files | buffers
    local last_cwd = vim.fn.getcwd()

    local function search(mode, fn)
      local cwd = last_cwd

      -- 버퍼 이름이 "NvimTree_"로 시작하면 현재 디렉토리를 사용한다.
      local buf = vim.api.nvim_buf_get_name(0)
      if vim.fn.fnamemodify(buf, ":t"):match("^NvimTree_") then
        cwd = vim.fn.getcwd()
      end

      vim.api.nvim_echo({ { "Searching in " .. cwd, "InfoMsg" } }, true, {})
      if last_search_mode == mode and last_cwd == cwd then
        -- 마지막 검색 모드와 현재 디렉토리가 같으면 검색을 재개한다.
        builtin.resume()
      else
        last_search_mode = mode
        last_cwd = cwd
        fn({ cwd = cwd })
      end
    end

    return {
      {
        "<LEADER>ss",
        function()
          search("live_grep", builtin.live_grep)
        end,
        desc = "Search",
      },
      {
        "<LEADER>sf",
        function()
          search("find_files", builtin.find_files)
        end,
        desc = "Search files",
      },
      {
        "<LEADER>sb",
        function()
          search("buffers", builtin.buffers)
        end,
        desc = "Search buffers",
      },
      {
        "<LEADER>/",
        function()
          builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "Search in current buffer",
      },
    }
  end,
}
