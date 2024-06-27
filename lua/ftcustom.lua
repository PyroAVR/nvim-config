default = {
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4
}

short = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2
}

makefile = {
    expandtab = false,
    shiftwidth = 4,
    tabstop = 4
}

chain = {}
chain.__index = function(table, key) return table["_base"][key] end
chain.__call = function(base)
    t = { _base = base }
    setmetatable(t, chain)
    return t
end

-- ftmap is a table of file type names (str) -> config tables (table)
ftmap = {
    asm = default,
    c = default,
    cpp = default,
    html = short,
    lua = default,
    openscad = default,
    plaintex = default,
    python = default,
    sh = default,
    tex = default,
    vim = default,
    xml = short,
    yaml = short,
}

-- apply ftmap autocmds that trigger on FileType events
for ft, settings in pairs(ftmap) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = ft,
        callback = function(args)
            for key,val in pairs(settings) do
                vim.o[key] = val
            end
        end
    })
end
