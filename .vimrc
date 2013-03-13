
" -v-1 Startup
" ------------------------------------------------------------------------
    set nocompatible                            " No vi-compatibility
    filetype off

" -v-1 Vundle
" ------------------------------------------------------------------------
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    " let Vundle manage Vundle
    " required! 
    Bundle 'gmarik/vundle'

  " -v-2 My bundles
  " ----------------------------------------------------------------------
      Bundle 'tpope/vim-fugitive'
      Bundle 'gregsexton/gitv'
      Bundle 'jamessan/vim-gnupg'
      Bundle 'zeekay/vim-lawrencium'
      Bundle 'Lokaltog/vim-powerline'
      Bundle 'mhinz/vim-signify'
      Bundle 'mattn/webapi-vim'
      Bundle 'mattn/gist-vim'

      filetype plugin indent on                 " Set type of file

    " -v-3 Vim powerline
    " --------------------------------------------------------------------
        let g:Powerline_symbols = 'unicode'

    " -v-3 Vim-signify
    " --------------------------------------------------------------------
        let g:signify_sign_overwrite = 1

        let g:signify_mapping_next_hunk = '<leader>gn'
        let g:signify_mapping_prev_hunk = '<leader>gp'

        let g:signify_mapping_toggle_higlight = '<leader>gh'
        let g:signify_mapping_toggle = '<leader>gt'

    " -v-3 gist-vim
    " --------------------------------------------------------------------
        let g:gist_detect_filetype = 1
        let g:gist_open_browser_after_post = 1
        let g:gist_browser_command = 'dwb %URL% &'
        let g:gist_show_privates = 1
        let g:gist_post_private = 1

" -v-1 Moving around, searching and patterns
" ------------------------------------------------------------------------
    imap jj <Esc>
    set autochdir                               " Change to directory of file in buffer
    set incsearch                               " Show match for party typed search command
    set ignorecase                              " Ignore case when using a search pattern
    set smartcase                               " Override 'ignorecase' when pattern has upper case characters

" -v-1 Displaying text
" ------------------------------------------------------------------------
    syntax on                                   " Set syntax highlighting on
    set nowrap                                  " Long lines don't wrap
    set listchars=tab:▸\ ,eol:¬                 " List of strings used for list mode
    set relativenumber                          " Show relaitve line number for each line
    set numberwidth=5                           " Number of colums to use for the line number

" -v-1 Syntax, highlighting and spelling
" ------------------------------------------------------------------------
    "set background=dark                        " Set background color
    set hlsearch                                " Highlight all matches for the last used search pattern
    set cursorcolumn                            " Highlight the column of the cursor
    set cursorline                              " Highlight the line of the cursor
    set colorcolumn=80                          " Highlight the 80th character

    " -v-2 Appearance
    " --------------------------------------------------------------------
      let g:hybrid_use_Xresources = 1
      colorscheme hybrid

" -v-1 Multiple windows
" ------------------------------------------------------------------------
    set laststatus=2                            " When to use a status line for the last window
    set statusline=%(%F%m%r%h%w\%)%=%([TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]%)
      set winwidth=84                             " Basically, all non-focused windows shrink down to ..
      set winheight=5                             " .. five lines and the focused window takes up ..
      set winminheight=5                          " .. everything that's left (so the focused window ..
      set winheight=999                           " .. has at least 84 columns, the others shrink to accomodate).
    set hidden                                  " Don't unload a buffer when no longer shown in a window.
    set splitbelow                              " Open new windows under the current one ..
    set splitright                              " .. or to the right of the current one.

" -v-1 Multiple tag pages
" ------------------------------------------------------------------------
    set showtabline=2                           " When to use a tab pages line
    
" -v-1 Using the mouse
" ------------------------------------------------------------------------
    set mouse=a                                 " List of flags for using the mouse
    set mousehide                               " Hide the mouse pointer while typing

" -v-1 Messages and info
" ------------------------------------------------------------------------
    set shortmess+=I                            " List of flags to make messages shorter
    set showcmd                                 " Show (partial) command keys in the status line
    set ruler                                   " Show cursor position below each window
    set noerrorbells                            " No ringing the bell for error messages
    set novisualbell                            " No visual bell instead of beeping either

" -v-1 Editing text
" ------------------------------------------------------------------------
    set backspace=indent,eol,start              " Specify what backspace and C-w can do in insert mode.
    set formatoptions=rq                        " List of flags how automatic formatting works :help fo-table
    set completeopt=                            " Whether to use a popup menu for insert mode completion
    set infercase                               " Adjust case of a keyword completion match 
    set showmatch                               " When inserting a bracket, briefly highlight the match

" -v-1 Tabs and indenting
" ------------------------------------------------------------------------
    set tabstop=4                               " Number of spaces a <Tab> in the text stands for
    set shiftwidth=4                            " Number of spaces used for each step of (auto)indent
    set shiftround                              " Round to 'shiftwidth' for '<<' and '>>'
    set expandtab                               " Expand <Tab> to spaces in insert mode

" -v-1 Reading and writing files
" ------------------------------------------------------------------------
    set backup                                  " Keep a backup after overwriting a file
    set backupdir=/home/n2o4/.vim/backup        " List of directories to put backup files in

