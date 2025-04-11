-- yazi init.lua

--
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

Status:children_add(function()
	local h = cx.active.current.hovered
	if h == nil or ya.target_family() ~= "unix" then
		return ui.Line({})
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("#6495ED"),
		ui.Span(":"):fg("#87CEFA"),
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("#6495ED"),
		ui.Span(" "),
	})
end, 500, Status.RIGHT)

Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ui.Line({})
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("#87CEFA")
end, 500, Header.LEFT)

-- yazi-rs/plugins:full-border
require("full-border"):setup({
	type = ui.Border.PLAIN,
})

-- yazi-rs/plugins:no-status
require("no-status"):setup()

-- wylie102/duckdb.yazi
require("duckdb"):setup()

-- yazi-rs/plugins:hide-preview
if os.getenv("NVIM") then
	require("hide-preview"):entry()
end

-- yazi-rs/plugins:mime-ext
require("mime-ext"):setup({
	with_files = {
		makefile = "text/makefile",
		zshrc = "text/shellscript",
		--  zshenv = "text/shellscript",
		--  zprofile = "text/shellscript",
		--  zlogin = "text/shellscript",
		--  dockerfile = "text/shellscript",
	},
	with_exts = {
		mk = "text/makefile",
		zshrc = "text/shellscript",
		--  zshenv = "text/shellscript",
		--  zprofile = "text/shellscript",
		--  zlogin = "text/shellscript",
		--  dockerfile = "text/shellscript",
		--  plist = "text/xml",
		--  pdf = "application/pdf",
		--  otf = "font/otf",
	},
	fallback_file1 = false,
})
