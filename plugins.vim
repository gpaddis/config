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

" Markdown: check out https://github.com/plasticboy/vim-markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Vimwiki: https://github.com/vimwiki/vimwiki
Plugin 'vimwiki/vimwiki'

" Ruby development
" https://medium.com/@todariasova/rails-vim-101-essential-vim-plugins-for-ruby-on-rails-development-d74e808d186d
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'

" Themes
Plugin 'sonph/onehalf', {'rtp': 'vim/'}

" NOTES
" YouCompleteMe: read the instructions
" https://github.com/Valloric/YouCompleteMe

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

