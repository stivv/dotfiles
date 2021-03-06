local ls = require "luasnip"

-- This is a sinppet creator
-- s(<trigger>, <nodes>)
local s = ls.s

-- This is a format node
-- It takes a format string, and a list of nodes
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- This is an insert node
-- It takes a position (like $1) and optionally some default text
-- i(<position>, [default_text])
local i = ls.insert_node

-- Repeat a node
-- rep(<position>)
local rep = require("luasnip.extras").rep

ls.snippets = {
  all = {
    ls.parser.parse_snippet("expand", "-- this is expanded"),
  }
}
