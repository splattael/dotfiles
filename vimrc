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

nmap <leader>f :GFiles<CR>
nmap <leader>F :Buffers<CR>
nmap <leader>ff :Files<CR>
nmap <leader>fs :GFiles?<CR>
nmap <leader>h :History<CR>
nmap <leader>H :History:<CR>
nmap <leader>/ :Rg<Space>
nmap g<leader>/ :execute "Rg " . expand('<cword>')<CR>

" ale
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.total - l:all_errors

    if l:counts.total == 0
      return ''
    endif

    if l:all_errors > 0 && l:all_warnings > 0
      return printf('%d⭕ %d🔴 ', all_warnings, all_errors)
    endif

    if l:all_errors > 0
      return printf('%d🔴 ', all_errors)
    endif

    return printf('%d⭕', all_warnings)
endfunction

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
set statusline=
set statusline+=%<%f\ %h%m%r               " file etc.
set statusline+=%{fugitive#statusline()}\  " git status
set statusline+=%{LinterStatus()}          " ale linter status
set statusline+=%=%-14.(%l,%c%V%)          " (line,column)
set statusline+=\ %P                       " percent

" splits
set splitbelow
set splitright

" pathogen
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" colorscheme
set background=dark
colorscheme codedark

" fugitive leader mappings
nmap <leader>gd :Git diff<CR>
nmap <leader>gst :Git<CR>
nmap <leader>gc :Git commit -v<CR>
nmap <leader>gca :Git commit -av<CR>
nmap <leader>gaa :Git add --all<CR>
nmap <leader>gp :Git push<CR>

" Spell checking
" See http://robots.thoughtbot.com/vim-spell-checking/
autocmd FileType gitcommit setlocal spell
set complete+=kspell

nmap <leader>S :set nospell!<CR>
nmap <leader>R :source $MYVIMRC<CR>

" highlight lines longer than 80 chars
highlight LineProximity ctermfg=white ctermbg=gray guifg=white guibg=#757160
highlight LineOverflow  ctermfg=white ctermbg=red guifg=white guibg=#FF2270

autocmd BufEnter,VimEnter,FileType *.rb,*.coffee let w:m1=matchadd('LineProximity', '\%<120v.\%>80v', -1)
autocmd BufEnter,VimEnter,FileType *.rb,*.coffee let w:m2=matchadd('LineOverflow', '\%>119v.\+', -1)
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

nmap gx :silent execute "!xdg-open " . shellescape("<cWORD>")<CR>

" Rust
let g:rustfmt_autosave = 1

" Abosolute + realtive line numbers
" Refs: https://jeffkreeftmeijer.com/vim-number/
:set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" NERDTree
nmap <leader>N :NERDTreeToggle<CR>

" persistent undo
silent exec "!mkdir -p $HOME/.cache/vim/undo"
set undofile
set undodir=$HOME/.cache/vim/undo

if exists(":Tabularize")
  nmap <leader>a= :Tabularize /=<CR>
  vmap <leader>a= :Tabularize /=<CR>
  nmap <leader>a: :Tabularize /:\zs<CR>
  vmap <leader>a: :Tabularize /:\zs<CR>
  nmap <leader>a> :Tabularize /\|<CR>
  vmap <leader>a> :Tabularize /\|<CR>
endif

set regexpengine=1
set synmaxcol=256
set nocursorcolumn
set nocursorline

" vim-gutter
highlight clear SignColumn
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1

" ale configuration
let g:ale_ruby_rubocop_executable = 'bundle'
" Only check on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" disable brakeman because it's slow
let g:ale_linters_ignore = {
      \ 'ruby': ['brakeman'],
      \   'typescript': ['eslint'],
      \}

let g:ale_linters = {
  \ 'json': ['jq']
  \ }

" Disable key navigation (almost hardmode)
" See https://vi.stackexchange.com/a/25848
for key in [
      \ '<Up>', '<Down>', '<Left>', '<Right>', '<Home>', '<End>',
      \ '<PageUp>', '<PageDown>',
      \ '<C-W><Up>', '<C-W><Down>', '<C-W><Left>', '<C-W><Right>'
      \ ]
  exec 'noremap' key '<Nop>'
  exec 'inoremap' key '<Nop>'
endfor

let g:snipMate = { 'snippet_version' : 1 }
