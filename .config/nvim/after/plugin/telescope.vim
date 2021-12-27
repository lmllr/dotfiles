lua << EOF
-- TODO: Customize keymap
local a = vim.api

local actions = require "telescope.actions"
local config = require "telescope.config"

local action_layout = require("telescope.actions.layout")
local mappings = {}

require("telescope").setup{
  defaults = {
    pickers = {
      -- , , 🔍
      -- caret='',
    },
    mappings = {
      n = {
        ["<S-p>"] = action_layout.toggle_preview,
        ["<C-a>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
      i = {
        ["<S-p>"] = action_layout.toggle_preview,
        ["<C-a>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  }
}
EOF

" Find files using Telescope command-line sugar.
nnoremap <Leader>ff <Cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ prompt_prefix = ' ' }))<CR>

nnoremap <Leader>fg <Cmd>lua require'telescope.builtin'.live_grep(require('telescope.themes').get_dropdown({ prompt_prefix = ' ' }))<CR>

nnoremap <Leader>fb <Cmd>lua require'telescope.builtin'.buffers(require('telescope.themes').get_dropdown({ prompt_prefix = ' ' }))<CR>

nnoremap <Leader>fh <Cmd>lua require'telescope.builtin'.help_tags(require('telescope.themes').get_dropdown({ prompt_prefix = ' ' }))<CR>
