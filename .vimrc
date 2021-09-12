set nocompatible                    "be iMproved, required

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
" Plugins {{{
"
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'plasticboy/vim-markdown'
Plugin 'dense-analysis/ale'
Plugin 'mattn/calendar-vim'
Plugin 'airblade/vim-gitgutter' " Shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dyng/ctrlsf.vim' " Pretty search in current project directory or wiki
Plugin 'scrooloose/nerdtree'
Plugin 'iamcco/markdown-preview.nvim'
Plugin 'joshdick/onedark.vim'
Plugin 'ayu-theme/ayu-vim'
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'thoughtbot/vim-rspec'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" }}}
" Visual Settings {{{

syntax on

filetype indent plugin on

" https://vi.stackexchange.com/a/20284
if &term =~# '256color' && ( &term =~# '^screen' || &term =~# '^tmux' )
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set background=dark
set t_Co=256
set termguicolors
let ayucolor="mirage"
colorscheme ayu

set number

set laststatus=2    " Always show the status line.

" Markdown syntax
" https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled = 1
set conceallevel=2

" Indentline options
let g:indentLine_enabled = 0
let g:indentLine_char = '▏'

let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_filetypes = ['markdown', 'vimwiki']

" Default was 4 seconds, this gives a quicker response for vim-gitgutter
set updatetime=1000

" }}}
" Neovim & Macvim-specific Settings {{{

if (has("nvim"))
"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Set a bigger font size for Macvim.
" https://stackoverflow.com/a/9206382
set guifont=Menlo\ Regular:h14

" }}}
" Spaces & Tabs {{{

set tabstop=4                       "Indent with 4 spaces https://stackoverflow.com/a/234578/7874784
set shiftwidth=4
set expandtab
set linebreak
set wildmenu
set backspace=indent,eol,start
set list listchars=tab:\ \ ,trail:·


" }}}
" Searching {{{

set hlsearch
set incsearch
set ignorecase " Ignore case, when I search for lowercase patterns.
set smartcase  " Don't ignore case, when I search for uppercase patterns.

" Remove highlightning
noremap <space> :nohlsearch<cr>

" Replace text in visual selection
" https://stackoverflow.com/a/676619
vnoremap <C-r> "hy:%s/<C-r>h/<C-r>h/gc<left><left><left>

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

" bold and italics
inoremap <C-b> **<left>
inoremap <C-v> __<left>

" Toogle paste mode
nmap <leader>pa :set invpaste<cr>

" }}}
" {{{ Macros

" Make a markdown (link)[]
let @k="bi[lxea](a"

" }}}
" NERDTree {{{

let NERDTreeHijackNetrw = 0         "Avoid conflicts with vinegar.
let NERDTreeShowHidden = 1          "Show hidden files by default.

nmap <C-B> :NERDTreeToggle<cr>
nmap <leader>f :NERDTreeFind<cr>

" }}}
" PHP {{{

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
nmap <leader>py :! python3 %<cr>
nmap <leader>pt :! py.test<cr>

" }}}
" Ruby {{{

" Execute Ruby files
nmap <leader>rb :! clear && ruby %<cr>

" Set the ruby syntax in rbs files
autocmd BufNewFile,BufRead *.rbs set syntax=ruby

" RSpec.vim mappings
map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rl :call RunNearestSpec()<CR>
map <Leader>ry :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>

let g:rspec_command = "!bundle exec rspec 2>/dev/null {spec}"

" }}}
" ALE {{{

" Autofix errors
"noremap <leader>f :ALEFix<cr>

" https://github.com/dense-analysis/ale#2ii-fixing
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'ruby': ['rubocop'],
\   'php': ['php_cs_fixer'],
\   'python': ['black'],
\}

" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

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
" VimWiki {{{

let default_wiki = {'path': '~/vimwiki/'}

let g:vimwiki_list = [default_wiki]
let g:vimwiki_auto_chdir = 1
let g:vimwiki_markdown_link_ext = 1 " See https://github.com/vimwiki/vimwiki/pull/529/files

" Add other local wikis in local_wikis.vim like this:
"
" let personal_wiki = {'path': '~/personal_wiki/'}
" let g:vimwiki_list = add(g:vimwiki_list, personal_wiki)
"
" Then select the one you want with <leader>ws
" or go to the second like 2<leader>ww
"
" glob: see https://vi.stackexchange.com/a/11572
if glob('~/.vim/local_wikis.vim')!=#""
    source ~/.vim/local_wikis.vim
endif

" GOTO page
nmap <leader>wg :VimwikiGoto<space>

" Add an empty checkbox in insert mode
inoremap <C-Space> - [ ]<space>

" }}}
" CtrlSF {{{

" https://github.com/dyng/ctrlsf.vim
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

" }}}
" CtrlP {{{

let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|public$\|vendor$\|project_files$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$|\.pdf$|\.DS_STORE$' }
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:25'
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path_mode=0
let g:ctrlp_follow_symlinks=1
let g:ctrlp_show_hidden = 1
"let g:ctrlp_user_command='ag %s -l --nocolor -g ""'                    "You must install silversearcher-ag for this to work.

" Go to symbol in file
nmap <S-R> :CtrlPBufTag<cr>

" Go to symbol in project (requires a ctags -R first)
nmap <C-E> :tag<space>

" Ignore these files and folders when calling CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.git/*

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

" Autoreload the file on changes.
set autoread
au CursorHold * checktime

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

" Auto-create the full path to a new file if the directory does not exist.
" https://stackoverflow.com/a/4294176
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" }}}

" This section contains the necessary settings to structure the .vimrc in sections.
set modelines=1
" vim:foldmethod=marker:foldlevel=0
