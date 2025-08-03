" Dependencies incase you move the config:
" fd, grep, ripgrep, nodejs, 

" Function to set clipboard (cause it randomly fails on my mac)
function! SetupClipboard()
  " Try setting unnamedplus first set clipboard=unnamedplus

  " Try writing something into the + register
  try
    call setreg('+', 'clipboard-test')
  catch /^Vim\%((\a\+)\)\=:E850/   " E850: register not available
    set clipboard=unnamed
    return
  endtry

  " Check if the + register really got the value
  if getreg('+') !=# 'clipboard-test'
  else
    set clipboard=unnamed
  endif
endfunction

call SetupClipboard()

"
"   Basic keymaps and remaps
"

let mapleader=' '
let maplocalleader=' '

" Set highlight on search, but clear on pressing <Esc> in normal mode
set hlsearch
nnoremap <Esc> :nohlsearch<CR>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

"
" vim-plug 
"

" Script to install vim-plug
 let data_dir = has('nvim') ? stdpath('data') . '/site' : expand('~/.vim')
 if empty(glob(data_dir . '/autoload/plug.vim'))
    echo "downloading vim-plug"
   silent execute '!curl -fLo ' . shellescape(data_dir . '/autoload/plug.vim') . ' --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
 endif

call plug#begin()
" List your plugins here

" UI based plugins
Plug 'menisadi/kanagawa.vim' " most goated theme ever
Plug 'nvim-tree/nvim-web-devicons' " for the visuals
Plug 'Yggdroot/indentLine' " indent lines so i dont lose my eyes
Plug 'vim-airline/vim-airline' " lualine for vim (TODO match colour to lualine config)

" Utility plugins
Plug 'liuchengxu/vim-which-key' " keep forgetting my keymaps (TODO setup whichkey, use kickstart vim if you need help) 

Plug 'airblade/vim-gitgutter' " gitsigns (git)

Plug 'lambdalisue/vim-fern' " nvim tree for better overview of larger projects (TODO give same bindings as nvim-tree)
Plug 'girishji/scope.vim' " fzf (TODO give same bindings as fzf-lua) 

Plug 'justinmk/vim-sneak' " flash nvim alternative 

Plug 'tmsvg/pear-tree' " autopair
Plug 'tpope/vim-surround' " change the text your surrounded by
Plug 'tpope/vim-commentary' " gives me back my gc and gcc from nvim

Plug 'sheerun/vim-polyglot' " treesitter
Plug 'girishji/vimsuggest' " autocomplete for vim cmdline
Plug 'rafamadriz/friendly-snippets' " snippets

Plug 'neoclide/coc.nvim', {'branch': 'release'} " lsp, autocomplete, linting (snippets with :CocInstall coc-snippets) nodejs is a dependency (TODO setup everything)

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' } " for markdown specifically ( to complete installation :call mkdp#util#install() ) (TODO add mappings for whichkey)
Plug 'kaarmu/typst.vim' " typst replacement for latex
Plug 'christoomey/vim-tmux-navigator' " for tmux specifically (tmux side config needed)

call plug#end()

"
"   Plugin configurations
"

" set colorscheme to kanagawa-wave
colorscheme kanagawa

" recreates my settings on neovim kanagawa
highlight SignColumn     ctermbg=NONE guibg=NONE
highlight LineNr         ctermbg=NONE guibg=NONE
highlight VertSplit      ctermbg=NONE guibg=NONE

" Make sneak vim for like flash nvim
let g:sneak#label = 1

" statusline config 
let g:airline_section_a = airline#section#create(['mode']) " vim mode
let g:airline_section_b = airline#section#create_left(['%f']) " file name
let g:airline_section_c = airline#section#create([''])
let g:airline_section_x = airline#section#create([''])
let g:airline_section_y = airline#section#create(['%l:%v']) 
let g:airline_section_z = airline#section#create_right(['filetype'])
let g:airline_section_error = airline#section#create([''])
let g:airline_section_warning = airline#section#create([''])

" whichkey config
call which_key#register('<Space>', 'g:which_key_map')
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey '<Space>'<CR>

" document existing key chains
let g:which_key_map = {}
let g:which_key_map.s = { 'name' : '[S]earch' }
let g:which_key_map.h = { 'name' : 'Git [H]unk' }

" Plug install on VimEnter
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"
"   Settings
"

set nocompatible

set number
set relativenumber

set encoding=UTF-8

set mouse=a

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set nowrap
set ignorecase
set smartcase

set termguicolors
set confirm
set hidden

set updatetime=300

set timeoutlen=500

