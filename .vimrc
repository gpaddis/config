set nocompatible                    "be iMproved, required
so ~/.vim/plugins.vim               "Source the plugins file

" Documentation {{{

" Reference:
"   * A good vimrc: https://dougblack.io/words/a-good-vimrc.html. Here are the
"     instructions to structure the .vimrc file in sections.
"   * Vim as a PHP Ide: http://web-techno.net/vim-php-ide/
" 
" Inspiration:
"   * https://gist.github.com/JeffreyWay/6753834
"   * https://github.com/rosetree/tildeslash/blob/master/.vimrc

" }}}
" Visual Settings {{{

syntax on

set background=dark
set t_Co=256

let g:monokai_term_italic = 1
colorscheme badwolf
filetype indent plugin on

set laststatus=2    " Always show the status line.


" }}}
" Spaces & Tabs {{{

set tabstop=4                       "Indent with 4 spaces https://stackoverflow.com/a/234578/7874784
set shiftwidth=4
set expandtab
set wildmenu

set foldcolumn=2                    "Set foldcolumn to make some space.
hi foldcolumn ctermbg=bg

" make YCM compatible with UltiSnips (using supertab)
" https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" }}}
" Searching {{{ 

set hlsearch
set incsearch
set ignorecase " Ignore case, when I search for lowercase patterns.
set smartcase  " Don't ignore case, when I search for uppercase patterns.

" Remove highlightning
noremap <space> :nohlsearch<cr>

" Turn off highlighting automatically when I don't move the cursor for a
" while, then on again when I move it.
autocmd cursorhold * set nohlsearch
autocmd cursormoved * set hlsearch

" }}}
" General Mappings {{{

" With a map leader it's possible to do extra key combinations.
let mapleader = ","

" Quickly edit the Vimrc file
nmap <leader>ev :tabedit $MYVIMRC<cr>

" Quickly edit the Zshrc file
nmap <leader>ez :tabedit ~/.zshrc<cr>

" Copy the visual selection to the system clipboard. Requires installation of vim-gtk on ubuntu.
vnoremap <C-c> "+y

" Exit insert mode
inoremap jj <esc>

" Fast save in normal and insert mode
noremap <leader>w :w<cr>
inoremap <leader>w <esc>:w<cr>

" Fast quit 
nmap <leader>q :q<cr>

" Unfold with +
nmap + za

" Autocomplete brackets
" https://stackoverflow.com/questions/21316727/automatic-closing-brackets-for-vim
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" Toogle paste mode
nmap <leader>pa :set paste<cr>()<left>()<left>()<left>
nmap <leader>pn :set nopaste<cr>()<left>()<left>()<left>

"
" }}}
" PHP {{{

" php-cs-fixer
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.

" Map the fixer commands
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

" Execute PHP files
nmap <leader>ph :w<cr>:! php %<cr>

" Test the current file with phpunit
nmap <leader>t :w<cr>:! phpunit6 --color=auto %<cr>

" }}}
" Bash {{{

" Save and exec a bash script
nmap <leader>sh :w<cr>:! bash %<cr>

" }}}
" Python {{{

" Execute python files
nmap <leader>py :! python %<cr>

" }}}
" Ruby {{{

" Execute Ruby files
nmap <leader>rb :! clear && ruby %<cr>

" Rails: run tests
nmap <leader>rt :! clear && rails test<cr>

" }}}
" Split Management {{{

" Open splits
nmap vs :vsplit<cr>
nmap sp :split<cr>

" Always open splits below and right
set splitbelow
set splitright

" Remap keys to move around split windows
nmap <C-L> <C-W><C-L>
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>
nmap <C-H> <C-W><C-H>

" }}}
" CtrlP {{{

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|project_files$\|test$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$|\.pdf$|\.DS_STORE$' }
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:25'
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0
let g:ctrlp_follow_symlinks=1
"let g:ctrlp_user_command='ag %s -l --nocolor -g ""'                    "You must install silversearcher-ag for this to work.

" Go to symbol in file
nmap <S-R> :CtrlPBufTag<cr>

" Go to symbol in project (requires a ctags -R first)
nmap <C-E> :tag<space> 

" Ignore these files and folders when calling CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*

" }}}
" NERDTree {{{

let NERDTreeHijackNetrw = 0         "Avoid conflicts with vinegar.
let NERDTreeShowHidden = 1          "Show hidden files by default.

nmap <C-B> :NERDTreeToggle<cr>

" }}}a
" UltiSnips {{{

" Edit the snippets
nmap <leader>es :UltiSnipsEdit<cr>

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" Set the snippets directory.
let g:UltiSnipsSnippetsDir = "~/.vim/UltiSnips"

" }}}
" PHP Documentor {{{

let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <leader>d :call pdv#DocumentWithSnip()<cr>

" }}}
" Backups {{{

" Don't keep backups of modified files.
set nobackup
set nowritebackup

" Save swap files in a single directory.
set directory^=$HOME/.vim/tmp//

" Disabled:
" Source: https://dougblack.io/words/a-good-vimrc.html
"set backup
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set backupskip=/tmp/*,/private/tmp/*
"set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set writebackup

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

" This section contains the necessary settings to structure the .vimrc in sections.
set modelines=1
" vim:foldmethod=marker:foldlevel=0
