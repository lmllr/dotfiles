" Fundamentals "{{{
" ---------------------------------------------------------------------

" init autocmd
autocmd!
" set script encoding
scriptencoding utf-8
" stop loading config if it's on tiny or small
if !1 | finish | endif

" always save to clipboard
set clipboard=unnamedplus
set nocompatible
set noswapfile
" set textwidth=80
set expandtab " convert tabs to spaces
set shiftwidth=2 " when shifting, indent using two spaces
set tabstop=2 " indent using *2 spaces
"set tabstop=4
"set tabstop=8

" set listchars=tab:> ,trail:-,nbsp:+,eol:↩︎
set autoindent " new lines inherit the indentation of precious lines
set number
syntax enable
set fileencodings=utf-8,sjis,euc-jp,latin
set encoding=utf-8
set title
set autoindent
set nobackup
set nowritebackup
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set hlsearch
set incsearch " show search results as you type
set ignorecase " ignore case in search
set smartcase " auto switch search to case-sensitive when search query contains uppercase letter
set showcmd
set cmdheight=1
set laststatus=2
set scrolloff=10
set expandtab
"let loaded_matchparen = 1
set shell=zsh
set backupskip=/tmp/*,/private/tmp/*

" incremental substitution (neovim)
if has('nvim')
  set inccommand=split
endif

" Suppress appending <PasteStart> and <PasteEnd> when pasting
set t_BE=

set nosc noru nosm
" Don't redraw while executing macros (good performance config)
set lazyredraw
"set showmatch
" How many tenths of a second to blink when matching brackets
"set mat=2
" Ignore case when searching
set ignorecase
" Be smart when using tabs ;)
set smarttab
" indents
filetype plugin indent on
set shiftwidth=2
"set foldcolumn=4 " this will change space next to line numbers
set tabstop=2
set ai "Auto indent
set si "Smart indent 
set wrap linebreak nolist "Wrap lines
" set nowrap "No Wrap lines
set backspace=start,eol,indent
" Finding files - Search down into subfolders
set path+=**
set wildignore+=*/node_modules/*

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" Add asterisks in block comments
set formatoptions+=r

"}}}

" Fzf -- Ripgrep -- Setup "{{{
" Ctrl+P to enter FUZZY FINDER
" nmap <silent><C-p> :Files<CR>

" set grep to use RIPGREP
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

" Side note: FZF.vim :Rg option also searches for file name in addition to
" the phrase. If you think this is an issue, check out this comment.
" I added this in my .vimrc:
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
"   https://github.com/junegunn/fzf/wiki/Color-schemes
let g:fzf_colors =
\ { 'fg':         ['fg', 'Comment'],
  \ 'preview-fg': ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'hl':         ['fg', 'Search'],
  \ 'fg+':        ['fg', 'Normal'],
  \ 'bg+':        ['bg', 'StatusLine'],
  \ 'gutter':     ['bg', 'Normal'],
  \ 'hl+':        ['fg', 'Search'],
  \ 'info':       ['fg', 'Comment'],
  \ 'border':     ['fg', 'Comment'],
  \ 'prompt':     ['fg', 'Identifier'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Special'],
  \ 'spinner':    ['fg', 'Underlined'],
  \ 'header':     ['fg', 'Statement'] }

" This is the default option:
"   - Preview window on the right with 50% width
"   - CTRL-/ will toggle preview window.
" - Note that this array is passed as arguments to fzf#vim#with_preview function.
" - To learn more about preview window options, see `--preview-window` section of `man fzf`.
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" - Window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }
let g:fzf_layout = { 'window': '20new' }
" - down / up / left / right
let g:fzf_layout = { 'down': '40%' }

" hide fzf statusline
" autocmd!  FileType fzf set laststatus=0 noshowmode noruler
"   \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'

function! s:fzf_statusline()
  " Override statusline as you like
  "highlight fzf1 ctermfg=NONE ctermbg=3 guifg=NONE guibg=#FFA657
  "highlight fzf2 ctermfg=NONE ctermbg=0 guifg=NONE guibg=#0D1117
  "highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#Search#\ Search%#
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
"}}}

" Autocommands "{{{

" Auto-resize splits when Vim gets resized.
autocmd VimResized * wincmd =

"}}} 

" Highlights "{{{
" ---------------------------------------------------------------------
set cursorline
"set cursorcolumn

" Set cursor line color on visual mode
" highlight Visual cterm=NONE ctermbg=236 ctermfg=NONE guibg=Grey40
"
" highlight LineNr cterm=none ctermfg=240 guifg=#2b506e guibg=#000000
"
" augroup BgHighlight
"   autocmd!
"   autocmd WinEnter * set cul
"   autocmd WinLeave * set nocul
" augroup END
"
" if &term =~ "screen"
"   autocmd BufEnter * if bufname("") !~ "^?[A-Za-z0-9?]*://" | silent! exe '!echo -n "\ek[`hostname`:`basename $PWD`/`basename %`]\e\\"' | endif
"   autocmd VimLeave * silent!  exe '!echo -n "\ek[`hostname`:`basename $PWD`]\e\\"'
" endif

"}}}

" File types "{{{
" ---------------------------------------------------------------------
" JavaScript
" au BufNewFile,BufRead *.es6 setf javascript
" TypeScript
" au BufNewFile,BufRead *.tsx setf typescriptreact
" Markdown
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.mdx set filetype=markdown
" Flow
" au BufNewFile,BufRead *.flow set filetype=javascript
" Fish
"au BufNewFile,BufRead *.fish set filetype=fish
" go
" does not work anymore with nvim8
"autocmd BufNewFile,BufRead *.go lua vim.lsp.buf.format()
autocmd BufWritePre *.go lua goimports(1000)
autocmd BufNewFile,BufRead *.go lua goimports(1000)
" treat syntax highlighting of `*.gohtml` file extension as `html`
autocmd BufNewFile,BufRead *.gohtml set filetype=html

set suffixesadd=.js,.es,.jsx,.json,.css,.less,.sass,.styl,.php,.py,.md

autocmd FileType go setlocal shiftwidth=8 tabstop=8
autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

"}}}

" Imports "{{{
" ---------------------------------------------------------------------
runtime ./plug.vim
" if has("unix")
"   let s:uname = system("uname -s")
"   " Do Mac stuff
"   if s:uname == "Darwin\n"
"     runtime ./macos.vim
"   endif
" endif

runtime ./maps.vim
"}}}

" Syntax theme "{{{
" ---------------------------------------------------------------------

" true color
if exists("&termguicolors") && exists("&winblend")
  syntax enable
  set termguicolors
  set winblend=0
  set wildoptions=pum
  set pumblend=5
  " Use NeoSolarized
  set background=dark
  let g:neosolarized_termtrans=1
  runtime ./colors/NeoSolarized.vim
  colorscheme NeoSolarized
  
  " Use PaperColor
  " set background=light
  " colo PaperColor
endif

"}}}

" Netrw (FILEBROWSER) setup "{{{
" ---------------------------------------------------------------------
" There are 4 different view types:
"   1. thin
"   2. long
"   3. wide
"   4. tree
let g:netrw_liststyle = 3

" Changing how files are opened
" 1 - open files in a new horizontal split
" 2 - open files in a new vertical split
" 3 - open files in a new tab
" 4 - open in previous window
let g:netrw_browse_split = 3

" Set the width of the directory explorer
let g:netrw_winsize = 25

" Removing the banner
" let g:netrw_banner = 0

" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

"}}}

" Extras "{{{
" ---------------------------------------------------------------------
set exrc
"}}}

" vim: set foldmethod=marker foldlevel=0:
