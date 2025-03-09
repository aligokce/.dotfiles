set nocompatible  " no surprises

" Visual
if has('filetype')
    filetype indent plugin on
endif
if has('syntax')
    syntax on
endif
if has('mouse')
    set mouse=a  " mouse for all modes
endif
set textwidth=79
set scrolloff=3  " show at least 3 lines above/below
set laststatus=2  " always display the status line
set wrap
set number  " display line number
set relativenumber
set ruler  " display the cursor position in the bottom right corner
set nostartofline  " retain the horizontal position of the cursor
set showmode
set showcmd  " show partial vim commands
set ttyfast  " rendering


" Input
set backspace=indent,eol,start  " allow backspacing in places
set clipboard=unnamed  " allow yy to interact with system clipboard
set tabstop=4
set shiftwidth=4
set autoindent smartindent
set smarttab  " better backspace and tab functionality
set history=500  " expanded


" Interactions
set noerrorbells  " turn off audio bell
set visualbell  " but leave on a visual bell
set hidden  " re-use the same window and switch from an unsaved buffer
set confirm  " ask to save changed files instead of giving error
set wildmenu  " better command-line completion
set path+=**  " fuzzy search on auto-complete


" Search
set ignorecase " case-insensitive search
set smartcase  " except when using capital letters
set hlsearch
set incsearch
set showmatch


" Mappings
nnoremap <space> :
map Y y$ 
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif


" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" File browsing ~ git@changemewtf/no_plugins
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings


set nomodeline  " shut down a common source of vulnerabilities


" Load local settings if they exist
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

