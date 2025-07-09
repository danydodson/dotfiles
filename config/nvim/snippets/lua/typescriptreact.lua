local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- XXX Debug
  s({
    trig = "xxx",
    desc = "Console log debug xxx"
  }, {
    t('console.log("XXX " + '),
    i(1),
    t(')'),
  }),

  -- XXX Debug Stringify
  s({
    trig = "xxs",
    desc = "Console log and JSON.stringify"
  }, {
    t('console.log("XXX " + JSON.stringify('),
    i(1),
    t(', null, 2))'),
  }),

  -- YYY Debug
  s({
    trig = "yyy",
    desc = "Console log debug yyy"
  }, {
    t('console.log("YYY " + '),
    i(1),
    t(')'),
  }),

  -- ZZZ Debug
  s({
    trig = "zzz",
    desc = "Console log debug zzz"
  }, {
    t('console.log("ZZZ " + '),
    i(1),
    t(')'),
  }),

  -- Stringify
  s({
    trig = "sss",
    desc = "Stringify"
  }, {
    t('<Stringify>{'),
    i(1),
    t('}</Stringify>'),
  }),

  -- className
  s({
    trig = "cn=",
    desc = "Classname"
  }, {
    t('className="'),
    i(1),
    t('"'),
    i(2),
  }),
}