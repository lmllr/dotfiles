lua << EOF
local ls = require'luasnip'
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

-- local date = function() return {os.date('%Y-%m-%d')} end

require'luasnip'.snippets = {
    all = {
      snip({
        trig = "link",
        namr = "markdown_link",
        dscr = "Create markdown link [txt](url)"
      },
      {
        text('['),
        insert(1),
        text(']('),
        func(function(_, snip)
          return snip.env.TM_SELECTED_TEXT[1] or {}
        end, {}),
        text(')'),
        insert(0),
      }),
      snip({
        trig = "def",
        namr = "ruby_function",
        dscr = "Create a ruby function"
      },
      {
        text({"def func"}),
        text({"", "  "}), insert(1),
        text({"", "end"}), insert(0)
      })
    }
}
EOF
