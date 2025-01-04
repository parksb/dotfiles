set autoindent " 자동으로 들여쓰기한다.
set expandtab " 탭 대신 공백을 사용한다.
set shiftwidth=2 " 쉬프트를 2칸으로 설정한다.
set tabstop=2 " 탭을 2칸으로 설정한다.
set ts=2 " 탭 들여쓰기를 2칸으로 설정한다.
set nu " 줄 번호를 보여준다
set title " 문서 제목을 보여준다.
set showmatch " 괄호의 짝을 강조한다.
set noshowmode " 상태바 아래에 현재 모드를 보여주지 않는다.
set hlsearch " 검색한 단어를 강조한다.
set ignorecase " 검색 시 대소문자를 구분하지 않는다.
set incsearch " 검색할 글자를 입력할 때마다 검색한다.
set number relativenumber " 라인 넘버를 상대적으로 보여준다.
set encoding=utf-8
set fileencodings=utf-8
set cursorline

" ========================
" 문법 강조
" ========================
if has ("syntax")
  syntax on
endif

" ========================
" 자동화
" ========================
" 마지막 수정 위치로 커서 이동
autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"' | endif
" trailing whitespace 제거
au BufWritePre * :%s/\s\+$//e

" ========================
" 버퍼
" ========================
nnoremap :bn :bn<CR>
nnoremap :bp :bp<CR>
" :bd<CR> - 버퍼를 닫고 다음 버퍼로 이동한다.
nnoremap :bd<CR> :bn <BAR> bd #<CR>
" 현재 버퍼를 제외한 모든 버퍼를 닫는다.
nnoremap :bda<CR> :%bd <BAR> e# <BAR> bd#<CR>
" 버퍼 이동 시 대문자 대응
nnoremap :Bp<CR> :bp<CR>
nnoremap :Bp :bp<CR>
nnoremap :Bn<CR> :bn<CR>
nnoremap :Bn :bn<CR>
nnoremap :Bd<CR> :bd<CR>

" ========================
" 기타 키 매핑
" ========================
" 저장 시 대문자 대응
nnoremap :W<CR> :w<CR>
" <C-c> - 선택한 텍스트를 클립보드로 복사한다.
vnoremap <C-y> "+y
" <LEADER>를 공백으로 설정
let g:mapleader = " "

" ========================
" 복사 하이라이트
" ========================
au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 2000 }

" ========================
" Lua 전역
" ========================
lua << EOF
vim.loader.enable()

function ternary(condition, a, b)
  if condition then
    return a
  else
    return b
  end
end

function has(a, x)
  for i, v in ipairs(a) do
    if v == x then
      return true
    end
  end
  return false
end

filetype = vim.bo.filetype
textFiletypes = {"plaintex", "latex", "markdown"}
isTexFile = filetype == "plaintex" or filetype == "latex"
isTextFile = has(textFiletypes, filetype)
EOF

" ========================
" CursorLine
" ========================
lua << EOF
if not isTextFile then
  vim.api.nvim_create_autocmd('ColorScheme', {
    command = [[highlight CursorLine guibg=#363844]],
  })
end
EOF

" ========================
" vim-plug
" ========================
call plug#begin('~/.vim/plugged')
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-tree/nvim-tree.lua'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'mhinz/vim-startify'
Plug 'simnalamburt/vim-tiny-ime'
Plug 'johngrib/vim-f-hangul'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-refactor'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'akinsho/git-conflict.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'kylechui/nvim-surround'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'github/copilot.vim'
Plug 'NvChad/nvim-colorizer.lua'
Plug 'sevko/vim-nand2tetris-syntax'
Plug 'phaazon/hop.nvim'
Plug 'vimwiki/vimwiki'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.x' }
Plug 'stevearc/oil.nvim'
Plug 'Bekaboo/dropbar.nvim'
Plug 'nvim-pack/nvim-spectre'
call plug#end()

" ========================
" lualine.nvim
" ========================
lua << EOF
require('lualine').setup {
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'filename', path = 1 } },
    lualine_c = { 'branch', 'diff', 'diagnostics' },
    lualine_x = { 'encoding', 'filetype', 'filesize' },
    lualine_y = {
      function()
        if isTextFile then
          local wc = vim.api.nvim_eval('wordcount()')
          if wc['visual_chars'] then
            return wc['visual_chars']
          end
        end
        return ''
      end
    },
    lualine_z = { 'location' }
  },
  tabline = {
    lualine_a = {
      { 'buffers', mode = 4, max_length = vim.o.columns },
    },
    lualine_z = { 'tabs' },
  },
}
EOF
set laststatus=2

