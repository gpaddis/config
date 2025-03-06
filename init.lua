-- init.lua
-- Neovim configuration converted from .vimrc

-- Documentation --
-- Reference:
--   * Original vimrc based on: https://dougblack.io/words/a-good-vimrc.html
--   * Vim as a PHP Ide: http://web-techno.net/vim-php-ide/
--
-- Inspiration:
--   * https://gist.github.com/JeffreyWay/6753834
--   * https://github.com/rosetree/tildeslash/blob/master/.vimrc

-- Basic Settings --
vim.opt.compatible = false -- be improved, required

-- Plugin Management --
-- Using packer.nvim instead of Vundle
-- Make sure to install packer first:
-- https://github.com/wbthomason/packer.nvim#quickstart
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes) ") ~= "y" then
    return
  end

  local directory = string.format(
    '%s/site/pack/packer/opt/',
    vim.fn.stdpath('data')
  )

  vim.fn.mkdir(directory, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  ))

  print(out)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- Packer can manage itself
  use {'wbthomason/packer.nvim', opt = true}

  -- Original plugins converted
  use 'vimwiki/vimwiki'
  use 'plasticboy/vim-markdown'
  use 'dense-analysis/ale'
  use 'mattn/calendar-vim'
  use 'airblade/vim-gitgutter'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'dyng/ctrlsf.vim'
  use 'scrooloose/nerdtree'
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install'}
  use 'Luxed/ayu-vim'
  use 'tpope/vim-rails'
  use 'Raimondi/delimitMate'
  use 'vim-ruby/vim-ruby'
  use 'rust-lang/rust.vim'
  use 'thoughtbot/vim-rspec'
end)

-- Visual Settings --
vim.opt.syntax = 'on'
vim.opt.filetype = 'on'
vim.cmd('filetype plugin indent on')

-- Terminal colors
if vim.fn.has('termguicolors') == 1 then
  vim.opt.termguicolors = true
end

-- This configuration is not working after the conversion to lua
-- if vim.env.TERM:find('256color') and (vim.env.TERM:find('^screen') or vim.env.TERM:find('^tmux')) then
--   vim.opt.t_8f = "\\<Esc>[38;2;%lu;%lu;%lum"
--   vim.opt.t_8b = "\\<Esc>[48;2;%lu;%lu;%lum"
-- end

vim.opt.background = 'dark'
vim.opt.termguicolors = true
vim.g.ayucolor = 'mirage'
vim.cmd('colorscheme ayu')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

vim.opt.laststatus = 2  -- Always show the status line

-- Markdown syntax
vim.g.vim_markdown_folding_disabled = 1
vim.opt.conceallevel = 2

-- Indentline options
vim.g.indentLine_enabled = 0
vim.g.indentLine_char = '▏'

vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_filetypes = {'markdown', 'vimwiki'}

-- Default was 4 seconds, this gives a quicker response for vim-gitgutter
vim.opt.updatetime = 1000

-- Neovim-specific Settings --
-- Most of this section is already handled by default in Neovim

-- Set a bigger font size for GUI
vim.opt.guifont = 'Menlo Regular:h14'

-- Spaces & Tabs --
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.linebreak = true
vim.opt.wildmenu = true
vim.opt.backspace = 'indent,eol,start'
vim.opt.list = true
vim.opt.listchars = {tab = '  ', trail = '·'}

-- Searching --
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true  -- Ignore case, when I search for lowercase patterns
vim.opt.smartcase = true   -- Don't ignore case, when I search for uppercase patterns

-- Set color column
vim.opt.colorcolumn = '+1'

-- General Mappings --
-- Set leader key
vim.g.mapleader = ','

-- Remove highlighting with space
vim.api.nvim_set_keymap('n', '<space>', ':nohlsearch<cr>', {noremap = true, silent = true})

-- Replace text in visual selection
vim.api.nvim_set_keymap('v', '<C-r>', '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>', {noremap = true})

-- Turn off highlighting automatically when I don't move the cursor for a while, then on again when I move it
vim.cmd([[
  autocmd CursorHold * set nohlsearch
  autocmd CursorMoved * set hlsearch
]])

