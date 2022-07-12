if !exists('g:loaded_nvim_treesitter')
  echom "Not loaded treesitter"
  finish
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
    "ruby",
    "go",
    "tsx",
    "fish",
    "json",
    "yaml",
    "html",
    "scss"
  },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.ruby.filetype_to_parsername = { "ruby" }
parser_config.go.filetype_to_parsername = { "go" }
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
EOF
