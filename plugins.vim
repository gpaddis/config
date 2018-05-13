filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'StanAngeloff/php.vim'
Plugin 'arnaud-lb/vim-php-namespace'
"Plugin 'ervandew/supertab'
Plugin 'stephpy/vim-php-cs-fixer'
"Plugin 'msanders/snipmate.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets' " The snippets for ultisnips

" Disabled for now
"Plugin 'Valloric/YouCompleteMe'

" NOTES
" YouCompleteMe: read the instructions
" https://github.com/Valloric/YouCompleteMe

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

