local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Anonymous list
  s("list", {
    t(".{"), i(1, "val1"), t(", "), i(2, "val2"), t(", "), i(3, "val3"), t("};"), i(0)
  }),

  -- Block expression
  s("block", {
    i(1, "label"), t(": {"), t({"", "    "}),
    t("const "), i(2, "name"), t(" = "), i(3, "value"), t({"", "    "}),
    t("break :"), f(function(args) return args[1][1] end, {1}), t(" "), i(4, "return_value"), i(0), t({"", "};"}),
  }),

  -- Struct value
  s("stru_val", {
    t({"struct {", "    ."}), i(1, "field"), t(": "), i(2, "type"), t(","), t({"", "    ."}),
    i(3, "field"), t(": "), i(4, "type"), i(0), t({"", "};"}),
  }),

  -- For value loop
  s("for_v", {
    t("for ("), i(1, "items"), t(") |"), i(2, "value"), t("| {"), t({"", "    "}),
    i(0), t({"", "}"}),
  }),

  -- While loop
  s("while", {
    t("while ("), i(1, "cond"), t(") : ("), i(2, "continue_expr"), t(") {"), t({"", "    "}),
    i(0), t({"", "}"}),
  }),

  -- Import std
  s("imp_std", {
    t('@import("std").'),
    c(1, {
      t("ascii"), t("atomic"), t("base64"), t("build"), t("builtin"),
      t("c"), t("coff"), t("crypto"), t("cstr"), t("debug"),
      -- Add other std modules as needed
    }),
    t(";"), i(0)
  }),

  -- Main template
  s({trig = "main", name = "Main function template"}, fmt([[
    const std = @import("std");

    pub fn main() !void {{
        const stdout = &std.io.getStdOut().outStream();
        try stdout.print("Hello {}!\n", .{{"world"}});{}}
    ]], {
      i(0)
    })),

  -- Test snippet
  s("test", {
    t("test "), i(1, "name"), t(" {"), t({"", "    "}),
    t("const x = true"), t({"", "    "}),
    t("assert(x)"), i(0), t({"", "}"}),
  }),

  -- Error declaration
  s("error", {
    t({"error {", "    "}), i(1, "variant"), t(","), t({"", "    "}),
    i(2, "variant"), t(","), i(0), t({"", "};"}),
  }),

  -- More snippets can be added following the same pattern...
}