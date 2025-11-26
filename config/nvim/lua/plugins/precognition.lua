-- lua/plugins/precognition.lua

return {
  {
    'tris203/precognition.nvim',
    lazy = true,
    event = 'VeryLazy',
    enabled = false,
    opts = {
      startVisible = true,
      showBlankVirtLine = true,
      highlightColor = { link = "Comment" },
      hints = {
        Caret = { text = "^", prio = 2 },
        Dollar = { text = "$", prio = 1 },
        MatchingPair = { text = "%", prio = 5 },
        Zero = { text = "0", prio = 1 },
        w = { text = "w", prio = 10 },
        b = { text = "b", prio = 9 },
        e = { text = "e", prio = 8 },
        W = { text = "W", prio = 7 },
        B = { text = "B", prio = 6 },
        E = { text = "E", prio = 5 },
      },
      gutterHints = {
        G = { text = "G", prio = 0 }, -- 10
        gg = { text = "gg", prio = 0 }, -- 9
        PrevParagraph = { text = "{", prio = 0 }, -- 8
        NextParagraph = { text = "}", prio = 0 }, --8
      },
      disabled_fts = {
        "startify",
      },
    },
  },
}
