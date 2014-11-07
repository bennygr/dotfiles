"---------------------------------------------
"Plugin management using Vundle 
"https://github.com/gmarik/Vundle.vim

"install vundle itself if it is not installed yet
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle/Vundle.vim/
	silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/Vundle.vim/
endif

"set the runtime path to include Vundle and initialize
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set nocompatible
filetype off                  

"my plugins:
"Let Vundle manage Vundle
Plugin 'gmarik/Vundle.vim'
"UltiSnips snippets engine 
Plugin 'SirVer/ultisnips'
"My personal snippets
Plugin 'bennygr/snips'
"The nerdtree plugin
Plugin 'scrooloose/nerdtree'
"Tab support for nerdtree
Plugin 'jistr/vim-nerdtree-tabs'
"The A plugin for cpp<->h 
Plugin 'a.vim'
"MatchTagAllways to match HTML tags
Plugin 'Valloric/MatchTagAlways'
"Change surrounding plugins for tags and parentheses 
Plugin 'tpope/vim-surround'
"Autoclosing parentheses 
Plugin 'Townk/vim-autoclose'
"lightline statusbar 
Plugin 'itchyny/lightline.vim'
"ctrlp plugin for opening files
Plugin 'kien/ctrlp.vim'
"git plugin
Plugin 'tpope/vim-fugitive'
"eclim plugin for accessing eclimd
Plugin 'initrc/eclim-vundle'

filetype plugin indent on    " required
"All of your Plugins must be added before the following line
call vundle#end() 

"restoring filetype detection
syntax on
filetype off
filetype plugin indent on

"---------------------------------------------
"Colors
"my terminal supports 256 colors
set t_Co=256
set background=dark
"Setting my coloscheme
colorscheme xoria256
hi normal ctermbg=none

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
"options for the lightline status bar plugin 
"needed to display the status bar
set laststatus=2 
"dont' show the originial mode because the mode
"is shwon by lightline
set noshowmode
"status bar configuration
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'mode_map': { 'c': 'NORMAL' },
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
			\ },
			\ 'component_function': {
			\   'modified': 'MyModified',
			\   'readonly': 'MyReadonly',
			\   'fugitive': 'MyFugitive',
			\   'filename': 'MyFilename',
			\   'fileformat': 'MyFileformat',
			\   'filetype': 'MyFiletype',
			\   'fileencoding': 'MyFileencoding',
			\   'mode': 'MyMode',
			\ },
			\ 'separator': { 'left': '|', 'right': '|' },
			\ 'subseparator': { 'left': '|', 'right': '|' }
			\ }

"show modified symbol for a file
function! MyModified()
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

"Show if a file is readonly
function! MyReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'READONLY' : ''
endfunction

"Show the file's name
function! MyFilename()
	return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
				\ (&ft == 'vimfiler' ? vimfiler#get_status_string() : 
				\  &ft == 'unite' ? unite#get_status_string() : 
				\  &ft == 'vimshell' ? vimshell#get_status_string() :
				\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
				\ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

"show the current git branch
function! MyFugitive()
	if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
		let _ = fugitive#head()
		return strlen(_) ? 'Branch -> '._ : ''
	endif
	return ''
endfunction

"show the fileformat
function! MyFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

"show the filetype
function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

"show the fileencoding
function! MyFileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

"show the current mode
function! MyMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction  

"---------------------------------------------
"Programming
"auto indent code
set autoindent

"Show the Quickfix-Window automatically on build-errors
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

"fold by indentations
set foldmethod=indent

"Please do not show html links
:hi link htmlLink NONE

"OmniComplete
set omnifunc=syntaxcomplete#Complete

"Java shortcuts for programming with eclipse using eclim
"Create a default constructor
command Jtor JavaConstructor
"Getting the call hierarchy for the method under the cursor
command Jhier JavaCallHierarchy
"Implementing/Overwriting methods of the super class  
command Jimpl JavaImpl
"Import undefined types, remove unused imports, sort and format imports.
command Jorg JavaImportOrganize
"Import the cass under the cursor
command Jimp JavaImport
"Show suggstins for syntax errors
command Jsug JavaCorrect
"Rename the element under the cursor
command! Jcn JavaRename
"Shows the java doc of the element under the cursor
command Jdoc JavaDocPreview

"---------------------------------------------
"clang completion
"plugin from https://github.com/Rip-Rip/clang_complete
"package libclang-dev has to be installed

"don't show the preview window becaue it is not informative at all
:set completeopt-=preview
""automatically select the first entry in the popup menu
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

"Ulti snip key mappings
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"Show Nerdtree  with F2
map <F2> :NERDTreeTabsToggle<CR>

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
