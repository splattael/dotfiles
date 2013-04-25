colorscheme darkblue

"set background=dark
"colorscheme solarized

" Presentation mode: railscasts colorscheme + bigger font
map <F5> <ESC>:colorscheme railscasts<CR><ESC>:set guifont=Monospace\ 14<CR>
map <F6> <ESC>:colorscheme darkblue<CR><ESC>:set guifont=inconsolata\ 13<CR>

" do not highlight vim gutter on the right
highligh clear SignColumn
