syntax on
filetype on
filetype plugin on
filetype indent on
let mapleader = "\<Space>"

command CFG :tabe $MYVIMRC
autocmd BufWritePost $MYVIMRC :so $MYVIMRC

" automatically install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" edit
Plug 'LunarWatcher/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
call plug#end()


" *** plugin settings ***
let g:AutoPairsFlyMode = 1

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" *** plugin setting ends ***


" *** others ***
set ai et ts=2 sw=2
" do not use space when indenting in .go
autocmd BufRead *.go :set noet
" runs gofmt after save .go file
autocmd BufWritePost *.go silent! !gofmt -w %
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=cro
autocmd FocusLost * redraw!

set noswapfile nobk nowb " disable swap and backup file
set autoread
set mousehide
set noshowcmd
set nu rnu " line number
set title
set wrap
set linebreak
set history=1000
set numberwidth=1
set pastetoggle=<F2>
set sb spr " split
set encoding=utf-8
set wildmode=longest,list,full
set hls ic scs is " search
set vb t_vb=
set iskeyword+=:
set shellslash
set clipboard^=unnamedplus
set laststatus=1

" Return to last edit position when opening file again
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif


" :Q to quit without saving
command Q :q!
" :W force save with sudo
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>q :q<CR>

" jump between {}
nnoremap <TAB> %
" jump between selected boundrys in visual mode
vnoremap <TAB> o
" quick semicolon
nnoremap <Leader>; A;<Esc>
" add space before and after a char
noremap <Leader>s i<space><ESC>la<space><ESC>

" comment //
autocmd BufRead,BufNewfile *.c,*.cpp,*.cxx,*.h,*.go,*.java,*.js noremap <Leader>/ I// <ESC>
" uncomment //
autocmd BufRead,BufNewfile *.c,*.cpp,*.cxx,*.h,*.go,*.java,*.js noremap <Leader>\ ^3xh<ESC>
" use `:set ft?` to find out current file's filetype
if &ft == 'vim'
  noremap <Leader>/ I" <ESC>
  noremap <Leader>\ ^2xh<ESC>
endif
if &ft == 'conf' || &ft == 'python'
  noremap <Leader>/ I# <ESC>
  noremap <Leader>\ ^2xh<ESC>
endif

" split: horizontal, vertical
noremap <silent> <Leader>h :new<CR>
noremap <silent> <Leader>v :vnew<CR>
noremap <Leader>n :vs

" panel navigation
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k

" tabs and buffers
noremap <Leader>t <ESC>:tabe<CR> " new tab
noremap <c-w> <ESC>:tabc<CR>     " close tab
noremap <Leader>[ <ESC>:tabp<CR> " previous tab
noremap <Leader>] <ESC>:tabn<CR> " next tab
noremap <silent> <Leader>' :ls<CR> " list buffer
noremap <silent> <Leader>, :bp<CR> " previous buffer
noremap <silent> <Leader>. :bn<CR> " next buffer

" Some basics:
nnoremap c "_c
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
        highlight! link DiffText MatchParen
endif
