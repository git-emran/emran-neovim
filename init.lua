require("core.options")
require("core.keymaps")
require("core.snippets")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
---@diagnostic disable-next-line: undefined-field
if not uv.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.editor-ui"),
	require("plugins.treesitter"),
	require("plugins.colortheme"),
	require("plugins.color-highlight"),
	require("plugins.folke-noice"),
	require("plugins.coding"),
	require("plugins.telescope"),
	require("plugins.lsp"),
	require("plugins.snacks"),
	require("plugins.trouble"),
	require("plugins.lualine"),
	require("plugins.markdown-render"),
	require("plugins.conform"),
	require("plugins.none-ls"),
	require("plugins.copilot-supermaven"),
	require("plugins.zenmode"),
	require("plugins.folke-flash"),
	require("plugins.toggle-term"),
	require("plugins.typst"),
}, {
	auto_update = false,
	checker = { enabled = false },
})
