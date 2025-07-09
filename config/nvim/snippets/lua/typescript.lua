local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Debug snippets
  s("xxx", {
    t('console.log("XXX", '),
    i(1),
    t(")"),
  }),

  s("xxs", {
    t('console.log("XXX", JSON.stringify('),
    i(1),
    t(", null, 2))"),
  }),

  s("yyy", {
    t('console.log("YYY", '),
    i(1),
    t(")"),
  }),

  s("zzz", {
    t('console.log("ZZZ", '),
    i(1),
    t(")"),
  }),

  -- Console snippets
  s("clog", {
    t("console.log("),
    i(1),
    t(")"),
  }),

  s("cerr", {
    t("console.error("),
    i(1),
    t(")"),
  }),

  -- React imports and components
  s("imr", {
    t("import React from 'react';"),
  }),

  s("rfc", {
    t({"import React from 'react';", "", "const "}),
    i(1, "ComponentName"),
    t({": React.FC = () => {", "  return <div />;", "}", "", "export default "}),
    i(2, "ComponentName"),
    t(";"),
  }),

  -- React Hooks
  s("useState", {
    t("const ["),
    i(1, "state"),
    t(", set"),
    i(2, "State"),
    t("] = useState("),
    i(3, "defaultState"),
    t(");"),
  }),

  s("useEffect", {
    t({"useEffect(() => {", "  "}),
    i(1),
    t({"", "}, []);"}),
  }),

  s("useContext", {
    t("const "),
    i(1, "value"),
    t(" = useContext("),
    i(2, "MyContext"),
    t(");"),
  }),

  s("useReducer", {
    t("const ["),
    i(1, "state"),
    t(", dispatch] = useReducer("),
    i(2, "reducer"),
    t(", initialState);"),
  }),

  s("useCallback", {
    t({"const "}),
    i(1, "memoizedCallback"),
    t({" = useCallback(() => {", "  "}),
    i(2),
    t({"", "}, []);"}),
  }),

  s("useMemo", {
    t({"const "}),
    i(1, "memoizedValue"),
    t({" = useMemo(() => {", "  "}),
    i(2),
    t({"", "}, []);"}),
  }),

  s("useRef", {
    t("const "),
    i(1, "refContainer"),
    t(" = useRef("),
    i(2, "initialValue"),
    t(");"),
  }),

  -- Redux Hooks
  s("useSelector", {
    t("const "),
    i(1, "selectedData"),
    t(" = useSelector(state => state."),
    i(2, "YourObject"),
    t(");"),
  }),

  s("useDispatch", {
    t("const dispatch = useDispatch();"),
  }),

  s("useStore", {
    t("const store = useStore();"),
  }),
}