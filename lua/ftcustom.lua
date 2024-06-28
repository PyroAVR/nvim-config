-- simple inheritable table
ftconfig = {
    __index = function(table, key) return table["_base"][key] end,
    new = function(self, base)
        t = { _base = base or {} }
        setmetatable(t, ftconfig)
        return t
    end
}

default = ftconfig:new{
    options = {
        expandtab = true,
        shiftwidth = 4,
        tabstop = 4
    }
}

short = ftconfig:new{
    options = {
        expandtab = true,
        shiftwidth = 2,
        tabstop = 2
    }
}

makefile = ftconfig:new{
    options = {
        expandtab = false,
        shiftwidth = 4,
        tabstop = 4
    }
}



cpp = ftconfig:new(default)
cpp.keymaps = {
    {
        mode = "i",
        pattern = "endl",
        subst = "<< std::endl",
    },
    {
        mode = "i",
        pattern = "cout",
        subst = "std::cout << ",
    },
    {
        mode = {"i", "n"},
        pattern = "",
        subst = function() require('Comment.api').toggle.linewise() end
    },
    {
        mode = "v",
        pattern = "",
        subst = function() require('Comment.api').toggle.linewise(vim.fn.visualmode()) end
    },
}

python = ftconfig:new(default)
python.keymaps = {
    {
        mode = "i",
        pattern = "dbg",
        subst = "import pudb; pudb.set_trace()"
    },
}

-- ftmap is a table of file type names (str) -> config tables (table)
ftmap = {
    asm = default,
    c = default,
    cpp = cpp,
    html = short,
    lua = default,
    openscad = default,
    plaintex = default,
    python = python,
    sh = default,
    tex = default,
    vim = default,
    xml = short,
    yaml = short,
}

-- apply ftmap autocmds that trigger on FileType events
-- nvim will then apply these settings when the FileType event is triggered,
-- aka enter / leave a buffer of the specified type.
for ft, settings in pairs(ftmap) do
    -- apply editor options
    if settings.options ~= nil then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = ft,
            callback = function(args)
                for key,val in pairs(settings.options) do
                    vim.o[key] = val
                end
            end
        })
    end
    if settings.keymaps ~= nil then
        vim.api.nvim_create_autocmd("FileType", {
            pattern = ft,
            callback = function(args)
                for _, mapping in pairs(settings.keymaps) do
                    vim.keymap.set(mapping.mode, mapping.pattern, mapping.subst)
                end
            end
        })
    end
end
