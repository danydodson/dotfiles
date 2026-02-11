-- yazi init.lua

-- remove statusbar ------------------------------------------------------------------------------------------------------

local old_layout = Tab.layout

Status.redraw = function()
  return {}
end

Tab.layout = function(self, ...)
  self._area = ui.Rect { x = self._area.x, y = self._area.y, w = self._area.w, h = self._area.h + 1 }
  return old_layout(self, ...)
end

-- full border -----------------------------------------------------------------------------------------------------------

-- local old_build = Tab.build

-- Tab.build = function(self, ...)
--   local bar = function(c, x, y)
--     if x <= 0 or x == self._area.w - 1 then
--       return ui.Bar(ui.Bar.TOP)
--     end

--     return ui.Bar(ui.Bar.TOP)
--       :area(ui.Rect {
--         x = x,
--         y = math.max(0, y),
--         w = ya.clamp(0, self._area.w - x, 1),
--         h = math.min(1, self._area.h),
--       })
--       :symbol(c)
--   end

--   local c = self._chunks
--   self._chunks = {
--     c[1]:pad(ui.Pad.y(1)),
--     c[2]:pad(ui.Pad(1, c[3].w > 0 and 0 or 1, 1, c[1].w > 0 and 0 or 1)),
--     c[3]:pad(ui.Pad.y(1)),
--   }

--   local type = ui.Border.PLAIN
--   local style = { fg = '#535c6c' }
--   self._base = ya.list_merge(self._base or {}, {
--     ui.Border(ui.Border.ALL):area(self._area):type(type):style(style),
--     ui.Bar(ui.Bar.RIGHT):area(self._chunks[1]):style(style),
--     ui.Bar(ui.Bar.LEFT):area(self._chunks[3]):style(style),

--     bar('┬', c[1].right - 1, c[1].y),
--     bar('┴', c[1].right - 1, c[1].bottom - 1),
--     bar('┬', c[2].right, c[2].y),
--     bar('┴', c[2].right, c[2].bottom - 1),
--   })

--   old_build(self, ...)
-- end

-- add username to header -------------------------------------------------------------------------------------------------

-- Header:children_add(function()
--   if ya.target_family() ~= 'unix' then
--     return ui.Line {}
--   end
--   return ui.Span ''
-- end, 500, Header.LEFT)

-- show symlink in statusbar ----------------------------------------------------------------------------------------------

-- function Status:name()
--   local h = cx.active.current.hovered
--   if not h then
--     return ui.Span ''
--   end
--   local linked = ''
--   if h.link_to ~= nil then
--     linked = ' -> ' .. tostring(h.link_to)
--   end

--   return ui.Span(' ' .. h.name .. linked)
-- end

-- add to statusbar ------------------------------------------------------------------------------------------------------

-- Status:children_add(function()
-- 	local h = cx.active.current.hovered
-- 	if h == nil or ya.target_family() ~= "unix" then
-- 		return ui.Line({})
-- 	end

-- 	return ui.Line({
-- 		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("#6495ED"),
-- 		ui.Span(":"):fg("#87CEFA"),
-- 		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("#6495ED"),
-- 		ui.Span(" "),
-- 	})
-- end, 500, Status.RIGHT)
