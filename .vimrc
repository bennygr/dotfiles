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
"Text alignment 
Plugin 'godlygeek/tabular'
"eclim plugin for accessing eclimd
Plugin 'initrc/eclim-vundle'
"gitgutter shows git changes at a sidebar
Plugin 'airblade/vim-gitgutter'
"OmniSharp
"Note: the omni-sharp server has to be build by hand after 
"the plugin has been installed
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/syntastic'


filetype plugin indent on    " required
"All of your Plugins must be added before the following line
call vundle#end() 

"restoring filetype detection
syntax on
"required for ultisnips?!
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
		set norelativenumber
	endif
endfunc

"Creating a uuid
function! CreateGUID()
	:.!uuidgen	
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
	return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '✗' : &modifiable ? '' : '-'
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
		return strlen(_) ? '↝ Branch '._ : ''
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
"longest: don't autoselect first item in omnicomplete
"menuone: popup even on only one match
set completeopt=longest,menuone

"OmniSharp - for C# programming
" this setting controls how long to wait (in ms) before fetching type / symbol
" information under the cursor
set updatetime=500
" do not ask when changing buffers; for example when renaming files
set hidden
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
	
    "automatic syntax check on events (TextChanged requires Vim 7.4)
    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
	
    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

	"Goto definition 
    autocmd FileType cs nnoremap <leader>gd :OmniSharpGotoDefinition<cr>

	"Find implementation for interfaces and abstract classes
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>

	"Finds the usage of symbol
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	
	"shows a list of code actions
    autocmd FileType cs nnoremap <leader>ca :OmniSharpGetCodeActions<cr>
	autocmd FileType cs vnoremap <leader>ca :call OmniSharp#GetCodeActions('visual')<cr>

	"Renaming
	"rename with dialog
	autocmd FileType cs nnoremap <leader>rn :OmniSharpRename<cr>

	"Shows the type of a symbol
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>

    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>xi  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>xu :OmniSharpFixUsings<cr>

	"Automatically add new cs files to the nearest project on save
	autocmd BufWritePost *.cs call OmniSharp#AddToProject()
	autocmd FileType cs nnoremap <leader>rl :OmniSharpReloadSolution<cr>
	
	" Load the current .cs file to the nearest project
	autocmd FileType cs nnoremap <leader>ap :OmniSharpAddToProject<cr>
	autocmd FileType cs nnoremap <F6> :Make<cr>
augroup END


augroup eclim_commands
	"using omnifunc <c-x>+<c-o> instead of <c-u>
	let g:EclimCompletionMethod = 'omnifunc'

	"Rename the element under the cursor
	autocmd FileType java nnoremap <leader>rn :JavaRename<cr>

	"Import undefined types, remove unused imports, sort and format imports.
	"command Jorg JavaImportOrganize
    autocmd FileType java nnoremap <leader>xu :JavaImportOrganize<cr>
	"Show suggstins for syntax errors
	autocmd FileType java nnoremap <leader>xi :JavaCorrect<cr>

augroup END

"---------------------------------------------
"NERD TREDD
"Show Nerdtree  with F2
map <F2> :NERDTreeTabsToggle<CR>
let NERDTreeDirArrows=0

"---------------------------------------------
"Search options

"Search while typing
set incsearch

"Higlight all searchresults
set hlsearch

"---------------------------------------------
"My general key mappings

"mapping 
let mapleader = ","

"Smart semicolon: adding semicolon at the end of the line
inoremap <leader>, <C-o>A;

"Ulti snip key mappings
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"going to previous/next issue
map <F7> :cp<CR>
map <F8> :cn<CR>

"Switching between absolute and relative line numbers 
nnoremap <C-n> :call NumberToggle()<cr>

"creating a uuid
nnoremap <leader>nguid :call CreateGUID()<cr>;

"Change Size of Windows made with :sp and :vsp 
map ( : vertical res +7<CR>
map ) : vertical res -7<CR>
map [ : res +7<CR>
map ] : res -7<CR>

"Jumping to a help tag 
map ; <C-]>

"Clear searchresults with Control-L
nnoremap <silent> <C--L> :nohlsearch<Bar>:echo<CR>

"Tabbing
map tc :tabnew<CR>
map tp :tabprevious<CR>
map tn :tabnext<CR>
map tq :tabclose<CR>
map tqq :tabclose!<CR>
