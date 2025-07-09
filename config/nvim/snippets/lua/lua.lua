local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

return {
  -- _G
  s({
    trig = "_G",
    dscr = "_G (Lua 5.1-5.3)",
    filetype = "lua",
  }, {
    t("_G("), i(0, "..."), t(")")
  }),

  -- assert
  s({
    trig = "assert",
    dscr = "assert() (Lua 5.1-5.3)",
    filetype = "lua",
  }, {
    t("assert("), i(1, "v"), i(2, "[, message]"), t(")")
  }),

  -- collectgarbage
  s({
    trig = "collectgarbage",
    dscr = "collectgarbage() (Lua 5.1-5.3)",
    filetype = "lua",
  }, {
    t("collectgarbage("), i(1, "[opt]"), i(2, "[, arg]"), t(")")
  }),

  -- coroutine snippets
  s({
    trig = "coroutine.create",
    dscr = "coroutine.create (Lua 5.1-5.3)",
    filetype = "lua",
  }, {
    t("coroutine.create( "), i(1, "function"), t(" )")
  }),

  -- loops
  s({
    trig = "for",
    dscr = "for i=1,10",
    filetype = "lua",
  }, {
    t("for "), i(1, "i"), t("="), i(2, "1"), t(","), i(3, "10"), t(" do\n\t"),
    i(0, "print(i)"), t("\nend")
  }),

  s({
    trig = "fori",
    dscr = "for i,v in ipairs()",
    filetype = "lua",
  }, {
    t("for "), i(1, "i"), t(","), i(2, "v"), t(" in ipairs("), i(3, "table_name"), t(") do\n\t"),
    i(0, "print(i,v)"), t("\nend")
  }),

  -- functions
  s({
    trig = "fun",
    dscr = "function",
    filetype = "lua",
  }, {
    t("function "), i(1, "function_name"), t("( "), i(2, "..."), t(" )\n\t"),
    i(0, "-- body"), t("\nend")
  }),

  -- conditionals
  s({
    trig = "if",
    dscr = "if statement",
    filetype = "lua",
  }, {
    t("if "), i(1, "condition"), t(" then\n\t"),
    i(0, "-- body"), t("\nend")
  }),

  s({
    trig = "ifel",
    dscr = "if-else statement",
    filetype = "lua",
  }, {
    t("if "), i(1, "condition"), t(" then\n\t"),
    i(2, "-- body"), t("\nelse\n\t"),
    i(0, "-- body"), t("\nend")
  }),
}