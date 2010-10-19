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

" Maximalize on fullscreen
if has("gui_running")
  set fuoptions=maxvert,maxhorz
endif

" Hot keys
map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
map <D-8> :tabn 8<CR>
map <D-9> :tabn 9<CR>
map <D-0> :tabn 10<CR>
nmap <D-r> :wall<CR>:Rake<CR>
imap <D-r> <Esc>:wall<CR>:Rake<CR>
nmap <D-R> :wall<CR>:.Rake<CR>
imap <D-R> <Esc>:wall<CR>:.Rake<CR>
