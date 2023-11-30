vim.g.coq_settings = {
    auto_start = 'shut-up',
    clients = {
	lsp = {
		enabled = true,
	}
    }
}

return {
    name = "coq", url = "https://github.com/ms-jpq/coq_nvim",
    config = function()
	    local lspconfig = require "lspconfig"
	    local coq = require "coq"
	    lspconfig.ccls.setup(coq.lsp_ensure_capabilities({
            init_options = { compilationDatabaseDirectory = "build" }
        }))
    end,
}
