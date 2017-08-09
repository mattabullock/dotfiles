runtime! debian.vim
set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')

" Making Vim pretty
Plug 'altercation/vim-colors-solarized' " color scheme
Plug 'itchyny/lightline.vim'

" Easy project navigation
Plug 'ctrlpvim/ctrlp.vim' " fuzzy search
Plug 'ivalkeen/vim-ctrlp-tjump' " nicer jump to definition
Plug 'ludovicchabant/vim-gutentags'
Plug 'christoomey/vim-tmux-navigator'

" Making editing great again!
Plug 'tpope/vim-surround' " surround words with things
Plug 'Raimondi/delimitMate' " adds matching parens, quotes, etc
Plug 'tpope/vim-fugitive' " git
Plug 'scrooloose/nerdcommenter' " easy commenting
Plug 'tpope/vim-rhubarb' " GitHub commands

" Universal autocomplete
Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale', { 'for': 'php' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" PHP specific
Plug 'joonty/vdebug', { 'for': 'php' }

" Golang specific
Plug 'fatih/vim-go', { 'for': 'go' }

" Markdown specific
Plug 'godlygeek/tabular', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin indent on  " required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto-reload .vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup reload_vimrc
    autocmd!
    autocmd bufwritepost $MYVIMRC nested source $MYVIMRC
augroup END

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
set background=light
colorscheme solarized

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
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
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
" phpunit
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:phpunit_cmd = "/usr/local/bin/phpunit"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTRLP
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = 'node_modules\|.git\|vendor\|zeta\|Zend\|externalLib\|build'
nnoremap <C-]> :CtrlPtjump<cr>
let g:ctrlp_tjump_only_silent = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:lightline = { 'colorscheme': 'solarized' }
let g:lightline.component = {
            \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
            \   'lineinfo': '%3l/%L:%-2v'
            \ }
let g:lightline.active = {
            \   'left': [ [ 'mode', 'paste' ], ['fugitive'], ['readonly', 'relativepath', 'modified'] ],
            \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ] ]
            \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vdebug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vdebug_options = {}
let g:vdebug_options["path_maps"] = {
\    "/vagrant/Server-Scraper" : $HOME."/Expensidev/Server-Scraper",
\    "/vagrant/Web-Expensify" : $HOME."/Expensidev/Web-Expensify",
\    "/vagrant/Web-Secure" : $HOME."/Expensidev/Web-Secure",
\    "/vagrant/config/www/switch/_beforeSwitch.php" : $HOME."/Expensidev/Web-Expensify/_before.php",
\    "/vagrant/config/www/switch/_afterSwitch.php" : $HOME."/Expensidev/Web-Expensify/_after.php"
\}
let g:vdebug_options['timeout'] = 60
let g:vdebug_options['break_on_open'] = 0

au FileType php nnoremap <leader>e :VdebugEval<space>
au FileType php nnoremap <leader>bw :BreakpointWindow<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PHPQA
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:phpqa_codesniffer_autorun = 0
let g:phpqa_messdetector_autorun = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fugitive
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>gb :Gblame<cr>
function! Gbrowsebyline(setting) range
    if a:setting == "single"
        execute ":".line('.')."Gbrowse"
    elseif a:setting == "multiple"
        execute ":'<,'>Gbrowse"
    endif
endfunction
nnoremap <leader>gh :call Gbrowsebyline("single")<cr>
vnoremap <leader>gh :call Gbrowsebyline("multiple")<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ag
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
command! -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" delimitMate
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let delimitMate_excluded_regions = "Comment"
let delimitMate_expand_cr = 1
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quickfix window
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>qf :call ToggleList("Quickfix List", 'c')<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-go
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-markdown
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_confirm_extra_conf = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<C-x>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Session handling
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

" Adding automatons for when entering or leaving Vim
nnoremap <leader>lo :call LoadSession()<cr>
nnoremap <leader>ss :call MakeSession()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <leader>f :FixWhitespace<cr>
nnoremap <leader>y "+y
vnoremap <leader>y "+y<cr>

" Map capital W to lowercase because shift and things
nnoremap :W<cr> :w<cr>
nnoremap :Q<cr> :q<cr>

" Prevent entering ex mode
nnoremap Q <Nop>

" Visual Paste doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