-- Quickly edit the init.lua file
vim.api.nvim_set_keymap('n', '<leader>ev', ':tabedit $MYVIMRC<cr>', {noremap = true})

-- Quickly edit the Zshrc file
vim.api.nvim_set_keymap('n', '<leader>ez', ':tabedit ~/.zshrc<cr>', {noremap = true})

-- Copy the visual selection to the system clipboard
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', {noremap = true})

-- Exit insert mode
vim.api.nvim_set_keymap('i', 'jj', '<esc>', {noremap = true})

-- Fast save in normal and insert mode
vim.api.nvim_set_keymap('n', '<leader>w', ':w<cr>', {noremap = true})
vim.api.nvim_set_keymap('i', '<leader>w', '<esc>:w<cr>', {noremap = true})

-- Fast quit
vim.api.nvim_set_keymap('n', '<leader>q', ':q<cr>', {noremap = true})

-- Unfold with +
vim.api.nvim_set_keymap('n', '+', 'za', {noremap = true})

-- Open the current file in Gitlab
vim.api.nvim_set_keymap('n', '<leader>gl', ':!open-in-gitlab.sh %<cr>', {noremap = true})

-- Bold and italics
vim.api.nvim_set_keymap('i', '<C-b>', '**<left>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-v>', '__<left>', {noremap = true})

-- Toggle paste mode
vim.api.nvim_set_keymap('n', '<leader>pa', ':set invpaste<cr>', {noremap = true})

-- Calculate the result of an expression
vim.api.nvim_set_keymap('i', '<C-A>', '<C-O>yiW<End>=<C-R>=<C-R>0<CR>', {noremap = true})

-- Macros --
-- Make a markdown (link)[]
vim.fn.setreg('k', 'bi[lxea](a')

-- NERDTree --
vim.g.NERDTreeHijackNetrw = 0
vim.g.NERDTreeShowHidden = 1

vim.api.nvim_set_keymap('n', '<C-B>', ':NERDTreeToggle<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>f', ':NERDTreeFind<cr>', {noremap = true})

-- PHP --
-- Execute PHP files
vim.api.nvim_set_keymap('n', '<leader>ph', ':w<cr>:! php %<cr>', {noremap = true})

-- Test the current file with phpunit
vim.api.nvim_set_keymap('n', '<leader>t', ':w<cr>:! phpunit6 --color=auto %<cr>', {noremap = true})

-- Rust --
-- Autoformat rust code on save
vim.g.rustfmt_autosave = 1

-- Run a Rust script
vim.api.nvim_set_keymap('n', '<leader>rs', ':RustRun<cr>', {noremap = true})

-- Bash --
-- Save and exec a bash script
vim.api.nvim_set_keymap('n', '<leader>sh', ':w<cr>:! bash %<cr>', {noremap = true})

-- Python --
-- Execute python files
vim.api.nvim_set_keymap('n', '<leader>py', ':! pipenv run python %<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>pt', ':! py.test<cr>', {noremap = true})

vim.g.ale_fixers = {
  python = {'black'},
}

-- Ruby --
-- Execute Ruby files
vim.api.nvim_set_keymap('n', '<leader>rb', ':! clear && ruby %<cr>', {noremap = true})

-- Set the ruby syntax in rbs files
vim.cmd([[
  autocmd BufNewFile,BufRead *.rbs set syntax=ruby
]])

-- RSpec.vim mappings
vim.api.nvim_set_keymap('n', '<Leader>rt', ':call RunCurrentSpecFile()<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>rl', ':call RunNearestSpec()<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>ry', ':call RunLastSpec()<CR>', {})
vim.api.nvim_set_keymap('n', '<Leader>ra', ':call RunAllSpecs()<CR>', {})

vim.g.rspec_command = "!bundle exec rspec {spec}"

-- ALE --
-- Autofix errors
vim.api.nvim_set_keymap('n', '<leader>af', ':ALEFix<cr>', {noremap = true})

-- https://github.com/dense-analysis/ale#2ii-fixing
vim.g.ale_fixers = {
  ['*'] = {'remove_trailing_lines', 'trim_whitespace'},
  ruby = {'rubocop'},
  php = {'php_cs_fixer'},
  python = {'black'},
}

