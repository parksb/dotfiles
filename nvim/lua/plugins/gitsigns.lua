return {
  "lewis6991/gitsigns.nvim",
  opts = {
    current_line_blame = true,
    on_attach = function(buf)
      local LEADER = ","
      local gs = package.loaded.gitsigns
      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = buf
        vim.keymap.set(mode, l, r, opts)
      end

      map("n", LEADER .. "n", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Next hunk" })

      map("n", LEADER .. "N", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous hunk" })

      map({ "n", "v" }, LEADER .. "s", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
      map({ "n", "v" }, LEADER .. "r", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
      map("n", LEADER .. "u", gs.undo_stage_hunk, { desc = "Undo stage hunk" })

      map("n", LEADER .. "R", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", LEADER .. "S", gs.stage_buffer, { desc = "Stage buffer" })

      map("n", LEADER .. "p", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", LEADER .. "b", function()
        gs.blame_line({ fulll = true })
      end, { desc = "Blame line" })
      map("n", LEADER .. "f", gs.diffthis, { desc = "Diff buffer" })
      map("n", LEADER .. "d", gs.toggle_deleted, { desc = "Toggle deleted changes" })
      map({ "o", "x" }, LEADER .. "i", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
    end,
  },
}
