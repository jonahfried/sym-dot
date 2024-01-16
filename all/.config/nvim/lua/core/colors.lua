COLORSCHEME_MAP = {
	Catppuccin_Latte = "catppuccin-latte",
	Catppuccin_Mocha = "catppuccin-mocha",
	Cyberpunk_Edge = "cyberpunk-edge",
	Decay_Green = "decay-green",
	Frosted_Glass = "frosted-glass",
	Graphite_Mono = "graphite-mono",
	Gruvbox_Retro = "gruvbox",
	Material_Sakura = "material-sakura",
	Rose_Pine = "rose-pine",
	Tokyo_Night = "tokyonight",
}

SET_THEME_FROM_CONFIG = function()
	local f = io.open("theme.conf", "r")
	io.input(f)
	local setTheme = io.read()
	local vimTheme = COLORSCHEME_MAP[setTheme]

	local ok, _ = pcall(vim.cmd, "colorscheme " .. vimTheme)
	if not ok then
		vim.cmd("colorscheme disco")
	end
end
SET_THEME_FROM_CONFIG()

vim.api.nvim_create_autocmd({ "Signal" }, {
	callback = SET_THEME_FROM_CONFIG,
})
