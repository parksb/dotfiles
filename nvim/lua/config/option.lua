vim.opt.smartindent = true -- 자동으로 들여쓰기 한다.
vim.opt.expandtab = true -- 탭 대신 공백을 사용한다.
vim.opt.shiftwidth = 2 -- 자동 들여쓰기 너비를 설정한다.
vim.opt.tabstop = 2 -- 탭 너비를 설정한다.

vim.opt.termguicolors = true -- 트루 컬러를 사용한다.
vim.opt.number = true -- 줄 번호를 표시한다.
vim.opt.relativenumber = true -- 줄 번호를 상대적으로 표시한다.
vim.opt.cursorline = true -- 커서 라인을 표시한다.
vim.opt.title = true -- 제목을 표시한다.
vim.opt.laststatus = 3 -- 여러 창에서 하나의 공통 상태바를 표시한다.
vim.opt.showmode = false -- 상태바 아래에 모드를 표시하지 않는다.
vim.opt.showmatch = true -- 일치하는 괄호를 강조한다.
vim.opt.signcolumn = "yes" -- 항상 signcolumn을 표시한다.

vim.opt.hlsearch = true -- 검색 결과를 강조한다.
vim.opt.ignorecase = true -- 검색 시 대소문자를 구분하지 않는다.
vim.opt.incsearch = true -- 검색어를 입력할 때마다 결과를 표시한다.
vim.opt.smartcase = true -- 검색어에 대문자가 있으면 대소문자를 구분한다.

vim.opt.timeoutlen = 300 -- 키 입력 대기 시간을 설정한다. (which-key 트리거 시간)
vim.opt.undolevels = 10000 -- 최대 undo 레벨을 설정한다.
vim.opt.updatetime = 200 -- 스왑 파일 저장과 CursorHold 이벤트 주기를 설정한다.
vim.opt.virtualedit = "block" -- 비주얼 블록 모드에서 텍스트가 없는 곳에 커서를 놓을 수 있다.

vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8" }
vim.opt.scrolloff = 3
