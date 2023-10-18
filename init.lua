-- checkout lazy package manager if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- configure standard vimrc
vim.cmd("source " .. string.format("%s/%s", vim.fn.stdpath("config"), "config.vim"))
vim.g.coq_settings = {
    auto_start = 'shut-up',
    clients = {
	lsp = {
		enabled = true,
	}
    }
}

-- configure lazy plugins
plugins = {
    {import = "plugin_config"},
    {name = "tmuxline", url = "https://github.com/edkolev/tmuxline.vim"},
    {name = "lsp config", url = "https://github.com/neovim/nvim-lspconfig",
    },
    {name = "coq", url = "https://github.com/ms-jpq/coq_nvim",
    config = function()
	    local lspconfig = require "lspconfig"
	    local coq = require "coq"
	    lspconfig.ccls.setup(coq.lsp_ensure_capabilities())
    end},
    {name = "vim-fugitive", url = "https://github.com/tpope/vim-fugitive"},
    {name = "base16 colors", url = "https://github.com/chriskempson/base16-vim"},
    {name = "tagbar", url = "https://github.com/preservim/tagbar"},
    {name = "commenter", url = "https://github.com/numToStr/comment.nvim",
    	config = function() require("Comment").setup() end},
    {name = "auto-session", url = "https://github.com/rmagatti/auto-session"},
    -- {name = "nerdtree", url = "https://github.com/preservim/nerdtree"},
}
require("lazy").setup(plugins)
vim.cmd("colorscheme base16-solarized-dark")
