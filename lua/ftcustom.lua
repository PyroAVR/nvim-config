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

ftmap = {
    c = default,
    cpp = default,
    python = default,
    asm = default,
    tex = default,
    plaintex = default,
    vim = default,
    sh = default,
    openscad = default,
    yaml = short,
    html = short,
    xml = short,
}

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
