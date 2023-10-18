local swap_then_open_tab = function()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    vim.cmd("wincmd l")
    api.node.open.tab(node)
end

local git_add = function()
    local api = require("nvim-tree.api")
    local node = api.tree.get_node_under_cursor()
    local gs = node.git_status.file

    -- If the current node is a directory get children status
    if gs == nil then
        gs = (node.git_status.dir.direct ~= nil and node.git_status.dir.direct[1]) 
              or (node.git_status.dir.indirect ~= nil and node.git_status.dir.indirect[1])
    end

    -- If the file is untracked, unstaged or partially staged, we stage it
    if gs == "??" or gs == "MM" or gs == "AM" or gs == " M" then
        vim.cmd("silent !git add " .. node.absolute_path)

    -- If the file is staged, we unstage
    elseif gs == "M " or gs == "A " then
        vim.cmd("silent !git restore --staged " .. node.absolute_path)
    end

  api.tree.reload()
end

local set_tree_buf_keybinds = function(bufnr)
    local api = require("nvim-tree.api")
    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    vim.keymap.set('n', 't', swap_then_open_tab, opts('Open node in new tab'))
    -- intentional dupe to save my muscle memory from NERDTree
    vim.keymap.set('n', 's', api.node.open.vertical, opts('Open node in vsplit'))
    vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open node in vsplit'))
    vim.keymap.set('n', '<Enter>', api.node.open.edit, opts('Open node in last selected buffer'))
    vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open node in hsplit'))
    vim.keymap.set('n', '<C-r>', api.tree.reload, opts('Reload tree manually'))
    vim.keymap.set('n', 'C', api.tree.change_root_to_node, opts('cd <node under cursor>'))
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Show help'))
    vim.keymap.set('n', '<C-g>a', git_add, opts('Toggle stage/unstage of changes'))
end

return {
    name = "nvim-tree",
    url = "https://github.com/nvim-tree/nvim-tree.lua",
    requires = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
        local api = require("nvim-tree.api")
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        -- setup normal mode binds
        vim.keymap.set('n', 'E', api.tree.toggle)
        -- fix for auto-session restore weirdness
        vim.api.nvim_create_autocmd({ 'BufEnter' }, {
            pattern = 'NvimTree*',
            callback = function()
                local api = require("nvim-tree.api")
                local view = require('nvim-tree.view')

                if not view.is_visible() then
                    api.tree.open()
                end
            end,
        })
        
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            view = {
            width = 30,
                },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
                on_attach = set_tree_buf_keybinds,
        })
    end
}
