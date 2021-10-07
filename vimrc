set nocompatible   " Disable backwards compatibility
set nofixendofline " Don't spam diffs by inserting trailing newlines
" Notes on tracking down inexplicable behavior, e.g. when a new Vim version
" adds a default plugin which interferes with something:
"
" `:scriptnames` lists all loaded plugins and vimrcs, including everything included by default.
" `:function` lists all functions
" `:function <func` shows details about `<func>`
" `:set runtimepath` to track down where it came from in the first place.
" `:set all` shows current options except terminal.
" `:set` shows all options that differ from their default value.
" `:verbose set <thing>?` shows where <thing> was set
" `:map` to see all mappings
" <F10> to see highlight group word under cursor belongs to -- for debugging
" colorshemes and syntax files:
nmap <silent> <F10>   :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Vundle package manager setup:
filetype off                                " Required by Vundle, re-enabled later
set runtimepath+=~/.vim/bundle/Vundle.vim   " Vundle needs to be git cloned here
call vundle#begin('~/.vim/bundle')          " Path where Vundle installs plugins
Plugin 'VundleVim/Vundle.vim'               " Let Vundle manage Vundle, required

" Show git diff in sign column ("gutter") and navigate/stage changes -- see
" cheat sheet:
Plugin 'airblade/vim-gitgutter'
" `updatetime` is the number of milliseconds with no keypresses before vim writes to
" swap file. Also affects how quickly vim-gitgutter notices changes.
set updatetime=100
" Max number of changes can be limited for performance:
"let g:gitgutter_max_signs = 500  " 500 is default

" Git wrapper -- see cheat sheet:
Plugin 'tpope/vim-fugitive'

" Open current file in Github with `:OpenFileGithub`. Mark specific lines with
" visual selection.
Plugin 'tyru/open-browser.vim'
Plugin 'tyru/open-browser-github.vim'

" Asynchronous Lint Engine -- acts as an LSP client
let g:ale_sign_error = '☠️' " Is the world finally ready for unicode in the terminal...?
hi ALEErrorSign ctermbg=black
let g:ale_sign_warning = '⚠️'
hi ALEWarningSign ctermbg=black
" g:ale_lint_delay is #ms after typing stops before linter is run. Default 200.
" May be a performance hog.
let g:ale_lint_delay = 50
let b:ale_fixers = {'python': ['autopep8']}
Plugin 'w0rp/ale'
nmap <silent> <C-n> <Plug>(ale_next_wrap)
nmap <silent> <C-m> <Plug>(ale_previous_wrap)
" For some inexplicable reason mapping ale_previous_map to <C-m> also maps
" <CR>, which breaks the quickfix window (and probably other stuff as well),
" so it needs to be unmapped:
unmap <CR>

" Get current tag (e.g. `class.method`) in status bar:
Plugin 'mgedmin/taghelper.vim'

" Sidebar for browsing tags. Needs ctags-exuberant (sudo apt install ctags).
Plugin 'majutsushi/tagbar'
" Toggle with CTRL-t:
nmap <C-t> :TagbarToggle<CR>
" Sort tags by order in file, not name:
let g:tagbar_sort = 0

" Consistent navigation between vim and tmux splits using CTRL-<hjkl>
Plugin 'christoomey/vim-tmux-navigator'

" Pytest test runner:
Plugin 'alfredodeza/pytest.vim'

" Highlight untested Python lines using a coverage report. E.g.:
" `pip install coverage; coverage run --source <package> -m pytest` to
" generate `.coverage` file. `:HighlightCoverage` to enable.
Plugin 'mgedmin/coverage-highlight.vim'

" Autocompletion and other goodness using Jedi (same as IPython):
Plugin 'davidhalter/jedi-vim'
let g:jedi#use_splits_not_buffers = "disable"

" Do autocompletion using <Tab>:
Plugin 'ervandew/supertab'

" Reopen files at your last edit position:
Plugin 'farmergreg/vim-lastplace'

