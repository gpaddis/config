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
Plugin 'stephpy/vim-php-cs-fixer'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets' " The snippets for ultisnips
Plugin 'Valloric/YouCompleteMe'
Plugin 'tobyS/pdv'
Plugin 'tobyS/vmustache'
Plugin 'ervandew/supertab'
Plugin 'dense-analysis/ale'
Plugin 'junegunn/goyo.vim'
Plugin 'mattn/calendar-vim'
Plugin 'tpope/vim-surround' " Easily surround a word with quotes etc.
Plugin 'Yggdroot/indentLine' " Display the indention levels with thin vertical lines
Plugin 'airblade/vim-gitgutter' " Shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks

" Markdown: check out https://github.com/plasticboy/vim-markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Vimwiki: https://github.com/vimwiki/vimwiki
Plugin 'vimwiki/vimwiki'
Plugin 'chazy/dirsettings' " Set specific settings per directory

" Ruby development
" https://medium.com/@todariasova/rails-vim-101-essential-vim-plugins-for-ruby-on-rails-development-d74e808d186d
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'

" Themes
Plugin 'sonph/onehalf', {'rtp': 'vim/'}
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'joshdick/onedark.vim'

" NOTES
" YouCompleteMe: read the instructions
" https://github.com/Valloric/YouCompleteMe

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
