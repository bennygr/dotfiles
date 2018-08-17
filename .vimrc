"---------------------------------------------
"Creating viminfo file if not there
let viminfo_file=expand('~/.vim/files/info/viminfo')
if !filereadable(viminfo_file)
	echo "Creating viminfo file"
	!mkdir -p ~/.vim/files/info/ && touch ~/.vim/files/info/viminfo
endif

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
"nord colors
Plugin 'arcticicestudio/nord-vim'
"The nerdtree plugin
Plugin 'scrooloose/nerdtree'
"Tab support for nerdtree
Plugin 'jistr/vim-nerdtree-tabs'
"The A plugin for cpp<->h 
"Plugin 'a.vim'
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
"Startify: Vim startscreen
Plugin 'mhinz/vim-startify'
"OmniSharp
"Note: the omni-sharp server has to be build by hand after 
"the plugin has been installed
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/syntastic'
"Youcompleteme
"Plugin 'Valloric/YouCompleteMe'
"A-Plugin for C++
"Plugin 'vim-scripts/a.vim'
Plugin 'Shougo/echodoc.vim'

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
"colorscheme xoria256
colorscheme nord
hi normal ctermbg=none

"---------------------------------------------
"Special file types
"recognize md files as markdown
au BufNewFile,BufRead *.{md,markdown} set filetype=markdown

"---------------------------------------------
"Misc

"Showing Startify  homescreen
if  !exists(":Home")
	command Home Startify
endif

"commands for editing the holy .vimrc 
"(user defined command have to start whith an upper case letter)
if  !exists(":Vimrc")
	command Vimrc e ~/.vimrc
endif
if  !exists(":RefreshVimrc")
	command RefreshVimrc source ~/.vimrc
endif

"JSON formattingn the whole content
if !exists("TOjson")
    command TOjson %!python -m json.tool
endif

"enable the mouse in all modes
set mouse=a

"do not wrap long lines
set nowrap
"..but if enabled, show a nice icon
set showbreak =↪__

"Show rownumbers
set number
"But let us switch to relative numbers using a
"simple function.
"We can map this to a hot key in the  key map
"section
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc
"let us switch to Paste and Non-Paste mode
function! PasteToggle()
  if(&paste == 1)
    set nopaste
  else
    set paste
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
	
"code indent
"expand with space and not with tabs
set expandtab 
set shiftwidth=4
set softtabstop=4

"Enable undo after closing files, 
"and save the undo files in the 
"vim directory 
set undofile
set undodir=~/.vim/undo

"defining viminfo file, to store alot of vim histories
set viminfo='100,n$HOME/.vim/files/info/viminfo

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
"and yaml files
autocmd BufRead,BufNewFile *.yaml setlocal spell spelllang=en_us
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
		return strlen(_) ? '⎇  Branch '._ : ''
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
"Misc settings for Programming
"auto indent code
set autoindent

"vertical line by 100 characters
highlight ColorColumn ctermbg=8
set colorcolumn=100

"dissabling folding by default
set nofoldenable

"Please do not show html links
:hi link htmlLink NONE

"OmniComplete
"set omnifunc=syntaxcomplete#Complete
"longest: don't autoselect first item in omnicomplete
"menuone: popup even on only one match
set completeopt=longest,menuone
"Show method signature using the echodoc plugin
let g:echodoc_enable_at_startup = 1

" Preserve selection after indentation
vmap > >gv
vmap < <gv
"---------------------------------------------
"Startify home screen
"header
let g:startify_custom_header = [
\'            ____   ____  _                    ',
\'           |_  _| |_  _|(_)                   ',
\'             \ \   / /  __   _ .--..--.       ',
\'              \ \ / /  [  | [ `.-. .-. |      ',
\'               \ '' /    | |  | | | | | |     ',
\'                \_/    [___][___||__||__] -- ツ★ ',
\'                                              ',
\'   _________________________________________________________________________________________',
\'                                              ',
\'                                              ',
\'                                              ',
\]

"bookmarks
let g:startify_bookmarks = [
		\'~/.vimrc',
		\'~/.bashrc_benny',
		\'/etc/apache2/mods-enabled/proxy.conf',
		\'/etc/apache2/sites-enabled/000-default.conf',
		\]

"footer
let g:startify_custom_footer =
			\ [''] +
			\ [''] +
			\ ['   _________________________________________________________________________________________'] +
			\ [''] + map(split(system('date +"%A, %d %B %Y"'), '\n'), '"   ". v:val')

"---------------------------------------------
"C# PROGRAMMING
"OmniSharp - for C# programming
" this setting controls how long to wait (in ms) before fetching type / symbol
" information under the cursor
set updatetime=100
" do not ask when changing buffers; for example when renaming files
set hidden

"Reloading a solution file
nnoremap <leader>5 :OmniSharpReloadSolution<cr>
" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

"Make
nnoremap <F5> :OmniSharpBuildAsync<cr>
nnoremap <F6> :Make<cr>
augroup omnisharp_commands
    autocmd!

    "This is the error format for msbuild/xbuild
    "In addition you should call xbuild with /property:GenerateFullPaths=true
    "in order to generate full paths where vim can jump to
    autocmd FileType cs set errorformat=\ %#%f(%l\\\,%c):\ %m

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

    "Find tpes
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>

    "outline = find members
    autocmd FileType cs nnoremap <leader>fo :OmniSharpFindMembers<cr>

    "Finds the usage of symbol
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	
    "shows a list of code actions
    autocmd FileType cs nnoremap <leader>ca :OmniSharpGetCodeActions<cr>

    autocmd FileType cs vnoremap <leader>ca :call OmniSharp#GetCodeActions('visual')<cr>

    "Code format
    autocmd FileType cs nnoremap <leader>cf :OmniSharpCodeFormat<cr>

    "Renaming
    "rename with dialog
    autocmd FileType cs nnoremap <leader>rn :OmniSharpRename<cr>

    "Shows the type of a symbol
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>

    autocmd FileType cs nnoremap <leader>? :OmniSharpDocumentation<cr>

    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>xx :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>xu :OmniSharpFixUsings<cr>

    "Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()
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
	autocmd FileType java nnoremap <leader>xx :JavaCorrect<cr>

augroup END

"-Javascript--------------------------------------------
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS 
"- See more at: https://docs.oseems.com/general/application/vim/auto-complete-javascript#sthash.Bq4MNdGy.dpuf
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
"let mapleader = ","
let mapleader = "\<Space>"

"Ulti snip key mappings
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"Omni completion
"allowing enter to accept suggestions
":inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"going to previous/next issue
map <F3> :cp<CR>
map <F4> :cn<CR>
"closing the quickfix window
let g:toggle_list_no_mappings = 1
function! ToggleQuickFix()
	if exists("g:qwindow")
		close
		unlet g:qwindow
	else
		try
			copen 10
			let g:qwindow = 1
		catch 
			echo "No Errors found!"
		endtry
	endif
endfunction
nmap <script> <silent> <F12> :call ToggleQuickFix()<CR>

"Switching between absolute and relative line numbers 
nnoremap <C-n> :call NumberToggle()<cr>
"Switching between Paste Modes
noremap <F9> :call PasteToggle()<cr>

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

"---------------------------------------------
"EOF
