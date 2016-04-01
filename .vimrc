" Based on @mislav post http://mislav.uniqpath.com/2011/12/vim-revisited/
"set nocompatible                " choose no compatibility with legacy vi
syntax enable
"set encoding=utf-8
set showcmd                     " display incomplete commands
filetype plugin indent on       " load file type plugins + indentation

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" My customizations
set ls=2                        " always show status bar
set rnu                     " show line numbers
set cursorline                  " display a marker on current line
colorscheme twilight          " set colorscheme

"set completeopt=menuone,longest " simple autocomplete for anything
"set wildmode=list:longest,full  " autocomplete for paths and files
"set wildignore+=.git            " ignore these extensions on autocomplete

"set hidden                      " change buffers without warnings even when there are unsaved changes

set backupdir=/tmp              " directory used to save backup files
set directory=/tmp              " directory used to save swap files
"if has("win32")
"  set backupdir=$TEMP
"  set directory=$TEMP
"endif
set nobackup
set nowritebackup

set t_Co=256                    " forces terminal to use 256 colors
"if has("gui_running")
"  if has("gui_gtk2")
"    set guifont=Inconsolata\ 12
"  elseif has("gui_macvim")
"    set guifont=Menlo\ Regular:h14
"  elseif has("gui_win32")
"    set guifont=Consolas:h11:cANSI
"  endif
"endif

call pathogen#infect()          " initializes pathogen to manage plugins

map <F2> :NERDTreeTabsToggle<CR>

let NERDTreeShowHidden=1

:set guioptions+=m  "add menu bar
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar

"function! Smart_TabComplete()
"  let line = getline('.')                         " current line
"  
"  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
"                                                  " line to one character right
"                                                  " of the cursor
"  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
"  if (strlen(substr)==0)                          " nothing to match on empty string
"    return "\<tab>"
"  endif
"  let has_period = match(substr, '\.') != -1      " position of period, if any
"  let has_slash = match(substr, '\/') != -1       " position of slash, if any
"  if (!has_period && !has_slash)
"    return "\<C-X>\<C-P>"                         " existing text matching
"  elseif ( has_slash )
"    return "\<C-X>\<C-F>"                         " file matching
"  else
"    return "\<C-X>\<C-O>"                         " plugin matching
"  endif
"endfunction

"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

let g:loaded_syntastic_typescript_tsc_checker = 1 "don't do syntax checking

let g:syntastic_coffee_coffeelint_args = "--csv --file ~/.vim/coffeeLintConfig.json"
command -nargs=1 C CoffeeCompile | :<args>
nmap <F8> :TagbarToggle<CR>
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '--include-vars',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }
endif

let vimlocal = expand("%:p:h") . "/.vimrc.local"
if filereadable(vimlocal) 
  execute 'source '.vimlocal
endif
map <S-A-l> :NERDTreeFind<CR>
imap jj <Esc>
nmap oo o<Esc>k
nmap OO O<Esc>j
au GUIEnter * simalt ~x
nmap <F9> :mksession! <cr> " Quick write session with F9
nmap <F10> :source Session.vim <cr> " And load session with F10
set switchbuf+=usetab,newtab
set wrapscan
if has("win32")
  let g:slime_target = "tmux"
endif
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#close_symbol = ''
let g:airline#extensions#tabline#buffer_nr_format = 'b%s: '
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline_theme='dark'

" remap split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" open splits in a more natural way:
"set splitbelow
"set splitright

set relativenumber
set diffopt=filler,vertical
au BufReadPost fugitive:* set bufhidden=delete
fun! QuitPrompt(cmd)
  if tabpagenr("$") == 1 && winnr("$") == 1
    let choice = confirm("Close?", "&yes\n&no", 1)
    if choice == 1 | return a:cmd | endif
    return ""
  else | return a:cmd | endif
endfun
cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? QuitPrompt(getcmdline()) : 'q'
cnoreabbrev <expr> wq getcmdtype() == ":" && getcmdline() == 'wq' ? QuitPrompt(getcmdline()) : 'wq'
cnoreabbrev <expr> x getcmdtype() == ":" && getcmdline() == 'x' ? QuitPrompt(getcmdline()) : 'x'

" omnisharp
"let g:OmniSharp_server_type = 'v1'
"let g:OmniSharp_server_type = 'roslyn'
"let g:syntastic_cs_checkers = ['code_checker']
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1
"set completeopt=longest,menuone,preview
"augroup omnisharp_commands
"    autocmd!
"
"    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
"    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
"
"    " Synchronous build (blocks Vim)
"    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
"    " Builds can also run asynchronously with vim-dispatch installed
"    autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
"    " automatic syntax check on events (TextChanged requires Vim 7.4)
"    autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck
"
"    " Automatically add new cs files to the nearest project on save
"    autocmd BufWritePost *.cs call OmniSharp#AddToProject()
"
"    "show type information automatically when the cursor stops moving
"    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
"
"    "The following commands are contextual, based on the current cursor position.
"
"    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
"    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
"    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
"    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
"    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
"    "finds members in the current buffer
"    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
"    " cursor can be anywhere on the line containing an issue
"    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
"    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
"    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
"    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
"    "navigate up by method/property/field
"    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
"    "navigate down by method/property/field
"    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>
"
"augroup END
