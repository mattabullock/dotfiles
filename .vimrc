runtime! debian.vim
set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VUNDLE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'shaond/vim-guru'
Plugin 'delimitMate.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easytags.vim'
Plugin 'scrooloose/nerdTree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'fugitive.vim'
Plugin 'phpqa'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ivalkeen/vim-ctrlp-tjump'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'shawncplus/phpcomplete.vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'joonty/vdebug'
Bundle 'xolox/vim-misc'
Bundle 'joonty/vim-phpunitqf.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto-reload .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" neocomplete
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:phpcomplete_parse_docblock_comments = 1
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
let g:neocomplete#enable_auto_select = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Theme and Syntax highlighting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight EOL whitespace, http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=darkred guibg=#382424

augroup whitespace " {
    autocmd!
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    " the above flashes annoyingly while typing, be calmer in insert mode
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup END

function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Run :FixWhitespace to remove end of line white space.
command! -range=% FixWhitespace call <SID>FixWhitespace(<line1>,<line2>)

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

syntax on
colorscheme gurunew

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden         " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)
set tabstop=4
set shiftwidth=4
set expandtab
set autoread
set number
set noswapfile
set completeopt=longest,menuone
set backspace=indent,eol,start

let mapleader = ","
set pastetoggle=<leader>p

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" easytags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:easytags_cmd = '/usr/local/bin/ctags'
set tags=./tags;
let g:easytags_dynamic_files = 2
let g:easytags_async = 1
let g:easytags_opts = ['--options=$HOME/.ctags.cnf']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" phpunit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:phpunit_cmd = "/usr/local/bin/phpunit"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
let g:ctrlp_custom_ignore = 'node_modules\|.git\|vendor\|zeta\|Zend\|externalLib\|build'
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <leader>l :CtrlPLine<cr>
nnoremap <leader>t :CtrlPTag<cr>
nnoremap <C-]> :CtrlPtjump<cr>
let g:ctrlp_tjump_only_silent = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vdebug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vdebug_options = {}
let g:vdebug_options["path_maps"] = {
\    "/vagrant/Server-Scraper" : $HOME."/Expensidev/Server-Scraper",
\    "/vagrant/Web-Expensify" : $HOME."/Expensidev/Web-Expensify",
\    "/vagrant/config/www/switch/_beforeSwitch.php" : $HOME."/Expensidev/Web-Expensify/_before.php",
\    "/vagrant/config/www/switch/_afterSwitch.php" : $HOME."/Expensidev/Web-Expensify/_after.php"
\}
let g:vdebug_options['timeout'] = 60
let g:vdebug_options['break_on_open'] = 0

nnoremap <leader>e :VdebugEval

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHPQA
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:phpqa_codesniffer_autorun = 0
let g:phpqa_messdetector_autorun = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gb :Gblame<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-n> :NERDTreeToggle<cr>

nnoremap <leader>f :FixWhitespace<cr>

" Map capital W to lowercase because shift and things
nnoremap :W<cr> :w<cr>

" SuperTab
" let g:SuperTabDefaultCompletionType = ""

" Prevent entering ex mode
nnoremap Q <Nop>

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

