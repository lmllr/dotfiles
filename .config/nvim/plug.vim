if has("nvim")
  let g:plug_home = stdpath('data') . '/plugged'
endif

call plug#begin()

Plug 'NLKNguyen/papercolor-theme'

Plug 'dstein64/vim-startuptime'
" https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'
" https://github.com/tpope/vim-endwise
" does not work :S
"Plug 'tpope/vim-endwise'
" https://github.com/tpope/vim-rhubarb
"Plug 'tpope/vim-rhubarb'

" NVIM NATIVE LSP SETUP
if has("nvim")
  " Diagnostics
  " https://github.com/neovim/nvim-lspconfig
  Plug 'neovim/nvim-lspconfig'
  " https://github.com/tami5/lspsaga.nvim
  " https://github.com/kkharji/lspsaga.nvim
  Plug 'kkharji/lspsaga.nvim'
  " https://github.com/tree-sitter/tree-sitter
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  " https://github.com/hrsh7th/nvim-cmp
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'onsails/lspkind-nvim'
  " Completion menu
  " -->
  " TODO: https://github.com/hrsh7th/nvim-cmp/wiki/Menu-Appearance#how-to-add-visual-studio-code-dark-theme-colors-to-the-menu
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'

  " XXX TESTS
  " Statusline
  " Plug 'nvim-lualine/lualine.nvim'
  " If you want to have icons in your statusline choose one of these
  Plug 'kyazdani42/nvim-web-devicons'
  " Plug 'kyazdani42/nvim-tree.lua'
  
  " plugin for creating ur own statusline
  Plug 'nvim-lua/lsp-status.nvim'
  Plug 'akinsho/bufferline.nvim'
endif

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Make sure to also install NERD FONTS
" also PICK THE HACK FONT AFTERWADS!
"Plug 'ryanoasis/vim-devicons'

" emmet for vim: http://emmet.io/
Plug 'mattn/emmet-vim'

" vimwiki
" https://github.com/vimwiki/vimwiki
Plug 'vimwiki/vimwiki'

" tcomment_vim
" https://github.com/tomtom/tcomment_vim
Plug 'tomtom/tcomment_vim'

" TESTING TELESCOPE
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" FZF -- Fuzzy Finder
" https://github.com/junegunn/fzf#using-homebrew
" https://github.com/junegunn/fzf.vim
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Search for phrases
" https://github.com/nelstrom/vim-visual-star-search
Plug 'nelstrom/vim-visual-star-search'

" Show signs for changes in git
Plug 'airblade/vim-gitgutter'

call plug#end()

