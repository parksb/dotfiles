return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = function()
    local builtin = require("telescope.builtin")

    return {
      {
        "<LEADER>ss",
        function()
          Searcher.user_search("live_grep", builtin.live_grep)
        end,
        desc = "Search",
      },
      {
        "<LEADER>sf",
        function()
          Searcher.user_search("find_files", builtin.find_files)
        end,
        desc = "Search files",
      },
      {
        "<LEADER>sb",
        function()
          Searcher.user_search("buffers", builtin.buffers)
        end,
        desc = "Search buffers",
      },
      {
        "<LEADER>/",
        function()
          Searcher.buffer_search(builtin.current_buffer_fuzzy_find, require("telescope.themes").get_dropdown({
            winblend = 10,
            previewer = false,
          }))
        end,
        desc = "Search in current buffer",
      },
    }
  end,
}