" -v-1 The swap file
" ------------------------------------------------------------------------
    set directory=/home/n2o4/.vim/swap          " List of directories for the swap file

" -v-1 Command line editing
" ------------------------------------------------------------------------
    set history=250                             " How many command lines are remembered
    set wildmode=longest:list,full              " Specifies how command line completion works
    set wildmenu                                " Command-line completion shows a list of matches 

" -v-1 Multi-byte characters
" ------------------------------------------------------------------------
    set encoding=utf-8                          " Character encoding used in Vim

" -v-1 Various
" ------------------------------------------------------------------------
    set gdefault                                " Use the 'g'lobal flag for :substitute

" -v-1 Mappings, auto-commands & abbreviations
" ------------------------------------------------------------------------
  " -v-2 Mappings
  " ----------------------------------------------------------------------
    " -v-3 Leader key settings
    " --------------------------------------------------------------------
      "let mapleader = ","                      " Assign , as mapkey instead of the slower \
      let mapleader = "\<space>"

    " -v-3 Personal mappings
    " --------------------------------------------------------------------
      nmap <leader>l :set list!<cr>             " Quickly toggle 'set list'
      au FileType help nmap <buffer> <CR> <C-]> " Navigate Vim's help with <Enter>

      cmap w!! w !sudo tee >/dev/null %
      nnoremap <leader>ev <C-w><C-v><C-l>:e $MYVIMRC<cr>  " Open .vimrc in a vertical split
      nnoremap <leader>cv <C-w><C-v><C-l>:e ~/.cheatvim.mkd<cr>

    " -v-3 Navigation remaps
    " --------------------------------------------------------------------
      "nnoremap <tab> %                         " Match bracket pairs with <tab>-key because it's ..
      "vnoremap <tab> %                         " .. easier to type than %.

      " Insert \v before any string that is searched for.
      " This turns off Vim's own regex and resorts to normal regexes instead.

      nnoremap / /\v
      vnoremap / /\v
      nnoremap <leader>cls :noh<cr>             " Clear highlighted searches with <leader>cls

      nnoremap <C-j> <C-w>j                     " Easily navigate panes with ctrl-direction
      nnoremap <C-k> <C-w>k
      nnoremap <C-h> <C-w>h
      nnoremap <C-l> <C-w>l

    " -v-3 Tab mappings
    " --------------------------------------------------------------------
      map <leader>tt :tabnew<cr>
      map <leader>te :tabedit
      map <leader>tc :tabclose<cr>
      map <leader>to :tabonly<cr>
      map <leader>tn :tabnext<cr>
      map <leader>tp :tabprevious<cr>
      map <leader>tf :tabfirst<cr>
      map <leader>tl :tablast<cr>
      map <leader>tm :tabmove

    " -v-3 Mappings for the fugitive-plugin
    " --------------------------------------------------------------------
      nnoremap <silent> <leader>gs :Gstatus<cr>
      nnoremap <silent> <leader>gd :Gdiff<cr>
      nnoremap <silent> <leader>gc :Gcommit<cr>
      nnoremap <silent> <leader>gb :Gblame<cr>
      nnoremap <silent> <leader>gl :Glog<cr>
      "nnoremap <silent> <leader>gp :Git push<cr>

    " -v-3 dmenu file searching
    " http://leafo.net/posts/using_dmenu_to_open_quickly.html
    " --------------------------------------------------------------------
      " Strip the newline from the end of a string
      function! Chomp(str)
        return substitute(a:str, '\n$', '', '')
      endfunction

      " Find a file and pass it to cmd
      function! DmenuOpen(cmd)
        let fname = Chomp(system("git ls-files | dmenu -i -l 20 -p " . a:cmd))
        if empty(fname)
          return
        endif
        execute a:cmd . " " . fname
      endfunction

      map <c-t> :call DmenuOpen("tabe")<cr>
      map <c-f> :call DmenuOpen("e")<cr>

  " -v-2 Auto-commands
  " ----------------------------------------------------------------------
    " -v-3 Source .vimrc after saving it
    " --------------------------------------------------------------------
      if has("autocmd")
        autocmd bufwritepost .vimrc source $MYVIMRC
      endif

    " -v-3 Toggle between relative and absolute line numbers
    " --------------------------------------------------------------------
      function! g:ToggleNuMode()
        if(&rnu == 1)
          set nu
        else
          set rnu
        endif
      endfunc

      nnoremap <f5> :call g:ToggleNuMode()<cr>

    " -v-3 Show syntax highlight group with <ctrl>+<shift>+p
    " --------------------------------------------------------------------
      nmap <C-S-P> :call <SID>SynStack()<CR>
      function! <SID>SynStack()
        if !exists("*synstack")
          return
        endif
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
      endfunc

    " -v-3 Only highlight the current line and 80th column of the currently active window
    " --------------------------------------------------------------------
      augroup BgHghlight
        autocmd!
        autocmd WinEnter * set cul colorcolumn=80
        autocmd WinLeave * set nocul colorcolumn=0
      augroup END

" vim: set fmr=-v-,-^- fdm=marker cms="%s" et ts=2 sw=2 sts=2 :
