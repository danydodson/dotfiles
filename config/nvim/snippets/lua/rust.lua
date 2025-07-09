local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- extern crate
  s("extern crate", {
    t("extern crate "),
    i(1, "name"),
    t(";"),
  }),

  -- for loop
  s("for", {
    t("for "),
    i(1, "elem"),
    t(" in "),
    i(2, "iter"),
    t(" {"),
    t({"", "\t"}),
    i(0),
    t({"", "}"}),
  }),

  -- macro_rules
  s("macro_rules", {
    t("macro_rules! "),
    i(1),
    t({" {", "\t("}),
    i(2),
    t({") => {", "\t\t"}),
    i(0),
    t({"", "\t};", "}"}),
  }),

  -- if let
  s("if let", {
    t("if let "),
    i(1, "pattern"),
    t(" = "),
    i(2, "value"),
    t(" {"),
    t({"", "\t"}),
    i(3),
    t({"", "}"}),
  }),

  -- spawn (with multiple triggers)
  s({ trig = "spawn", snippetType = "autosnippet" }, {
    t("std::thread::spawn(move || {"),
    t({"", "\t"}),
    i(1),
    t({"", "})"}),
  }),

  -- derive
  s("derive", {
    t("#[derive("),
    i(1),
    t(")]"),
  }),

  -- cfg
  s("cfg", {
    t("#[cfg("),
    i(1),
    t(")]"),
  }),

  -- test
  s("test", {
    t({"#[test]", "fn "}),
    i(1, "name"),
    t("() {"),
    t({"", "    "}),
    i(2, "unimplemented!();"),
    t({"", "}"}),
  }),
}