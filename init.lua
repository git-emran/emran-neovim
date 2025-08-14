require("core.options")
require("core.keymaps")
require("core.snippets")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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
	require("plugins.colortheme"),
	require("plugins.color-highlight"),
	require("plugins.folke-noice"),
	require("plugins.coding"),
	require("plugins.telescope"),
	require("plugins.language"),
	require("plugins.snacks"),
	require("plugins.trouble"),
	require("plugins.lualine"),
	require("plugins.conform"),
})