" ========================
" nvim-tree.lua
" ========================
" ;n - nvim-tree 윈도우를 연다.
nnoremap <LEADER>tt :NvimTreeToggle<CR>
nnoremap <LEADER>tc :NvimTreeFindFile<CR>
nnoremap <LEADER>tf :NvimTreeFocus<CR>

lua << EOF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function custom_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr) -- default mappings

  vim.keymap.set('n', '<C-CR>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'd', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

require("nvim-tree").setup {
  renderer = {
    highlight_git = true,
    add_trailing = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "after",
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  git = {
    ignore = false,
  },
  trash = {
    cmd = 'trash',
  },
  on_attach = custom_on_attach,
}
EOF

" ========================
" gitsigns.nvim
" ========================
lua << EOF
require('gitsigns').setup {
  current_line_blame = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- 다음 헝크로 이동한다.
    map('n', ',n', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- 이전 헝크로 이동한다.
    map('n', ',N', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- 해당 헝크를 스테이지한다.
    map({'n', 'v'}, ',s', ':Gitsigns stage_hunk<CR>')
    -- 해당 헝크를 리셋한다.
    map({'n', 'v'}, ',r', ':Gitsigns reset_hunk<CR>')
    -- 버퍼를 스테이지한다.
    map('n', ',S', gs.stage_buffer)
    -- 스테이지한 헝크를 언스테이지한다.
    map('n', ',u', gs.undo_stage_hunk)
    -- 버퍼를 리셋한다.
    map('n', ',R', gs.reset_buffer)
    -- 해당 헝크를 미리본다.
    map('n', ',p', gs.preview_hunk)
    -- 해당 라인의 블레임을 보여준다.
    map('n', ',b', function() gs.blame_line{full=true} end)
    -- 해당 라인의 블레임을 토글한다.
    map('n', ',tb', gs.toggle_current_line_blame)
    -- diff 윈도우를 연다.
    map('n', ',d', gs.diffthis)
    -- 삭제된 라인 표시를 토글한다.
    map('n', ',td', gs.toggle_deleted)
    -- 헝크를 선택한다.
    map({'o', 'x'}, ',ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
EOF

" ========================
" git-conflict.nvim
" ========================
lua << EOF
vim.api.nvim_set_hl(0, 'DiffText', { fg = '#ffffff', bg = '#1d3b40' })
vim.api.nvim_set_hl(0, 'DiffAdd', { fg = '#ffffff', bg = '#1d3450' })
require('git-conflict').setup()
EOF

" ========================
" dracula
" ========================
set termguicolors
lua << EOF
if isTextFile then
  vim.cmd("colorscheme onehalflight")
else
  vim.cmd("colorscheme dracula")
end
EOF

" ========================
" coc.nvim
" ========================
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
" 익스텐션 목록
let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-eslint',
      \ 'coc-pyright',
      \ 'coc-rust-analyzer',
      \ 'coc-sh',
      \ 'coc-texlab',
      \ 'coc-tsserver',
      \ 'coc-html',
      \ 'coc-vimlsp',
      \ 'coc-svelte',
      \ ]
" <TAB> - 현재 문자에 대한 자동완성을 트리거링한다.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" <CR> - 선택한 자동완성 제안을 선택한다.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" <C-SPACE> - 자동완성을 트리거링한다.
inoremap <silent><expr> <C-SPACE> coc#refresh()
" [g - 이전 진단을 탐색한다.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
" ]g - 다음 진단을 탐색한다.
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" gd - 정의로 이동한다.
nmap <silent> gd <Plug>(coc-definition)
" gy - 타입 정의로 이동한다.
nmap <silent> gy <Plug>(coc-type-definition)
" gi - 구현으로 이동한다.
nmap <silent> gi <Plug>(coc-implementation)
" gr - 참조로 이동한다.
nmap <silent> gr <Plug>(coc-references)
" K - 문서를 보여준다.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
" <LEADER>rn - 심볼 이름을 변경한다.
nmap <LEADER>rn <Plug>(coc-rename)
" <LEADER>f - 선택된 코드를 포매팅한다.
xmap <LEADER>f <Plug>(coc-format-selected)
nmap <LEADER>f <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " 특정 파일 타입에 대해 `formatexpr`를 설정한다.
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " jump placeholder에 대한 서명 도움말을 업데이트한다.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" <LEADER>a - 선택된 영역에 codeAction을 적용한다. (e.g. <LEADER>aap - 현재 문단)
xmap <LEADER>a <Plug>(coc-codeaction-selected)
nmap <LEADER>a <Plug>(coc-codeaction-selected)
" <LEADER>ac - Remap keys for applying codeAction to the current buffer.
nmap <LEADER>ac <Plug>(coc-codeaction)
" <LEADER>qf - 현재 라인에 문제에 대한 AutoFix를 적용한다.
nmap <LEADER>qf <Plug>(coc-fix-current)
" <LEADER>cl - 현재 라인에 코드 렌즈 액션을 실행한다.
nmap <LEADER>cl <Plug>(coc-codelens-action)
" <C-s> - 블록 및 스코프 범위를 선택한다.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" :Format - 현재 버퍼를 포매팅한다.
command! -nargs=0 Format :call CocActionAsync('format')
" :Fold - 현재 버퍼를 접는다.
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" :OR - 현재 버퍼의 imports를 정리한다.
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')
" :cocd - 진단 목록
nnoremap <silent><nowait> :cocd :<C-u>CocList diagnostics<cr>

" ========================
" vim-startify
" ========================
let g:startify_lists = [
      \ { 'type': 'sessions', 'header': ['Sessions'] },
      \ { 'type': 'dir', 'header': ['MRU '. getcwd()] },
      \ { 'type': 'files', 'header': ['MRU'] },
      \ { 'type': 'bookmarks', 'header': ['Bookmarks'] },
      \ { 'type': 'commands', 'header': ['Commands'] },
      \ ]
let g:startify_custom_header = ['Neovim: hyperextensible Vim-based text editor']
" 시작 화면을 항상 최신으로 유지한다.
let g:startify_update_oldfiles = 1
" 파일을 열 때 VCS의 루트 디렉토리를 찾아 변경한다.
let g:startify_change_to_vcs_root = 1
" 세션 목록을 최근 변경 시간순으로 정렬한다.
let g:startify_session_sort = 1
" Vim을 종료하거나, 새로운 세션을 열기 전에 현재 세션을 자동으로 저장한다.
let g:startify_session_persistence = 1
" :stl - 시작 화면을 연다.
nnoremap :stl<CR> :Startify<CR>
" :sts - 현재 세션을 저장한다.
nnoremap :sts<CR> :SSave<CR>

" ========================
" vim-visual-multi
" ========================
let g:VM_maps = {}
" <C-m> - 선택한 모든 라인에 커서를 만든다.
let g:VM_maps["Visual Cursors"] = '<C-m>'
hi! VM_Mono guibg=#ffb86c guifg=#000000 gui=NONE

" ========================
" nvim-treesitter
" ========================
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "bash", "bibtex", "comment", "cpp", "css", "diff", "dockerfile", "fish",
  "git_config", "git_rebase", "gitcommit", "gitignore", "html", "javascript", "json", "latex",
  "make", "markdown", "markdown_inline", "python", "regex", "rust", "scss", "sql", "rust", "toml", "tsx",
  "typescript", "vim", "vimdoc", "yaml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
  },
}
EOF

" ========================
" nvim-treesitter-context
" ========================
lua require('treesitter-context').setup()

" ========================
" Comment.nvim
" ========================
" gcc - 현재 라인의 주석을 토글한다.
" gbc - 현재 라인의 블록 주석을 토글한다.
lua require('Comment').setup()

" ========================
" nvim-scrollbar
" ========================
lua << EOF
require('scrollbar').setup {
  show = not isTextFile,
  show_in_active_only = true,
  handlers = {
    gitsigns = true,
  },
  marks = {
    GitAdd = {
      color = '#50fa7b',
    },
    GitChange = {
      color = '#ffb86c',
    },
    GitDelete = {
      color = '#ff5555',
    },
  },
}
EOF

" ========================
" nvim-surround
" ========================
" Old text                    Command         New text
" -----------------------------------------------------------------
" surr*ound_words             ysiw)           (surround_words)
" *make strings               ys$"            "make strings"
" [delete ar*ound me!]        ds]             delete around me!
" remove <b>HTML t*ags</b>    dst             remove HTML tags
" 'change quot*es'            cs'"            "change quotes"
" <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
" delete(functi*on calls)     dsf             function calls
lua << EOF
require('nvim-surround').setup {
  surrounds = {
    ['\''] = {
      add = function()
        return ternary(isTexFile, { { '`' }, { '\'' } }, { { '\'' }, { '\'' } })
      end
    },
    ['"'] = {
      add = function()
        return ternary(isTexFile, { { '``' }, { '\'\'' } }, { { '"' }, { '"' } })
      end
    }
  }
}
EOF

" ========================
" indent-blankline.nvim
" ========================
lua << EOF
require("ibl").setup {
  indent = { char = "▏" },
  scope = { show_start = false, show_end = false },
}
EOF

" ========================
" nvim-colorizer.lua
" ========================
lua require('colorizer').setup()

" ========================
" hop.nvim
" ========================
lua require('hop').setup()
nnoremap <LEADER>f :HopChar1<CR>

" ========================
" vimwiki
" ========================
let g:vimwiki_list = [
      \ {
      \   'path': '~/projects/pedia/docs',
      \   'ext': '.md',
      \   'diary_rel_path': '.',
      \ },
      \]
let g:vimwiki_conceallevel = 0
let g:vimwiki_global_ext = 0
let g:vimwiki_autowriteall = 0
" <LEADER>wr - 위키에서 해당 단어가 언급되는 문서를 검색한다.
nnoremap <LEADER>ww :execute "VWS /" . expand("<cword>") . "/" <Bar> :lopen<CR>
" <LEADER>ww - 현재 문서를 링크하는 문서를 검색한다.
nnoremap <LEADER>wb :execute "VWB" <Bar> :lopen<CR>

" ========================
" telescope.nvim
" ========================
lua << EOF
local builtin = require('telescope.builtin')
local last_search_mode = nil
local last_cwd = vim.fn.getcwd()

local function search(mode, fn)
  local cwd = last_cwd

  local buf = vim.api.nvim_buf_get_name(0)
  if vim.fn.fnamemodify(buf, ":t"):match("^NvimTree_") then
    cwd = vim.fn.getcwd()
  end

  vim.api.nvim_echo({ { 'Searching in ' .. cwd, 'InfoMsg' } }, true, {})
  if last_search_mode == mode and last_cwd == cwd then
    builtin.resume()
  else
    last_search_mode = mode
    last_cwd = cwd
    fn {
      cwd = cwd,
    }
  end
end

vim.keymap.set('n', '<LEADER>ss', function() search('live_grep', builtin.live_grep) end)
vim.keymap.set('n', '<LEADER>sf', function() search('find_files', builtin.find_files) end)
vim.keymap.set('n', '<LEADER>sb', function() search('buffers', builtin.buffers) end)

-- <LEADER>/ - 현재 열린 버퍼에서 검색한다.
vim.keymap.set('n', '<LEADER>/', function()
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end)

-- <LEADER>s/ - 현재 열린 파일에서 검색한다.
vim.keymap.set('n', '<LEADER>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end)
EOF

" ========================
" oil.nvim
" ========================
lua require("oil").setup()

" ========================
" nvim-spectre
" ========================
lua vim.keymap.set('n', '<LEADER>rr', '<CMD>lua require("spectre").open_visual()<CR>')
lua vim.keymap.set('n', '<LEADER>ro', ':lua require("spectre.actions").run_replace()<CR>')
