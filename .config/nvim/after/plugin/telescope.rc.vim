lua << EOF
-- TODO: Customize keymap
local a = vim.api

local actions = require "telescope.actions"
local config = require "telescope.config"

local action_layout = require("telescope.actions.layout")
local mappings = {}

require("telescope").setup{
  defaults = {
    path_display = { "truncate" },
    prompt_prefix = ' ',
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
  },
  pickers = {
    -- find_files = { theme = "dropdown" },
    find_files = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.9,
      },
    },
    -- live_grep = { theme = "dropdown" },
    live_grep = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.9,
      },
    },
    -- buffers = { theme = "dropdown" },
    buffers = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.9,
      },
    },
    -- help_tags = { theme = "dropdown" },
    help_tags = {
      theme = "dropdown",
      previewer = false,
      layout_config = {
        width = 0.9,
      },
    },
  },
}
EOF

" Find files using Telescope command-line sugar.
nnoremap <Leader>ff <Cmd>Telescope find_files<CR>
nnoremap <Leader>fg <Cmd>Telescope live_grep find_command=rg,--ignore,--hidden,--files,--column--line_number,--no-heading,--color=always,--smart-case<CR>
nnoremap <Leader>fb <Cmd>Telescope buffers<CR>
nnoremap <Leader>fh <Cmd>Telescope help_tags<CR>