-- Set this variable to 1 to fix files when you save them.
vim.g.ale_fix_on_save = 1

-- Split Management --
-- Open splits
vim.api.nvim_set_keymap('n', 'vs', ':vsplit<cr>', {noremap = true})
vim.api.nvim_set_keymap('n', 'sp', ':split<cr>', {noremap = true})

-- Always open splits below and right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Remap keys to move around split windows
vim.api.nvim_set_keymap('n', '<C-L>', '<C-W><C-L>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-K>', '<C-W><C-K>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-J>', '<C-W><C-J>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-H>', '<C-W><C-H>', {noremap = true})

-- VimWiki --
vim.g.vimwiki_list = {{path = '~/vimwiki/'}}
vim.g.vimwiki_auto_chdir = 1
vim.g.vimwiki_markdown_link_ext = 1

-- Load local wikis if available
local local_wikis_path = vim.fn.expand('~/.config/nvim/lua/local_wikis.lua')
local local_wikis_exists = vim.fn.filereadable(local_wikis_path) == 1

if local_wikis_exists then
  require('local_wikis')
end

-- GOTO page
vim.api.nvim_set_keymap('n', '<leader>wg', ':VimwikiGoto<space>', {noremap = true})

-- Add an empty checkbox in insert mode
vim.api.nvim_set_keymap('i', '<C-Space>', '- [ ]<space>', {noremap = true})

-- CtrlSF --
-- https://github.com/dyng/ctrlsf.vim
vim.api.nvim_set_keymap('n', '<C-F>f', '<Plug>CtrlSFPrompt', {})
vim.api.nvim_set_keymap('v', '<C-F>f', '<Plug>CtrlSFVwordPath', {})
vim.api.nvim_set_keymap('v', '<C-F>F', '<Plug>CtrlSFVwordExec', {})
vim.api.nvim_set_keymap('n', '<C-F>n', '<Plug>CtrlSFCwordPath', {})
vim.api.nvim_set_keymap('n', '<C-F>p', '<Plug>CtrlSFPwordPath', {})
vim.api.nvim_set_keymap('n', '<C-F>o', ':CtrlSFOpen<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-F>t', ':CtrlSFToggle<CR>', {noremap = true})
vim.api.nvim_set_keymap('i', '<C-F>t', '<Esc>:CtrlSFToggle<CR>', {noremap = true})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-P>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Go to symbol in file
vim.api.nvim_set_keymap('n', '<S-R>', ':CtrlPBufTag<cr>', {noremap = true})

-- Go to symbol in project (requires a ctags -R first)
vim.api.nvim_set_keymap('n', '<C-E>', ':tag<space>', {noremap = true})

-- Ignore these files and folders when calling CtrlP
vim.opt.wildignore:append('*/tmp/*,*.so,*.swp,*.zip,*/.git/*')

-- Backups --
-- Don't keep backups of modified files.
vim.opt.backup = false
vim.opt.writebackup = false

-- Save swap files in a single directory.
vim.opt.directory = vim.fn.expand('$HOME/.config/nvim/tmp//')

-- Autoreload the file on changes.
vim.opt.autoread = true
vim.cmd([[
  au CursorHold * checktime
]])

-- AutoGroups --
-- Automatically source the init.lua file on save
vim.cmd([[
  augroup autosourcing
    autocmd!
    autocmd BufWritePost init.lua source %
  augroup END
]])

-- Automatically adds the corresponding use statement for the name under the cursor.
-- This is a feature of vim-php-namespace.
vim.cmd([[
  function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
  endfunction
  autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
  autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>A
]])

-- Make class or function names fully qualified.
vim.cmd([[
  function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
  endfunction
  autocmd FileType php inoremap <Leader>e <Esc>:call IPhpExpandClass()<CR>
  autocmd FileType php noremap <Leader>e :call PhpExpandClass()<CR>
]])

-- Auto-create the full path to a new file if the directory does not exist.
vim.cmd([[
  function! s:MkNonExDir(file, buf)
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
]])
