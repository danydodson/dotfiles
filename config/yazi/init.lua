--

-- yazi-rs/plugins:full-border
require("full-border"):setup()

-- yazi-rs/plugins:no-status
require("no-status"):setup()

-- yazi-rs/plugins:hide-preview
if os.getenv("NVIM") then
	require("hide-preview"):entry()
end

-- yazi-rs/plugins:mime-ext
require("mime-ext"):setup({
	with_files = {
		makefile = "text/makefile",
		zshrc = "text/shellscript",
		zshenv = "text/shellscript",
		zprofile = "text/shellscript",
		zlogin = "text/shellscript",
		dockerfile = "text/shellscript",
	},
	with_exts = {
		mk = "text/makefile",
		zshrc = "text/shellscript",
		zshenv = "text/shellscript",
		zprofile = "text/shellscript",
		zlogin = "text/shellscript",
		dockerfile = "text/shellscript",
	},
	fallback_file1 = false,
})
