return {
    name = "ALE", url = "https://github.com/dense-analysis/ale",
    config = function()
        vim.g.ale_fixers = {
            c = { "ccls", "clangtidy", "uncrustify" },
            cpp = {"ccls", "clangtidy", "uncrustify"},
            python = {
                "autopep8",
                "add_blank_lines_for_python_control_statements",
                "remove_trailing_lines",
                "trim_whitespace",
            },
        }
        local ale_fixers = vim.g.ale_fixers
        ale_fixers["*"] = {"remove_trailing_lines", "trim_whitespace" }
        vim.g.ale_fixers = ale_fixers

        vim.g.ale_linters = {
            c = {"ccls", "clangd"},
            cpp = {"ccls", "clangd"},
            python = {"flake8"},
        }
        vim.g.ale_c_parse_compile_commands = 1
        vim.g.ale_completion_enabled = 0 -- disable completion, use COQ instead
    end,
}
