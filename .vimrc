set nocompatible                    "be iMproved, required

so ~/.vim/plugins.vim               "Source the plugins file

syntax on

set background=dark
set t_Co=256

let g:monokai_term_italic = 1
colorscheme badwolf
filetype indent plugin on


set tabstop=4                       "Indent with 4 spaces https://stackoverflow.com/a/234578/7874784
set shiftwidth=4
set expandtab
set wildmenu

set foldcolumn=2                    "Set foldcolumn to make some space.
hi foldcolumn ctermbg=bg

"set number

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

"--------------Searching-------------"
set hlsearch
set incsearch


"--------------General Mappings-------------"

" Quickly edit the Vimrc file
nmap <leader>ev :tabedit $MYVIMRC<cr>

" Quickly edit the Zshrc file
nmap <leader>ez :tabedit ~/.zshrc<cr>

" Copy the visual selection to the system clipboard. Requires installation of vim-gtk on ubuntu.
" This is not working!
"nmap <leader>m "+y

" Fast save
nmap <leader>w :w<cr>

" Fast quit 
nmap <leader>q :q<cr>

" Remove highlightning
nmap <leader><space> :nohlsearch<cr>

" Execute python files
nmap <leader>p :! python %<cr>

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>

" Remap keys to move around split windows
nmap <C-L> <C-W><C-L>
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
nmap <C-H> <C-W><C-H>


"-----------Plugin Settings-----------"
"\
"\ CtrlP
"\
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

"\
"\ Nerdtree
"\
let NERDTreeHijackNetrw = 0         "Avoid conflicts with vinegar.
nmap <C-B> :NERDTreeToggle<cr>


"-----------Auto-Commands-----------"

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
