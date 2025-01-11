return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local builtin = require("telescope.builtin")
    local last_search_mode = nil
    local last_cwd = vim.fn.getcwd()

    local function search(mode, fn)
      local cwd = last_cwd

      local buf = vim.api.nvim_buf_get_name(0)
      if vim.fn.fnamemodify(buf, ":t"):match("^NvimTree_") then
        cwd = vim.fn.getcwd()
      end

      vim.api.nvim_echo({ { "Searching in " .. cwd, "InfoMsg" } }, true, {})
      if last_search_mode == mode and last_cwd == cwd then
        builtin.resume()
      else
        last_search_mode = mode
        last_cwd = cwd
        fn { cwd = cwd }
      end
    end

    return {
      { "<LEADER>ss", function() search("live_grep", builtin.live_grep) end },
      { "<LEADER>sf", function() search("find_files", builtin.find_files) end },
      { "<LEADER>sb", function() search("buffers", builtin.buffers) end },
      {
        "<LEADER>/",
        function()
          builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end,
      },
    }
  end,
}
