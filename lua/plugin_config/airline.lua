vim.g.airline_powerline_fonts = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g.airline_section_b = "%{fugitive#statusline()} %<%f %=%-14.(%l,%c%V%)"
vim.g.tmuxline_preset = 'tmux'

return {
    name = "airline", url = "https://github.com/vim-airline/vim-airline",
}
