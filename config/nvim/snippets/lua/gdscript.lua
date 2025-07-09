local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Class Name snippet
  s({
    trig = "cn",
    name = "Class Name",
    dscr = "Create a class_name declaration"
  }, {
    t("class_name "),
    i(1, "SomeClass")
  }),

  -- Ready function snippet
  s({
    trig = "_ready",
    name = "Ready",
    dscr = "Create _ready function"
  }, {
    t({"func _ready() -> void:", "\t"}),
    i(1, "pass")
  }),

  -- Process function snippet
  s({
    trig = "_process",
    name = "Process",
    dscr = "Create _process function"
  }, {
    t({"func _process(_delta: float) -> void:", "\t"}),
    i(1, "pass")
  }),

  -- Physics Process function snippet
  s({
    trig = "_physics_process",
    name = "Physics Process",
    dscr = "Create _physics_process function"
  }, {
    t({"func _physics_process(_delta: float) -> void:", "\t"}),
    i(1, "pass")
  }),

  -- WeakRef variable snippet
  s({
    trig = "weakref",
    name = "WeakRef",
    dscr = "Create a WeakRef variable with getter/setter"
  }, {
    t("var _"),
    i(1, "target"),
    t(": WeakRef\nvar "),
    i(1, "target"),
    t(": "),
    i(2, "Node2D"),
    t({":", "\tget:", "\t\treturn _"}),
    i(1, "target"),
    t(".get_ref() if _"),
    i(1, "target"),
    t({" else null", "\tset(value):", "\t\t_"}),
    i(1, "target"),
    t(" = weakref(value)")
  })
}