local cmp = require("cmp")

require("luasnip.loaders.from_vscode").lazy_load()

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

cmp.setup({
	window = {
		completion = cmp.config.window.bordered({
			border = border("CmpBorder"),
			winhighlight = "Normal:CmpPmenu,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
		}),
		-- completion = {
		-- 	-- rounded border; thin-style scrollbar
		-- 	border = "rounded",
		-- 	scrollbar = "║",
		-- },
		documentation = {
			-- no border; native-style scrollbar
			border = nil,
			scrollbar = "",
			-- other options
		},
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-o>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<tab>"] = cmp.mapping.confirm({ select = true }),
	}),

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	sources = cmp.config.sources({
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
	}, {
		{ name = "buffer" },
	}),
})

vim.keymap.set("i", "<c-j>", '<cmd>lua require"luasnip".jump(1)<CR>', { noremap = true })
vim.keymap.set("s", "<c-j>", '<cmd>lua require"luasnip".jump(1)<CR>', { noremap = true })
vim.keymap.set("i", "<c-k>", '<cmd>lua require"luasnip".jump(-1)<CR>', { noremap = true })
vim.keymap.set("s", "<c-k>", '<cmd>lua require"luasnip".jump(-1)<CR>', { noremap = true })

vim.cmd("highlight! BorderBG guibg=NONE guifg=#00ff00") -- set border color
