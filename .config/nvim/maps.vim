" General "{{{
" ---------------------------------------------------------------------
" map 'jk' to 'ESCAPE'
inoremap jk <ESC>
" map 'CONTROL+n' to nerdtree
" nmap <C-n> :NERDTreeToggle<CR>
nnoremap <C-n> :NvimTreeToggle<CR>
" set NEW EMMET LEADER KEY
let g:user_emmet_leader_key=','
" set GLOBAL LEADER KEY
let mapleader=','

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Press * to search for the term under the cursor or a visual selection and
" then press a key below to replace all instances of it in the current file.
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" The same as above but instead of acting on the whole file it will be
" restricted to the previously visually selected range. You can do that by
" pressing *, visually selecting the range you want it to apply to and then
" press a key below to replace all instances of it in the current selection.
xnoremap <Leader>r :s///g<Left><Left>
xnoremap <Leader>rc :s///gc<Left><Left><Left>

" Type a replacement term and press . to repeat the replacement again. Useful
" for replacing a few instances of the term (comparable to multiple cursors).
nnoremap <silent> s* :let @/='\<'.expand('<cword>').'\>'<CR>cgn
xnoremap <silent> s* "sy:let @/=@s<CR>cgn

" Clear search highlights.
map <Leader><Space> :let @/=''<CR>
"}}}

" Funcs "{{{
" ---------------------------------------------------------------------
" Toggle quickfix window.
function! QuickFix_toggle()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    :execute "copen \| resize 2"
  else
    cclose
  endif
endfunction
nnoremap <silent> <Leader>c :call QuickFix_toggle()<CR>

" show syntax highlighting groups for word under cursor
" use by pressing strg+p
nnoremap <S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction
"}}}

" Tabs "{{{
" ---------------------------------------------------------------------
" Tab navigation like Firefox.
"nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
" special map because of bufferline
nnoremap <C-c>     :bdelete<CR>
nnoremap tn        :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
"}}}

" Splits "{{{
" ---------------------------------------------------------------------
" Cycle through splits.
nnoremap <S-Tab> <C-w>

" Splits
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" Split window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
" Move window
nmap <Space> <C-w>w
map s<left> <C-w>h
map s<up> <C-w>k
map s<down> <C-w>j
map s<right> <C-w>l
" map sh <C-w>h
" map sk <C-w>k
" map sj <C-w>j
" map sl <C-w>l
" Resize window
nmap <C-w><left> <C-w><
nmap <C-w><right> <C-w>>
nmap <C-w><up> <C-w>+
nmap <C-w><down> <C-w>-
"}}}

" vim: set foldmethod=marker foldlevel=0:
