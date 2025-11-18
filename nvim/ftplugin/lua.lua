-- Find project root or use current directory
local root_dir = vim.fs.dirname(vim.fs.find({
	'.git',
	'init.lua',
	'.luarc.json',
	'lua/'
}, { upward = true })[1]) or vim.fn.expand('%:p:h')

vim.lsp.start({
	name = "lua_ls",
	cmd = { "lua-language-server" },
	root_dir = root_dir,
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			diagnostics = { globals = { 'vim' } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
})
