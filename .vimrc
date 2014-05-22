"---------------------------------------------
"Colors

"my terminal supports 256 colors
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

"I don't want to backup files 
set nobackup
set noswapfile
set modelines=0

"enable filetype detection
filetype on

"Indent by 4 tabs
set tabstop=4 
"indent with << and >> command
set shiftwidth=4
"indent in insert mode
set softtabstop=4 
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
"Spell-Checking
"z=:		Suggest a word
"zg:		Add unknown word to the word list
"zG:		Add unknown word to the temporary word list, which is like "Ignore"
"See:http://vimdoc.sourceforge.net/htmldoc/spell.html

"Turn on spell checking for 
"markdown files
autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
"and textfiles
autocmd BufRead,BufNewFile *.txt setlocal spell spelllang=en_us

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

"fold by indentations
set foldmethod=indent

"---------------------------------------------
"clang completion
"plugin from https://github.com/Rip-Rip/clang_complete
"package libclang-dev has to be installed

"don't show the preview window becaue it is not informative at all
:set completeopt-=preview

"automatically select the first entry in the popup menu
let g:clang_auto_select = 1
"open quickfix window
let g:clang_complete_copen = 0
"periodic update
let g:clang_periodic_quickfix = 1
"insert argument placeholders when calling a memberfunction 
"(Use tab to jump to the next parameter)
let g:clang_snippets = 1

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

"Clang update
map <F12> :call g:ClangUpdateQuickFix()<CR>
map <F10> :!~/.vim/bin/make_clang.sh<CR>

"going to previous/next issue
map <F7> :cp<CR>
map <F8> :cn<CR>

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
