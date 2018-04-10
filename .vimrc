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


"--------------Mappings-------------"

" Make it easy to edit the Vimrc file
nmap ,ev :tabedit $MYVIMRC<cr>
nmap ,<space> :nohlsearch<cr>

" Execute python files
nmap ,p :! python %<cr>


"-----------Auto-Commands-----------"

"Automatically source the Vimrc file on save, clear the augroup each time.
augroup autosourcing
    autocmd!
    autocmd BufWritePost .vimrc source %
augroup END
