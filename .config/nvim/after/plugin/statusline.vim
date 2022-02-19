lua << EOF
local lsp_status = require('lsp-status')
lsp_status.register_progress()

-- Put this somewhere near lsp_status.register_progress()
lsp_status.config({
  kind_labels = {},
  current_function = true,
  show_filename = true,
  diagnostics = true,
  indicator_separator = ' ',
  component_separator = ' ',
  indicator_errors = '',
  indicator_warnings = '',
  indicator_info = '',
  indicator_hint = '',
  indicator_ok = '',
  spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
  status_symbol = '',
  select_symbol = nil,
  update_interval = 30
})

local lspconfig = require('lspconfig')

-- ALREADY ACTIVATED IN lspconfing.vim
-- Some arbitrary servers
--lspconfig.solargraph.setup({
--  on_attach = lsp_status.on_attach,
--  capabilities = lsp_status.capabilities
--})
EOF

" Experimental Statusline
" this is still WIP

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

function! FiletypeWithIcon()
  " vim    ``
  " ruby   ``
  " html   ``
  " css    ``
  "
  let filetypes = {
        \'vim': "\UE62B",
        \'ruby': "\UE791",
        \'html': "\UE736",
        \'css': "\UE749",
        \}
  return has_key(filetypes, &filetype) ? filetypes[&filetype]." ".&filetype : &filetype
endfunction

function! ActiveStatus()
  let statusline=""

  " Show different modes
  " let statusline.="%-9{(mode()=='n')?'\ \ NORMAL':''}%*"
  " let statusline.="%-9{(mode()=='i')?'\ \ INSERT':''}%*"
  " let statusline.="%-9{(mode()==?'r')?'\ \ REPLACE':''}%*"
  " let statusline.="%-9{(mode()=='v')?'\ \ VISUAL':''}%*"
  " let statusline.="%-9{(mode()=='c')?'\ \ COMMAND':''}%*"
  
  " show git branch
  " let statusline.="\ %{fugitive#statusline()}\ %*"
  if &modified
    let statusline.="%#SlBlueBg#\ %f\ %#SlBlueFgRedBg#"
    let statusline.="%#SlRedBgBold#\ %m"
    let statusline.="%="
    let statusline.="\ %#SLDividerReverseR#"
  else
    let statusline.="%#SlBlueBg#\ %f\ %#SlBlueFg#%*"
    let statusline.="%{&readonly?'\ ':''}"
    let statusline.="%="
  end
  " Type of file
  " let statusline.="\ %{FiletypeWithIcon()}\ "

  " %b: Value of character under cursor
  " %B: As above, in hexadecimal
  " let statusline.="\ [\ %b0x%B\ ]\ "
  " let statusline.="%{&fileencoding}"
  let statusline.="%*"
  let statusline.="%#SlBold#"
  " %l: Line number
  " $c: Column number
  let statusline.="\ \UE0A1%l:%c\ "
  " Percentage through file in line
  let statusline.="\ %p%%"
  " TODO: Hide diagnostics when no errors, warnings etc.
  let statusline.="\ %#SLDiagnosticsDivider#%#ErrorMsg#%{LspStatus()}"
  let statusline.="%<"
  " let statusline.="%*"
  return statusline
endfunction

function! InactiveStatus()
  let statusline=""
  let statusline.="\ %f"
  let statusline.="\ %m"
  " let statusline.="%{&modified?'\ \ +':''}"
  let statusline.="%{&readonly?'\ ':''}"
  return statusline
endfunction

set statusline=%!ActiveStatus()

augroup status
  autocmd!
  " TODO: Make quickfix list stay the same when switching around
  " Set custom quickfix list statusline
  " FIXME: Does not wor
  autocmd Filetype qf setlocal statusline=%#QFLineDivider#%#IncSearch#\ %n\ \ %f%=%L\ lines\ %#QFLineDivider#%*
  autocmd WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd WinLeave * setlocal statusline=%!InactiveStatus()
augroup END
