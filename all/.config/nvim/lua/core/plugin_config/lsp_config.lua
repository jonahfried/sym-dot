require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "gopls",
    "golangci_lint_ls",
    "lua_ls",
    -- "tsserver",
    -- "pyright",
    -- "terraformls",
  },
})

--local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspsaga").setup({
  -- code_action_icon = "💡",
  ui = {
    code_action = "",
  },
  finder = {
    default = "def+ref+imp",
  },
  symbol_in_winbar = {
    in_custom = false,
    enable = true,
    separator = " ",
    show_file = true,
    file_formatter = "",
  },
})

vim.keymap.set("n", "gd", "<cmd>Lspsaga finder<CR>", { silent = true })
vim.keymap.set("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>", { silent = true })
vim.keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
vim.keymap.set("n", "gf", "<cmd>Lspsaga goto_definition<CR>", { silent = true })
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<cr>", { silent = true })
vim.keymap.set("i", "<C-a>", "<Cmd>Lspsaga hover_doc<CR>")
-- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set("n", "<leader>Rn", "<cmd>Lspsaga rename ++project<CR>", { silent = true })
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

-- Jump to error:
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "<leader>seb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
vim.keymap.set("n", "<leader>sew", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

require("lspconfig").lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})

local util = require("lspconfig/util")

require("lspconfig").gopls.setup({
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
    },
  },
})

require("lspconfig").golangci_lint_ls.setup({
  capabilities = capabilities,
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
})

require("lspconfig").pyright.setup({
  capabilities = capabilities,
})

require("lspconfig").tsserver.setup({
  capabilities = capabilities,
})

require("lspconfig").terraformls.setup({
  capabilities = capabilities,
})

-- Key bindings:
-- Jump to errror:
vim.api.nvim_set_keymap("n", "<leader>d[", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>d]", "<cmd>lua vim.diagnostic.goto_next()<CR>", { noremap = true, silent = true })
