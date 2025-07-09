local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- XXX Debug
  s({
    trig = "xxx",
    name = "Console log debug xxx",
    dscr = "Console log debug xxx"
  }, {
    t('console.log("XXX", '),
    i(1),
    t(')')
  }),

  -- XXX Debug Stringify
  s({
    trig = "xxs",
    name = "Console log and JSON.stringify",
    dscr = "Console log and JSON.stringify"
  }, {
    t('console.log("XXX", JSON.stringify('),
    i(1),
    t(', null, 2))')
  }),

  -- YYY Debug
  s({
    trig = "yyy",
    name = "Console log debug yyy",
    dscr = "Console log debug yyy"
  }, {
    t('console.log("YYY", '),
    i(1),
    t(')')
  }),

  -- ZZZ Debug
  s({
    trig = "zzz",
    name = "Console log debug zzz",
    dscr = "Console log debug zzz"
  }, {
    t('console.log("ZZZ", '),
    i(1),
    t(')')
  }),

  -- Console log
  s({
    trig = "clog",
    name = "Console log",
    dscr = "Console log"
  }, {
    t('console.log('),
    i(1),
    t(')')
  }),

  -- Console error
  s({
    trig = "cerr",
    name = "Console error",
    dscr = "Console error"
  }, {
    t('console.error('),
    i(1),
    t(')')
  })
}