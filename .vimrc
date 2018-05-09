set nocompatible                    "be iMproved, required
so ~/.vim/plugins.vim               "Source the plugins file

" Documentation {{{

" Reference Tutorials
" * A good vimrc: https://dougblack.io/words/a-good-vimrc.html

" }}}
" Colors {{{

syntax on

set background=dark
set t_Co=256

let g:monokai_term_italic = 1
colorscheme badwolf
filetype indent plugin on

" }}}
" Spaces & Tabs {{{

set tabstop=4                       "Indent with 4 spaces https://stackoverflow.com/a/234578/7874784
set shiftwidth=4
set expandtab
set wildmenu

set foldcolumn=2                    "Set foldcolumn to make some space.
hi foldcolumn ctermbg=bg

" This refers to the last line in the .vimrc file, settings specific to this
" file only.
set modelines=1

" }}}
" Searching {{{

set hlsearch
set incsearch

" }}}
" General Mappings {{{

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Quickly edit the Vimrc file
nmap <leader>ev :tabedit $MYVIMRC<cr>

" Quickly edit the Zshrc file
nmap <leader>ez :tabedit ~/.zshrc<cr>

" Copy the visual selection to the system clipboard. Requires installation of vim-gtk on ubuntu.
" This is not working!
" Note: this should be mapped to visual mode!
vnoremap <C-c> "+y

" Fast save
nmap <leader>w :w<cr>

" Fast quit 
nmap <leader>q :q<cr>

" Remove highlightning
nmap <leader><space> :nohlsearch<cr>

" Space unfold
vnoremap <space> za

" }}}
" Python {{{

" Execute python files
nmap <leader>p :! python %<cr>

" }}}
" Split Management {{{

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>

" Remap keys to move around split windows
nmap <C-L> <C-W><C-L>
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
nmap <C-H> <C-W><C-H>

" }}}
" CtrlP {{{

let g:ctrlp_custom_ignore="node_modules\DS_STORE\|git"                 "Ignore these dirs when indexing the files.
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:25'
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0
"let g:ctrlp_user_command='ag %s -l --nocolor -g ""'                    "You must install silversearcher-ag for this to work.

" Go to symbol in file
nmap <C-R> :CtrlPBufTag<cr>

" Go to symbol in project (requires a ctags -R first)
nmap <C-E> :tag<space> 

" Ignore these files and folders when calling CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*

" }}}
" NERDTree {{{

let NERDTreeHijackNetrw = 0         "Avoid conflicts with vinegar.
nmap <C-B> :NERDTreeToggle<cr>

" }}}
" Backups {{{

" Source: https://dougblack.io/words/a-good-vimrc.html
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup

" }}}
" AutoGroups {{{

"Automatically source the Vimrc file on save, clear the augroup each time.
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END

" Automatically adds the corresponding use statement for the name under the cursor.
" This is a feature of vim-php-namespace.
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>A

" Make class or function names fully qualified.
function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>

" }}}

" This is to structure the .vimrc file in sections.
" vim:foldmethod=marker:foldlevel=0
