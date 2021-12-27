if !exists('g:loaded_lspsaga') | finish | endif

" lua << EOF
" local lspsaga = require 'lspsaga'
"
" lspsaga.setup { -- defaults ...
"   error_sign = '',
"   warn_sign = '',
"   hint_sign = '',
"   infor_sign = '',
"   border_style = "round",
" }
" EOF

lua << EOF
local lspsaga = require 'lspsaga'
lspsaga.setup { -- defaults ...
  debug = false,
  use_saga_diagnostic_sign = true,
  -- diagnostic sign
  error_sign = "",
  warn_sign = "",
  hint_sign = "",
  infor_sign = "",
  diagnostic_header_icon = "   ",
  -- code action title icon
  code_action_icon = " ",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  finder_definition_icon = "  ",
  finder_reference_icon = "  ",
  max_preview_lines = 10,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    quit = "q",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>",
  },
  code_action_keys = {
    quit = "q",
    exec = "<CR>",
  },
  rename_action_keys = {
    quit = "<C-c>",
    exec = "<CR>",
  },
  definition_preview_icon = "  ",
  border_style = "single",
  rename_prompt_prefix = "➤",
  server_filetype_map = {},
  diagnostic_prefix_format = "%d. ",
}
EOF

" Lspsaga mappings
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>
nnoremap <silent> gp <Cmd>Lspsaga preview_definition<CR>
nnoremap <silent> gj <Cmd>Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> gk <Cmd>Lspsaga diagnostic_jump_prev<CR>
nnoremap <silent> K  <Cmd>Lspsaga hover_doc<CR>
nnoremap <silent> gs <Cmd>Lspsaga signature_help<CR>
nnoremap <silent><leader>gr <Cmd>Lspsaga rename<CR>

" TODO: come up with good keymaps for floatterm
" https://github.com/jesseduffield/lazygit
" nnoremap <silent> <C-s> <cmd>lua require('lspsaga.floaterm').open_float_terminal('lazygit')<CR>
" nnoremap <silent> <C-s> :Lspsaga open_floaterm<CR>
" tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>

" scroll down hover doc or scroll in definition preview
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
