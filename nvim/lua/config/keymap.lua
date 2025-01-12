vim.keymap.set("n", "<LEADER>n", ":bn<CR>", { desc = "Next buffer", remap = false, silent = true })
vim.keymap.set("n", "<LEADER>p", ":bp<CR>", { desc = "Previous buffer", remap = false, silent = true })
vim.keymap.set("n", ":bd<CR>", ":bn | bd #<CR>", { desc = "Close buffer", remap = false, silent = true })
vim.keymap.set(
  "n",
  ":bda<CR>",
  ":%bd | e# | bd#<CR>",
  { desc = "Close all other buffers", remap = false, silent = true }
)
vim.keymap.set("n", ":W<CR>", ":w<CR>", { desc = "Write buffer", remap = false, silent = true })
vim.keymap.set("v", "<C-y>", '"+y', { desc = "Copy to clipboard", remap = false, silent = true })