" Surround/unsurround text objects (e.g. add/change/remove quotes/tags)
Plugin 'tpope/vim-surround'

Plugin 'michaeljsmith/vim-indent-object'

" Makes `.` work with vim-surround and some other plugins. Supporting
" additional plugs can be done with e.g.:
" silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
Plugin 'tpope/vim-repeat'

" Fancy replacement for builtin matchit plugin. Additional config for matches below.
" By default it shows off-screen matches in the status bar. Disable:
let g:matchup_matchparen_offscreen = {'method': 'status_manual'}
" Adds a small delay so it's not constantly recomputing when moving cursor,
" for performance reasons:
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 25
Plugin 'andymass/vim-matchup'

" Colorsheme packs:
Plugin 'danilo-augusto/vim-afterglow'

Plugin 'preservim/nerdtree'
let NERDTreeShowHidden=1 " Show .files
set wildignore+=*.pyc,*.swp,*.swo,*.class,*.DS_Store
let NERDTreeRespectWildIgnore=1
" Adds filetype glyphs to NERDTree and other plugins; needs to be loaded last;
" needs a compatible font from https://github.com/ryanoasis/nerd-fonts
Plugin 'ryanoasis/vim-devicons'

Plugin 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

set rtp+=/usr/local/opt/fzf
Plugin 'junegunn/fzf.vim'

call vundle#end()   " Required -- all Plugins must be added before this line
filetype on         " Re-enable filetype detection; syntax highlighting, options, etc.
                    " (all `FileType` configs must come after this)
filetype plugin on  " Load plugins for specific filetypes
filetype indent on  " Load filetype specific indent rules

syntax on           " Enable syntax highlighting

let g:afterglow_inherit_background=1 " Make afterglow play nicely with terminal/tmux
try
    " try/catch so this won't error on first (setup) run
    colorscheme afterglow
catch
endtry

" Undo/history:
set undodir=~/.vim/undodir
set undofile
set history=500     " Command-line history; default 50

" Tab settings:
set expandtab       " Expand <Tab> to spaces in insert mode. CTRL-V<Tab> forces real tab
set tabstop=4       " <Tab> == 4 spaces
set softtabstop=4   " Treat 4 spaces as a tab for BACKSPACE and DELETE
set shiftwidth=0    " 0 = default to `tabstop` value
set autoindent      " Auto-indent reasonably for filetypes without specific indentation rules
" File type specific tab settings
autocmd FileType javascript setlocal tabstop=2 softtabstop=2

set backspace=indent,eol,start " Make backspace behave normally in insert mode

set wrap linebreak          " Wrap long lines at word boundries
set whichwrap+=<,>,h,l,[,]  " Wrap using cursor and h / l keys:
" Make up/down/home/end use display line instead of physical line:
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
nnoremap <Home> g<Home>
nnoremap <End>  g<End>
vnoremap <Home> g<Home>
vnoremap <End>  g<End>

set number          " Show line number
set laststatus=2    " Always show statusline, even with just one window
set showtabline=1   " Show tab bar if there's more than one tab
set showcmd         " Show partial commands (operator-pending mode) on last line

set incsearch       " Incremental search
set hlsearch        " Highligt matches
set ignorecase      " Case-insensitive search...
set smartcase       " ...except when mixing upper and lower case
nnoremap * g*       " Match partial when using `*`, so `foo` matches `foobar`
nnoremap # g#       " Like `*` but backwards
" Search result styling:
hi clear Search     " Disable whatever the current colorscheme did
hi Search ctermbg=black guibg=black cterm=bold gui=bold

" Command window tab completion behavior:
set wildmenu
set wildmode=list:longest

" Highlight words matching word under cursor:
"autocmd CursorMoved * silent! exe printf('match IncSearch /\<%s\>/', expand('<cword>'))

