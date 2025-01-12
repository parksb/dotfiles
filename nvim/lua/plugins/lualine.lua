return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = {
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "filename", path = 1 } },
      lualine_c = { "branch", "diff", "diagnostics" },
      lualine_x = { "encoding", "filetype", "filesize" },
      lualine_y = {
        function() -- 텍스트 파일에서는 글자수를 표시한다.
          if require("config.util").is_text_file() then
            local wc = vim.api.nvim_eval("wordcount()")
            if wc["visual_chars"] then
              return wc["visual_chars"]
            end
          end
          return ""
        end,
      },
      lualine_z = { "location" },
    },
    tabline = {
      lualine_a = {
        { "buffers", mode = 4, max_length = vim.o.columns },
      },
      lualine_z = { "tabs" },
    },
    theme = "dracula-nvim",
  },
}
