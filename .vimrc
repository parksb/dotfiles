set autoindent " 자동으로 들여쓰기한다.
set cindent " C 스타일(중괄호 다음 행에 들여쓰기)로 들여쓰기한다.
set expandtab " 탭 대신 공백을 사용한다.
set shiftwidth=2 " 쉬프트를 2칸으로 설정한다.
set tabstop=2 " 탭을 2칸으로 설정한다.
set ts=2 " 탭 들여쓰기를 2칸으로 설정한다.
set nu " 줄 번호를 보여준다
set cursorline " 커서 위치를 보여준다.
set title " 문서 제목을 보여준다.
set showmatch " 괄호의 짝을 강조한다.
set noshowmode " 상태바 아래에 현재 모드를 보여주지 않는다.
set hlsearch " 검색한 단어를 강조한다.
set incsearch " 검색할 글자를 입력할 때마다 검색한다.
set noimd " 노멀 모드에서 영문으로 입력한다. 터미널에서는 무효하다.
set number relativenumber " 라인 넘버를 상대적으로 보여준다.
set encoding=utf-8
set fileencodings=utf-8
set mouse= " 마우스 조작을 비활성화한다.

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
" 파일 유형별 명령
" ========================
" F5 - 실행
au BufEnter *.c nnoremap <F5> :!make run<CR>
au BufEnter *.cpp nnoremap <F5> :!make run<CR>
au BufEnter *.rs nnoremap <F5> :!cargo run<CR>
au BufEnter *.js,*ts nnoremap <F5> :!npm start<CR>
au BufEnter *.py nnoremap <F5> :!python3 %<CR>
au BufEnter *.hs nnoremap <F5> :!runghc %<CR>
" F6 - 빌드
au BufEnter *.c nnoremap <F6> :!make build<CR>
au BufEnter *.cpp nnoremap <F6> :!make build<CR>
au BufEnter *.rs nnoremap <F6> :!cargo build<CR>
au BufEnter *.js,*.ts nnoremap <F6> :!npm run build<CR>
au BufEnter *.tex nnoremap <F6> :!texb<CR>
au BufEnter *.hs nnoremap <F6> :!ghc %<CR>
" F7 - 테스트
au BufEnter *.rs nnoremap <F7> :!cargo test<CR>
au BufEnter *.js,*.ts nnoremap <F6> :!npm run test<CR>

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
" <C-c> - 선택한 라인을 클립보드로 복사한다.
vnoremap <C-c> :w !pbcopy<CR><CR>

" ========================
" 복사 하이라이트
" ========================
au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 2000 }

" ========================
" vim-plug
" ========================
call plug#begin('~/.vim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'simnalamburt/vim-tiny-ime', { 'do' : './build' }
Plug 'editorconfig/editorconfig-vim'
Plug 'johngrib/vim-f-hangul'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
call plug#end()

" ========================
" dracula
" ========================
set termguicolors
colorscheme dracula

" ========================
" vim-visual-multi
" ========================
let g:VM_maps = {}
" <C-m> - 선택한 모든 라인에 커서를 만든다.
let g:VM_maps["Visual Cursors"] = '<C-m>'

