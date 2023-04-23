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
" Set text files as text not unknown
autocmd BufNewFile,BufRead *.txt set filetype=txt

"Always show statusline
set laststatus=2

"Status line
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%{StatuslineGit()}
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\

"New lines inherit the indentation of previous lines
set autoindent

"Set window titles
set title

"Line numbers are good
set number
set relativenumber

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
set spell !

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

" Replace space with newline using leader n
nnoremap <Leader>n whciw\n<Esc>:w<CR>

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
"Startup time
Plug 'https://github.com/dstein64/vim-startuptime'

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

"gists in vim
Plug 'https://github.com/mattn/vim-gist'
Plug 'https://github.com/mattn/webapi-vim'

"latex and vim
Plug 'https://github.com/lervag/vimtex.git'

"git fugitive
Plug 'https://github.com/tpope/vim-fugitive'

"git abolish
Plug 'https://github.com/tpope/vim-abolish'

"vim surround
Plug 'https://github.com/tpope/vim-surround.git'

"vim easymotion
Plug 'https://github.com/easymotion/vim-easymotion'

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

"CoC
""Conquer of Completion
"Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"To install my plugins run:
"pikaur -S yarn
"Cocinstall coc-json coc-jedi coc-markdownlint coc-sh coc-snippets coc-texlab coc-vimlsp coc-tsserver coc-eslint coc-json coc-prettier coc-css coc-vimtex coc-html
"pip install -U jedi-language-server
"pikaur -R yarn

"vim-snippets used by coc-snippets
Plug 'https://github.com/honza/vim-snippets'

"vim-folding
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'

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

" install from AUR: shellcheck-bin, python-flake8
let g:ale_linters ={'txt': [], 'zsh': ['shellcheck --shell=bash'], 'sh': ['shellcheck'], 'latex': ['chktex'], 'python': ['flake8'],'rust': ['cargo']}

""""""""""
"""GISTVIM
""""""""""
let g:gist_clip_command = 'xclip -selection clipboard'
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
let g:gist_show_privates = 1
let g:gist_post_private = 1
let g:gist_token_file = stdpath('config') . '/gist-vim'

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
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<S-f>"
"let g:UltiSnipsJumpBackwardTrigger="<S-b>"

""""""""""""""""
"""YOUCOMPLETEME
""""""""""""""""
"let g:ycm_key_list_select_completion = ['<Down>', 'J']
"let g:ycm_key_list_previous_completion = ['<Up>', 'K']
"let g:ycm_min_num_of_chars_for_completion = 2
"let g:ycm_auto_trigger = 1
"let g:ycm_auto_hover = ''
"let g:ycm_autoclose_preview_window_after_completion = 1
"let g:ycm_autoclose_preview_window_after_insertion = 1

"""""""""
"""VIMTEX
"""""""""
"Prevent conceal in LaTeX files
let g:tex_conceal = ''
let g:tex_flavor = 'latex'

""""""""""""""""
"""VIM-MARKDOWN
""""""""""""""""
"Disable folding
let g:vim_markdown_folding_disabled = 1

"Disable concealing (which is hiding the ** in *italics*)
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

""""""""""""""""
"""VIM-EASYMOTION
""""""""""""""""
"Disable default mappings
let g:EasyMotion_do_mapping = 0

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap f <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
"nmap f <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

""""""
"""CoC
""""""
" May need for vim (not neovim) since coc.nvim calculate byte offset by count
" utf-8 byte sequence.
set encoding=utf-8
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
        autocmd BufNewFile README 0r $XDG_CONFIG_HOME/nvim/templates/skeleton.readme
    augroup END
endif
