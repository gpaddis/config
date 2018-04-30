set nocompatible                    "be iMproved, required

so ~/.vim/plugins.vim               "Source the plugins file

syntax on

set background=dark
set t_Co=256

let g:monokai_term_italic = 1
colorscheme monokai

filetype indent plugin on


set tabstop=4                       "Indent with 4 spaces https://stackoverflow.com/a/234578/7874784
set shiftwidth=4
set expandtab

"set number

"--------------Searching-------------"
set hlsearch
set incsearch


"--------------General Mappings-------------"

" Make it easy to edit the Vimrc file
nmap ,ev :tabedit $MYVIMRC<cr>
"No highlightning
nmap ,<space> :nohlsearch<cr>

" Execute python files
nmap ,p :! python %<cr>

"Remap keys to move around split windows
nmap <C-L> <C-W><C-L>
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
nmap <C-H> <C-W><C-H>


"-----------Plugin Settings-----------"
"\
"\ CtrlP
"\
let g:ctrlp_custom_ignore="node_modules\DS_STORE\|git"                 "Ignore these dirs when indexing the files.
"Go to symbol in file
nmap <C-R> :CtrlPBufTag<cr>
" Go to symbol in project (requires a ctags -R first)
nmap <S-R> :tag<space> 

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
