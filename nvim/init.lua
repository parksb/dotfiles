-- 파일을 로드하기 전에 <LEADER>를 설정해야 한다.
vim.g.mapleader = " "

require("config.global").setup()
require("config.option")
require("config.keymap")
require("config.autocmd")
require("config.lazy")
