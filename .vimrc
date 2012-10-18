" .vimrc 18.10.2012

call pathogen#infect()
syntax on
filetype plugin indent on
let g:Powerline_symbols = 'unicode'

set nocompatible
set showtabline=2
set mouse=a
set background=dark

set tabstop=8
set shiftwidth=4
set softtabstop=4
set expandtab

set encoding=utf-8
set showmatch
set showcmd
set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.
set novisualbell
set cursorline
set ruler
set backspace=indent,eol,start
set relativenumber
set numberwidth=5

set backup
set backupdir=/home/n2o4/.vim/backup
set directory=/home/n2o4/.vim/swap

set autochdir
set cursorcolumn
set noerrorbells

" Set status line
:set statusline=%(%F%m%r%h%w\%)%=%([TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]%)
:set laststatus=2

" Insert \v before any string that is searched for.
" This turns off Vim's regex and turns on normal regexes.
nnoremap / /\v
vnoremap / /\v

set completeopt=
set nowrap
set formatoptions=rq                " :help fo-table
set ignorecase                      " All lowercase searches will be case-insensitive.
set smartcase                       " Case-sensitive searches if one more uppercase characters.
set gdefault                        " Substitutions are applied globally with :%s/foo/bar
set incsearch                       " Highlight search results.
set showmatch                       " Clear highlighted searches with <leader><space>
set infercase
set shiftround

nnoremap <f5> :call g:ToggleNuMode()<cr>

" Näytä syntaksikorostusryhmä Ctrl+shift+P-yhdistelmällä
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

let mapleader = ","

" Näppäinoikotiet
imap jj <Esc>

nnoremap <leader><space> :noh<cr>   " Clear highlighted searches with <leader><space>
"nnoremap <tab> %                    " Match bracket pairs with <tab>-key because it's ..
"vnoremap <tab> %                    " .. easier to type than %.
nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>  " Open .vimrc in a vertical split

" Tab mappings.
map <leader>tt :tabnew<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
map <leader>tm :tabmove

" Toggle between relative and absolute line numbers
function! g:ToggleNuMode()
    if(&rnu == 1)
        set nu
    else
        set rnu
    endif
endfunc

nnoremap <f5> :call g:ToggleNuMode()<cr>
