return {
    {
        name = "fzf.vim", url = "https://github.com/junegunn/fzf.vim",
        cmd = {
	    "FZF", "Files", "GFiles", "Buffers", "Colors", "Ag", "Rg", "RG",
	    "Lines", "BLines", "Tags", "BTags", "Changes", "Marks", "Jumps",
	    "Windows", "Locate", "History", "Snippets", "Commits", "BCommits",
	    "Commands", "Maps", "Helptags", "Filetypes"
        },
	dependencies = "fzf",

    },
    {
        name = "fzf", url = "https://github.com/junegunn/fzf",
        cmd = { "FZF" },
    },
}
