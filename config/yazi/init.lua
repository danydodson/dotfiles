-- yazi init.lua

-- show symlink in statusbar
function Status:name()
	local h = cx.active.current.hovered
	if not h then
		return ui.Span("")
	end
	local linked = ""
	if h.link_to ~= nil then
		linked = " -> " .. tostring(h.link_to)
	end

	return ui.Span(" " .. h.name .. linked)
end

--
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

-- add username to header
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ui.Line({})
	end
	return ui.Span("")
end, 500, Header.LEFT)

-- remove statusbar
local old_layout = Tab.layout

Status.redraw = function()
	return {}
end

Tab.layout = function(self, ...)
	self._area = ui.Rect({ x = self._area.x, y = self._area.y, w = self._area.w, h = self._area.h + 1 })
	return old_layout(self, ...)
end

-- require("full-border"):setup({
-- 	type = ui.Border.PLAIN,
-- })
