local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Single constant
  s("co", fmt("const {} = {}", {
    i(1, "name"),
    i(2, "value")
  })),

  -- Variable declaration
  s("var", fmt("var {} {}", {
    i(1, "name"),
    i(2, "type")
  })),

  -- Type interface declaration
  s("tyi", fmt([[
type {} interface {{
    {}
}}]], {
    i(1, "name"),
    i(0)
  })),

  -- Main function
  s("main", fmt([[
func main() {{
    {}
}}]], {
    i(0)
  })),

  -- Struct
  s("st", fmt([[
type {} struct {{
    {}
}}]], {
    i(1),
    i(2)
  })),

  -- Function
  s("fn", fmt([[
func {}() {} {{
    {}
}}]], {
    i(1),
    i(2),
    i(3)
  })),

  -- Method declaration
  s("meth", fmt([[
func ({} {}) {}({}) {} {{
    {}
}}]], {
    i(1, "receiver"),
    i(2, "type"),
    i(3, "method"),
    i(4),
    i(5),
    i(0)
  })),

  -- If statement
  s("if", fmt([[
if {} {{
    {}
}}]], {
    i(1, "condition"),
    i(0)
  })),

  -- Else branch
  s("el", fmt([[
else {{
    {}
}}]], {
    i(0)
  })),

  -- If else statement
  s("ie", fmt([[
if {} {{
    {}
}} else {{
    {}
}}]], {
    i(1, "condition"),
    i(2),
    i(0)
  })),

  -- If err != nil
  s("iferr", fmt([[
if err != nil {{
    {}
}}]], {
    i(1, "return nil, err")
  })),

  -- Switch statement
  s("switch", fmt([[
switch {} {{
case {}:
    {}
}}]], {
    i(1, "expression"),
    i(2, "condition"),
    i(0)
  })),

  -- Select statement
  s("sel", fmt([[
select {{
case {}:
    {}
}}]], {
    i(1, "condition"),
    i(0)
  })),

  -- Case clause
  s("cs", fmt("case {}:{}", {
    i(1, "condition"),
    i(0)
  })),

  -- For statement
  s("for", fmt([[
for {} := 0; {} < {}; {}{} {{
    {}
}}]], {
    i(1, "i"),
    i(1, "i"),
    i(2, "count"),
    i(1, "i"),
    i(3, "++"),
    i(0)
  })),

  -- For range statement
  s("forr", fmt([[
for {}{} := range {} {{
    {}
}}]], {
    i(1, "_, "),
    i(2, "var"),
    i(3, "var"),
    i(0)
  })),

  -- Map declaration
  s("map", fmt("map[{}]{}", {
    i(1, "type"),
    i(2, "type")
  })),

  -- Goroutine anonymous function
  s("go", fmt([[
go func({}) {{
    {}
}}({})]], {
    i(1),
    i(0),
    i(2)
  })),

  -- Goroutine function
  s("gf", fmt("go {}({})", {
    i(1, "func"),
    i(0)
  }))
}