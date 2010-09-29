call pathogen#runtime_append_all_bundles()

" filtype plugin indent on
set tabstop=2
set smarttab
set shiftwidth=2
set autoindent
set expandtab

" Disable compatibility with VI - gives all VIM capabilities
set nocompatible

" Show ruler - line, column and percentage location of cursor
set ruler

" Menubar with hiding
set guioptions=t

" Numbers on lines
set number

" Do not highlight search results
set nohls

" Live search
set incsearch

" Context set to two lines
set scrolloff=2

" Show mode in left-bottom corner of screen
set showmode

" Show command in right-bottom corner of screen
set showcmd

" Show non printable characters (spaces, tabs and EOLs)
" '¬' requires utf-8 compatible terminal
set listchars=tab:>-,trail:-,eol:¬
set list

" Move last single character into another line
set formatoptions+=1

" Show as many as you can in last line.
set display+=lastline

" Easy paste toggle. Useful.
set pastetoggle=<F6>

" Always show status line
set laststatus=2

" Our favourite colors
colorscheme blackboard

" Our favorite font
set guifont=Monaco:h16

" Highlight syntax
syntax on

" Recognize file types and enable proper plugins and indent
filetype plugin indent on

" Move cursor in last known position in opened file
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

" Do not allow to modify readonly files
" Nie pozwalaj na żadne modyfikacje plików tylko do odczytu.
au BufReadPost * :call CheckReadonly()
function! CheckReadonly()
	if version >= 600
	        if &readonly
			setlocal nomodifiable
		endif
	endif
endfunction

" Benoit Cerrina tab completion + A. addittion tip#102
" Autocomplete via <Tab>
function! InsertTabWrapper(direction)
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	elseif "backward" == a:direction
		return "\<c-p>"
	else
	        return "\<c-n>"
	endif
endfunction
inoremap <Tab> <C-R>=InsertTabWrapper("backward")<cr>
inoremap <S-Tab> <C-R>=InsertTabWrapper("forward")<cr>

" Run fullscreen by default
if has("gui_running")
  au GUIEnter * set fullscreen
  set fuoptions=maxvert,maxhorz
endif