" Matching -- character/word group you can jump between with `%`:
"set matchpairs=(:),{:},[:],<:> " Not needed with vim-matchup
" Italicize matched words:
hi clear MatchParen
hi MatchParen cterm=italic gui=italic
" Adds rudimentary but janky support for matching Python syntax (which
" vim-matchup and seemingly every other matching plugin doesn't support).
" Details here: https://github.com/andymass/vim-matchup/issues/68
" Groups are comma-separated, terms in the group are colon separated.
autocmd FileType python let b:match_words = '^\(\s*\)\<if\>:^\1\<elif\>:^\1\<else\>,^\(\s*\)\<try\>:^\1\<except\>:^\1\<else\>'

" Highlight trailing whitespace, but not in insert mode:
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
" Trim trailing whitespace for whole file:
function! TrimWhiteSpace()
            %s/\s\+$//e
endfunction

set mouse=n         " Use mouse, but only in normal mode.
set ttymouse=sgr    " Needed for mouse to work with wide (>220 cols) terminals.

let mapleader = "," " Make , <Leader>

" Comment out visual block using ,<comment sign>, uncomment using ,c.
map ,# :s/^/#/<CR>:nohlsearch<CR>
map ,/ :s/^/\/\//<CR>:nohlsearch<CR>
map ,> :s/^/> /<CR>:nohlsearch<CR>
map ," :s/^/\"/<CR>:nohlsearch<CR>
map ,% :s/^/%/<CR>:nohlsearch<CR>
map ,! :s/^/!/<CR>:nohlsearch<CR>
map ,; :s/^/;/<CR>:nohlsearch<CR>
map ,- :s/^/--/<CR>:nohlsearch<CR>
map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>:nohlsearch<CR>

" Make Y behave like other capitals -- yank rest of line:
map Y y$
" <Leader>p pastes to new line, even if register doesn't have a newline char:
nmap <Leader>p :pu<CR>

" Switch to Swedish
function! SweType()
  set spelllang=sv
  inoremap ; ö
  inoremap ;; ;
  inoremap : Ö
  inoremap :: :
  inoremap [ å
  inoremap { Å
  inoremap ' ä
  inoremap '' '
  inoremap " Ä
  inoremap "" "
  inoremap [[ [
  inoremap {{ {
endfunction
nmap <Leader>s :<C-U>call SweType()<CR>

" Switch back to English
function! EngType()
  set spelllang=en_us
  inoremap ; ;
  iunmap ;;
  inoremap : :
  iunmap ::
  inoremap [ [
  iunmap [[
  inoremap { {
  iunmap {{
  inoremap ' '
  iunmap ''
  inoremap " "
  iunmap ""
endfunction
nmap <Leader>e :<C-U>call EngType()<CR>

" Automatically reformat paragraphs as you type
function! Prose()
    " formatoptions:
    " `t` makes text wrap on `textwidth`
    " `a` turns on real-time reformatting
    " `n` to recognize lists
    setlocal formatoptions=antcq
    setlocal textwidth=80
    setlocal wrapmargin=0
    setlocal nonumber
    setlocal foldcolumn=10
	" Make `n` formatoption also recognize bullet (- or *) lists
    let &formatlistpat='^\s*\(\d\+[\]:.)}\t ]\|[*-][\t ]\)\s*'
endfunction


" Set up statusline:
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

function! ALEErrors() abort
    " Return " E: <number-of-ale-errors> ", or an empty string
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    return l:all_errors == 0 ? '' : printf(' E: %d ',  all_errors)
endfunction

function! ALEWarnings() abort
    " Return " W: <number-of-ale-warnings> ", or an empty string
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:all_non_errors == 0 ? '' : printf(' W: %d ',  all_non_errors)
endfunction
highlight WarningMsg ctermbg=yellow guibg=yellow ctermfg=black guifg=black

set statusline=
set statusline+=%#PmenuSel#             " This sets highlight group (color)
set statusline+=%{GitStatus()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\                     " Trailing whitespace really needed
set statusline+=%{taghelper#curtag()}
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\                       " Trailing whitespace really needed...
set statusline+=%#ErrorMsg#
set statusline+=%{ALEErrors()}
set statusline+=%#WarningMsg#
set statusline+=%{ALEWarnings()}
