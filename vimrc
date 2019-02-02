set nocompatible      " We're running Vim, not Vi!
syntax on             " Enable syntax highlighting
set hls
set sw=2 ts=2 sts=2 et
set visualbell
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

set encoding=utf8 fileencoding=utf8
let mapleader=","

" Set timeout for leader key to 300ms
set timeoutlen=300

" non-visible chars
set list
set listchars=tab:▸\ ,trail:.,extends:<,precedes:>,eol:·,nbsp:⋅
nmap <leader>l :set list!<CR>
nmap <leader>W :KillWhitespace<CR>
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>
" Clear current search highlight by double tapping //
nmap <silent> 7 :nohlsearch<CR>

" Fuzzy file search
set runtimepath+=~/.fzf
set runtimepath+=~/.vim/bundle/fzf.vim

nmap <leader>f :Files<CR>
nmap <leader>F :Buffers<CR>
nmap <leader>ff :GFiles<CR>
nmap <leader>FF :GFiles?<CR>
nmap <leader>h :History<CR>
nmap <leader>H :History:<CR>
nmap <leader>/ :Rg<Space>

" Tags with ctags
function! UpdateTags()
  let cwd = getcwd()
  let tagfilename = cwd . "/.tags"
  echo "Updating ctags in " . tagfilename
  let cmd = 'ctags -R -f ' . tagfilename . ' ' . ' --exclude=@$HOME/.ctags-exclude "' . cwd . '"'
  let resp = system(cmd)
endfunction

nmap <leader>t :Tags<Space>
nmap <leader>T :BTags<Space>
nmap <leader>tt :call UpdateTags()<CR>
set tags=.tags;/.tags

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

" colorscheme
set background=dark
colorscheme spacegray

" fugitive leader mappings
nmap <leader>gd :Gdiff<CR>
nmap <leader>gst :Gstatus<CR>
nmap <leader>gc :Gcommit -v<CR>
nmap <leader>gca :Gcommit -av<CR>
nmap <leader>gaa :Git add --all<CR>
nmap <leader>gp :Git push<CR>

" Spell checking
" See http://robots.thoughtbot.com/vim-spell-checking/
autocmd FileType gitcommit setlocal spell
set complete+=kspell

nnoremap <F3> :set nospell!<CR>

" highlight lines longer than 80 chars
highlight LineProximity ctermfg=white ctermbg=gray guifg=white guibg=#757160
highlight LineOverflow  ctermfg=white ctermbg=red guifg=white guibg=#FF2270

autocmd BufEnter,VimEnter,FileType *.rb,*.coffee let w:m1=matchadd('LineProximity', '\%<85v.\%>80v', -1)
autocmd BufEnter,VimEnter,FileType *.rb,*.coffee let w:m2=matchadd('LineOverflow', '\%>84v.\+', -1)
autocmd BufEnter,VimEnter,FileType,VimEnter *.rb,*.coffee autocmd WinEnter *.rb,*.coffee let w:created=1
autocmd BufEnter,VimEnter,FileType,VimEnter *.rb,*.coffee let w:created=1

" file completion
" See http://stackoverflow.com/questions/526858/how-do-i-make-vim-do-normal-bash-like-tab-completion-for-file-names/526881#526881
set wildmode=longest,list,full
set wildmenu

" Elm
nnoremap <leader>el :ElmEvalLine<CR>
vnoremap <leader>es :<C-u>ElmEvalSelection<CR>
nnoremap <leader>em :ElmMakeCurrentFile<CR>
let g:elm_format_autosave = 1

" Crystal
let g:crystal_define_mappings=0
autocmd FileType crystal nmap <F2> :CrystalSpecRunCurrent<CR>
autocmd FileType crystal nmap <S-F2> :CrystalSpecRunAll<CR>

" Disable netrw history
let g:netrw_dirhistmax=0

" Rust
let g:rustfmt_autosave = 1

" Enable Ruby Format rufo
let g:rufo_auto_formatting = 0

" Abosolute + realtive line numbers
" Refs: https://jeffkreeftmeijer.com/vim-number/
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Open URL under cursor with gnome-open
" See https://vi.stackexchange.com/a/5034
let g:netrw_browsex_viewer="setsid gnome-open"

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERDTree
nmap <leader>N :NERDTreeToggle<CR>
