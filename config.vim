set encoding=UTF-8
set nocompatible

" path to vim config dir
let g:vim_config_path = fnamemodify(resolve(expand('$MYVIMRC:p')), ':h')
" path to user config dir
let g:user_config_path = resolve(g:vim_config_path . '/..')

" normal mode movements
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap ; l

" visual move movements
vnoremap j h
vnoremap k j
vnoremap l k
vnoremap ; l
" FIXME remove this nonsense
" normal mode window commands
let g:WindowMoveRemaps = {"j": "wincmd h",
            \"k": "wincmd j",
            \"l": "wincmd k",
            \";": "wincmd l",
            \"J": "wincmd H",
            \"K": "wincmd J",
            \"L": "wincmd K",
            \":": "wincmd L",
            \"=": "wincmd =",
            \}
nnoremap  :call UltraRemapWithCount(g:WindowMoveRemaps)<CR>

" FZF sanity
nnoremap :W :w
nnoremap <c-f> :FZF

function! s:is_number(chr)
	return a:chr ># "0" && a:chr <# "9"

endfunction

function! UltraRemapWithCount(map)
    """ remap a single character with a count.
	let l:count_str = ""
	let l:current_char = nr2char(getchar())
	let l:command_str = ""
	" extract a count from what the user is typing
	while s:is_number(l:current_char)
		let l:count_str .= l:current_char
	let l:current_char = nr2char(getchar())
	endwhile

	if has_key(a:map, l:current_char)
		execute count_str . get(a:map, l:current_char)
	else
		echo "Unknown map: " . l:current_char
	endif

endfunction


" Formatting Sanity
set number
set relativenumber

" colors and 80-col highlight
if (has("termguicolors"))
    set termguicolors
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif

highlight ColorColumn ctermbg=0 guibg=#2c2c2c
let &colorcolumn="81"
syntax on

" Tagbar, open Ex in new tab
nmap t :TagbarToggle
"
" Filetype builtin magic
filetype on
filetype plugin on
filetype indent on
syntax on
