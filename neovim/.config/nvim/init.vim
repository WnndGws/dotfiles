"""--------------------"""
"""--- XDG SETTINGS ---"""
"""--------------------"""
set undodir=$XDG_DATA_HOME/nvim/undo
set directory=$XDG_DATA_HOME/nvim/swap
set backupdir=$XDG_DATA_HOME/nvim/backup
set viewdir=$XDG_DATA_HOME/nvim/view

"""------------------------"""
"""--- GENERAL SETTINGS ---"""
"""------------------------"""
"New lines inherit the indentation of previous lines
set autoindent

"Line numbers are good
set number

"Have a line under the cursor
set cursorline

"Save a history
set history=1000

"Show incomplete cmds down the bottom
set showcmd

" '.' is an end of word designator
set iskeyword-=.
" '"' is an end of word designator
set iskeyword-="
" '-' is an end of word designator
set iskeyword-=-
" '_' is an end of word designator
set iskeyword-=_

" Case insensitive search
set ignorecase

" Case sensitive when upper case present
set smartcase

" Uses spellcheck in nvim
set spell spelllang=en_au

"Insert “tabstop” number of spaces when the “tab” key is pressed.
set smarttab
set shiftwidth=4
set expandtab
"When shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
set shiftround

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

"Do wrap lines
set wrap

"Avoid wrapping a line in the middle of a word.
set linebreak

"Dont fold
set nofoldenable

"""--------------"""
"""---Keyboard---"""
"""--------------"""
let mapleader = ','

"Stolen from CIA Hack, save file you forgot to open as root
cmap w!! %!sudo tee > /dev/null %

"Pressing :sc will toggle and untoggle spell checking
map <leader>sc :setlocal spell!<cr>

"Spell add word to dictionary
" ]s is go to next spelling error
" zg adds to dictionary
map <leader>sa <Esc>]szg

"Spell correct next spelling error to 1st suggestsion
" ]s is go to next spelling error
" 1z= accepts the first suggestion
map <leader>cs <Esc>]s1z=

" Save file using leader w
nnoremap <Leader>w :w<CR>

"Remaps backspace to move back a paragraph
nnoremap <BS> {
onoremap <BS> {
vnoremap <BS> {

" " Copy to clipboard using leader
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard using leader
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

"""---------------"""
"""--- Plugins ---"""
"""---------------"""
"Use a different location, so its not added to my dotfiles
call plug#begin('~/.config/nvim_plugged')
"Linter
Plug 'https://github.com/w0rp/ale.git'

"improved incrimental searching
Plug 'https://github.com/haya14busa/incsearch.vim.git'

"tables in vim
Plug 'https://github.com/dhruvasagar/vim-table-mode.git'

"indent guides
Plug 'https://github.com/Yggdroot/indentLine.git'

"vim expand
Plug 'https://github.com/terryma/vim-expand-region.git'

"latex and vim
Plug 'https://github.com/lervag/vimtex.git'

"vim surround
Plug 'https://github.com/tpope/vim-surround.git'

"polyglot for syntax highlighting
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'https://github.com/chrisbra/csv.vim' "polyglot-csv
"Plug 'https://github.com/LaTeX-Box-Team/LaTeX-Box' "polyglot-latex
Plug 'https://github.com/vim-python/python-syntax' "polyglot-python
Plug 'https://github.com/rust-lang/rust.vim' "polyglot-rust
Plug 'https://github.com/elzr/vim-json' "polyglot-json
Plug 'https://github.com/plasticboy/vim-markdown' "polyglot-markdown
Plug 'https://github.com/baskerville/vim-sxhkdrc' "polyglot-sxhkd
Plug 'https://github.com/wgwoods/vim-systemd-syntax' "polyglot-systemd

"Ultisnips
"Ultisnips is the completion engine that reads vim-snippets
Plug 'https://github.com/sirver/ultisnips'
Plug 'https://github.com/WnndGws/vim-snippets'

"Youcompleteme
""Need YouCompleteMe for a nice popup interface for ultisnips
Plug 'https://github.com/ycm-core/YouCompleteMe'

call plug#end()

""""""
"""ALE
""""""
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_lint_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_list_vertical = 1

" install from AUR: shellcheck-bin, python-pylint
let g:ale_linters ={'zsh': ['shellcheck'], 'sh': ['shellcheck'], 'latex': ['chktex'], 'python': ['pylint'],'rust': ['cargo']}

""""""""""""
"""INCSEARCH
""""""""""""
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

""""""""""""
"""TABLEMODE
""""""""""""
" default tablemode is ,tm
" Use markdown compatible tables
let g:table_mode_corner='|'

"""""""""""""
"""INDENTLINE
"""""""""""""
let g:indentLine_char = '|'

"""""""""""""
"""VIM-EXPAND
"""""""""""""
"Hit v to visually select character, again to select word, again to select paragraph
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

""""""""""""
"""ULTISNIPS
""""""""""""
" Trigger configuration. Do not use <tab> if you use YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<S-f>"
let g:UltiSnipsJumpBackwardTrigger="<S-b>"

""""""""""""""""
"""YOUCOMPLETEME
""""""""""""""""
let g:ycm_key_list_select_completion = ['<Down>', 'J']
let g:ycm_key_list_previous_completion = ['<Up>', 'K']
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_auto_trigger = 1
let g:ycm_auto_hover = ''
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

""""""""""""""""
"""Vimtex
""""""""""""""""
"Prevent conceal in LaTeX files
let g:tex_conceal = ''

"""-----------------"""
""" GENERAL SETTINGS"""
"""-----------------"""
"Needs to be set last to allow all plugins to do their thing
"Enable syntax highlighting
syntax enable
au BufNewFile,BufRead * if &syntax == '' | set syntax=dosini | endif

"Use skeleton files
if has('autocmd')
    augroup skeletons
        autocmd BufNewFile *.py 0r $XDG_CONFIG_HOME/nvim/templates/skeleton.py
        autocmd BufNewFile *.timer 0r $XDG_CONFIG_HOME/nvim/templates/skeleton.timer
        autocmd BufNewFile *.sh 0r $XDG_CONFIG_HOME/nvim/templates/skeleton.sh
        autocmd BufNewFile *.service 0r $XDG_CONFIG_HOME/nvim/templates/skeleton.service
        autocmd BufNewFile *.tex 0r $XDG_CONFIG_HOME/nvim/templates/skeleton_docs.tex
        autocmd BufNewFile *beamer*.md 0r $XDG_CONFIG_HOME/nvim/templates/skeleton_beamer.md
    augroup END
endif
