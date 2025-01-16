" skip backwards compatibility w/ vi to enable modern features
set nocompatible

" Need to set the leader before defining any leader mappings
let mapleader = ","

" https://github.com/tomasiser/vim-code-dark?tab=readme-ov-file#installation
colorscheme codedark

" Status etc
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set laststatus=2  " Always display the status line

" Safety net
set nobackup
set nowritebackup
set history=500

" TODO: find out what this does
set backspace=2   " Backspace deletes like most programs in insert mode

" Quickly edit or reload this config file
nnoremap <leader>erc :edit $MYVIMRC<CR>
nnoremap <leader>rrc :source $MYVIMRC<CR>

" Automatically save when changing context
set autowrite     " Automatically :write before running commands

" Use spacebar to page up and down
nnoremap <Space> <PageDown>zz
nnoremap <C-b> <PageUp>zz
"nnoremap <Shift-Space> <PageUp>  " this requires remapping at OS level

" Switch syntax highlighting on, when the terminal has colors
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
    syntax on
endif
set hlsearch
" Turn off search highlight by pressing return
nnoremap <silent> <CR> :noh<CR>
set incsearch
set ignorecase
set smartcase

" Center vertically when selecting search results
" https://stackoverflow.com/questions/39892498/center-cursor-position-after-search-in-vim
cnoremap <silent><expr> <enter> index(['/', '?'], getcmdtype()) >= 0 ? '<enter>zz' : '<enter>'
nmap * *zz
nmap # #zz
nmap n nzz
nmap N Nzz

" replace text everywhere or in selection
nnoremap <leader>sub :%s///g<left><left><left>
vnoremap <leader>sub :s///g<left><left><left>

" Highlight the preferred line length
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set relativenumber

filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
scriptencoding utf-8
set encoding=utf-8
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" simplify split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" more natural split opening
set splitbelow
set splitright

" Bind `q` to close the buffer for help files
autocmd Filetype help nnoremap <buffer> q :q<CR>

augroup vimrcEx
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" add FZF to runtime path
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf

" Map Ctrl + p to open fuzzy find (FZF)
" nnoremap <c-p> :Files<cr>

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif

" Force shell to /bin/bash to avoid E484 can't find tmp files in /var/folders/*
set shell=/bin/bash

" vim:ft=vim
