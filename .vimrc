"---------------------------------------------
"Colors

"my terminal supports 256 collors
set t_Co=256
set background=dark
"Setting my coloscheme
colorscheme xoria256


"---------------------------------------------
"Misc

"Show rownumbers
set number
"But let us switch to relative numbers using a
"simple function.
"We can map this to a hot key in the  key map
"section
function! NumberToggle()
	if(&relativenumber == 1)
	  set number
	else
		set relativenumber
	endif
endfunc



"I don't want to backup filese 
set nobackup
set noswapfile
set modelines=0

"Indent by 4 tabs
set tabstop=4 
"indent with << and >> command
set shiftwidth=4
"indent in insert mode
set softtabstop=2 
"dont use whitespace 
set noexpandtab 
"Show if we are in Insert mode
set showmode

"Enable undo after closing files, 
"and save the undo files in the 
"vim directory 
set undofile
set undodir=~/.vim/undo

"---------------------------------------------
"Programming

"The "A"-Plugin for switching between Source- and Header-Files
source ~/.vim/plugin/a.vim
"c++ plugin
"source ~/.vim/plugin/vimCpp117.vim

"auto indent code
set autoindent

"Show the Quickfix-Window automatically on build-errors
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

set omnifunc=syntaxcomplete#Complete

"---------------------------------------------
"Search options

"Search while typing
set incsearch

"Higlight all searchresults
set hlsearch

"---------------------------------------------
"My key mappings

"Show Nerdtree  with F2
map <F2> :NERDTreeToggle<CR>

"Switching between absolute and relative line numbers 
nnoremap <C-n> :call NumberToggle()<cr>

"Change Size of Windows made with :sp and :vsp 
map ( : vertical res +7<CR>
map ) : vertical res -7<CR>
map [ : res +7<CR>
map ] : res -7<CR>

"start make 
map <F6> :make<CR>

"Clear searchresults with Control-L
nnoremap <silent> <C--L> :nohlsearch<Bar>:echo<CR>

"Tabbing
map tc :tabnew<CR>
map tp :tabprevious<CR>
map tn :tabnext<CR>
map tq :tabclose<CR>
map tqq :tabclose!<CR>
