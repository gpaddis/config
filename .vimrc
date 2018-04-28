set nocompatible              " be iMproved, required

so ~/.vim/plugins.vim

syntax on

set background=dark
set t_Co=256

let g:monokai_term_italic = 1
colorscheme monokai

filetype indent plugin on


" Indent with 4 spaces
" https://stackoverflow.com/a/234578/7874784
set tabstop=4
set shiftwidth=4
set expandtab

" set number

"--------------Searching-------------"
set hlsearch
set incsearch

"--------------Split Management-------------"
nmap <C-L> <C-W><C-L>
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
nmap <C-H> <C-W><C-H>

"--------------Mappings-------------"

" Make it easy to edit the Vimrc file
nmap ,ev :tabedit $MYVIMRC<cr>

nmap ,<space> :nohlsearch<cr>

" Toggle NERDTree
nmap <C-B> :NERDTreeToggle<cr>

" Execute python files
nmap ,p :! python %<cr>

"CtrlP go to symbol
nmap <C-R> :CtrlPBufTag<cr>

" Go to symbol in project (requires a ctags -R first)
nmap <S-R> :tag<space> 

" Close the file
nmap <C-W> :q<cr>

"-----------Plugin Settings-----------"
" CtrlP
let g:ctrlp_custom_ignore="node_modules\DS_STORE\|git"

" Nerdtree
let NERDTreeHijackNetrw = 0


"-----------Auto-Commands-----------"

"Automatically source the Vimrc file on save, clear the augroup each time.
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END
