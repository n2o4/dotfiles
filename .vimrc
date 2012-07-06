" n2o4 .vimrc 05.04.2012

" toggle between relative and absolute line numbers
function! g:ToggleNuMode()
	if(&rnu == 1)
		set nu
	else
		set rnu
	endif
endfunc

nnoremap <f5> :call g:ToggleNuMode()<cr>

set showtabline=2
set mouse=a
set nocompatible
set background=dark
syntax on

set backup
set backupdir=/home/n2o4/.vim/backup
set directory=/home/n2o4/.vim/swap

filetype plugin indent on
set autochdir
set backspace=indent,eol,start

set cursorcolumn
set cursorline
set novisualbell
set noerrorbells

" Set status line
:set statusline=%(%F%m%r%h%w\%)%=%([TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]%)
:set laststatus=2

set showcmd
set showmatch
set ruler
set number
set numberwidth=5

set completeopt=
set nowrap
set expandtab
set formatoptions=rq
set ignorecase
set infercase
set shiftround
set smartcase
set shiftwidth=4
set softtabstop=4
set tabstop=8

nnoremap <f5> :call g:ToggleNuMode()<cr>

" Show syntax highlighting group with ctrl+shift+P-combo
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Some quick shortcuts 
imap jj <Esc>
imap ,t <Esc>:tabnew<CR>
