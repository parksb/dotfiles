return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Next hunk
      map("n", ",n", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Prev hunk
      map("n", ",N", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Stage the current hunk
      map({ "n", "v" }, ",s", ":Gitsigns stage_hunk<CR>")
      -- Reset the current hunk
      map({ "n", "v" }, ",r", ":Gitsigns reset_hunk<CR>")
      -- Stage the buffer
      map("n", ",S", gs.stage_buffer)
      -- Unstage the staged hunk
      map("n", ",u", gs.undo_stage_hunk)
      -- Reset the buffer
      map("n", ",R", gs.reset_buffer)
      -- Preview the current hunk
      map("n", ",p", gs.preview_hunk)
      -- Show blame for the current line
      map("n", ",b", function()
        gs.blame_line({ fulll = true })
      end)
      -- Toggle current line blame
      map("n", ",tb", gs.toggle_current_line_blame)
      -- Open the diff view for the current file
      map("n", ",d", gs.diffthis)
      -- Toggle the deleted sign
      map("n", ",td", gs.toggle_deleted)
      -- Select the current hunk
      map({ "o", "x" }, ",ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
  },
}
