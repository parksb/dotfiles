return {
  "Bekaboo/dropbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    local dropbar = require("dropbar")
    local sources = require("dropbar.sources")
    local utils = require("dropbar.utils")

    vim.api.nvim_set_hl(0, "DropBarFileName", { fg = "#ffffff", italic = true })

    local custom_path = {
      get_symbols = function(buff, win, cursor)
        local symbols = sources.path.get_symbols(buff, win, cursor)
        symbols[#symbols].name_hl = "DropBarFileName"
        if vim.bo[buff].modified then
          symbols[#symbols].name = symbols[#symbols].name .. " [+]"
          symbols[#symbols].name_hl = "DiffAdded"
        end
        return symbols
      end,
    }

    dropbar.setup({
      bar = {
        sources = function(buf, _)
          if vim.bo[buf].ft == "markdown" then
            return {
              custom_path,
              sources.markdown,
            }
          end
          if vim.bo[buf].buftype == "terminal" then
            return {
              sources.terminal,
            }
          end
          return {
            custom_path,
            utils.source.fallback({
              sources.lsp,
              sources.treesitter,
            }),
          }
        end,
      },
    })
  end,
}
