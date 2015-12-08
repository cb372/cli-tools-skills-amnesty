"" The config file for Vim is ~/.vimrc.
"" This is a copy of my .vimrc file for reference.

call pathogen#infect()
syntax on
filetype plugin indent on

" make backspace work across line breaks
set backspace=indent,eol,start

" show line and column number
set ruler

" copy/paste directly to/from OSX clipboard (no need to use "+y to copy)
set clipboard=unnamed

" change <Leader> (both global and local) from \ to ,
let mapleader=","
let maplocalleader=","

" Make EUC-JP/ShiftJIS files readable
set fileencodings=ucs-bom,utf-8,default,iso_2022_jp,euc-jp,cp932,latin1

" Always show status bar
set laststatus=2

set shiftwidth=2
set tabstop=2
set expandtab
set foldlevelstart=1

" Set tabstop to 4 spaces for some languages
autocmd FileType java setlocal shiftwidth=4 tabstop=4

" Add folding to XML files
let g:xml_syntax_folding=1
autocmd FileType xml setlocal foldmethod=syntax

" DelimitMate interferes with xmledit's auto-generation of closing tags
autocmd FileType xml let b:delimitMate_autoclose = 0

" Disable arrow keys
inoremap <Left>  <NOP>
inoremap <Right> <NOP>
inoremap <Up>    <NOP>
inoremap <Down>  <NOP>

set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set pastetoggle=<F2>

set incsearch     " show search matches as you type

" Save a file using sudo
cmap w!! %!sudo tee > /dev/null %

" Press Ctrl-r to search/replace the currently highlighted text
vnoremap <C-r> <Esc>:%s/<C-r>+//gc<left><left><left>

" Tell Tagbar to use the correct ctags
let g:tagbar_ctags_bin="/usr/local/bin/ctags"

" Press F8 to toggle Tagbar
nmap <F8> :TagbarToggle<CR>

" Press F11 to open YankRing window
nnoremap <silent> <F11> :YRShow<CR>

" Use Shift-N to cycle through YankRing
let g:yankring_replace_n_nkey = '<S-n>'

" Set up some ignores for Ctrl-P plugin
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|class)$',
  \ }

" Keymaps for nerdtree
nnoremap <C-t> :NERDTree<CR>
nnoremap <C-S-t> :NERDTreeFind<CR>

" Keymaps for CtrlP
let g:ctrlp_map = '<C-n>'

" Turn F1 into ESC (much more useful than online help!)
map <F1> <Esc>
imap <F1> <Esc>

" Press space <char> to insert just one char without going into insert mode
nmap <Space> i_<Esc>r

" Use <leader>p to paste without yanking the old data into the yank register
vnoremap <leader>p "_dP"

" Show # and ## level headings unfolded when opening a markdown file
let g:vim_markdown_initial_foldlevel=1

" Write the current buffer to a temp file and load it in the Scala REPL
function RunInScalaREPL()
    let l:tmpfile = tempname() . '.scala'
    execute 'write ' . l:tmpfile
    execute '!scala -i ' . l:tmpfile
endfunction
command Scala call RunInScalaREPL()
command REPL call RunInScalaREPL()

" Move between windows without having to press Ctrl-W
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Never let the cursor get right to the top/bottom of window
set scrolloff=3

" Use f for vim-sneak, because remapping s is too annoying
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S

function CreatePdfCommands()
  if !exists(":Pdf") 
    " Generate PDFs of Manning chapter or whole book without leaving vim
    " Note: expand("%:t") gives the filename (without path) of currently open file
    command Pdf execute '!check-pdf ' . expand("%:t") 
    command PdfBook execute '!check-pdf'
  endif
endfunction

autocmd FileType xml call CreatePdfCommands()
