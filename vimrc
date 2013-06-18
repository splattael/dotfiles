set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
set hls
set sw=2 ts=2 sts=2 et
set number
set visualbell
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set encoding=utf8 fileencoding=utf8
let mapleader=","

" non-visible chars
set list
set listchars=tab:▸\ ,trail:.,extends:<,precedes:>,eol:·,nbsp:⋅
nmap <leader>l :set list!<CR>
nmap <leader>W :KillWhitespace<CR>
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>
nnoremap <leader><space> :noh<cr>

" nmap <leader>t :CommandT<CR>
" nmap <leader>T :CommandTFlush<CR>:CommandT<CR>
nmap <leader>t :CtrlPMixed<CR>
nmap <leader>T :CtrlPClearAllCaches<CR>:CtrlPMixed<CR>

map yc zc

" Fonts
set guifont=inconsolata\ 13

" statusline
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" splits
set splitbelow
set splitright

" pathogen
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" gem-ctags
autocmd FileType ruby let &l:tags = pathogen#legacyjoin(pathogen#uniq(pathogen#split(&tags) + map(split($GEM_PATH,':'),'v:val."/gems/*/tags"')))

" do not highlight vim gutter on the right
highligh clear SignColumn

" fugitive leader mappings
nmap <leader>gd :Gdiff<CR>
nmap <leader>gst :Gstatus<CR>
nmap <leader>gc :Gcommit -v<CR>
nmap <leader>gca :Gcommit -av<CR>
nmap <leader>gaa :Git add --all<CR>
