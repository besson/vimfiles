let mapleader=","

set nocompatible              " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS (vim-plug)
" Install/update with :PlugInstall / :PlugUpdate  |  Clean with :PlugClean
" (Auto-installs vim-plug + all plugins on first launch — see snippet below)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto-install vim-plug on first launch if missing
let s:plug_path = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_path))
  silent execute '!curl -fLo '.s:plug_path.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" File explorer
Plug 'preservim/nerdtree'

" Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'

" Linting / diagnostics (async replacement for syntastic + vim-flake8)
Plug 'dense-analysis/ale'

" Folding for Python
Plug 'tmhedberg/SimpylFold'

" Fuzzy finder (replaces ctrlp)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Statusline (replaces powerline)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Buffer explorer
Plug 'jlanzarotta/bufexplorer'

" Commenting
Plug 'preservim/nerdcommenter'

" Markdown live preview (renders in browser, updates as you type)
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install', 'for': ['markdown'] }

call plug#end()

filetype plugin indent on    " required
syntax enable

set splitbelow
set splitright
set hidden

" Use cursor keys to navigate buffers.
map  <Right> :bnext<CR>
map  <Left>  :bprev<CR>
imap <Right> <ESC>:bnext<CR>
imap <Left>  <ESC>:bprev<CR>
map  <Del>   :bd<CR>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" general configs
set encoding=utf-8
set number
set clipboard=unnamed
set mouse=a
set backspace=indent,eol,start

" QoL settings
set scrolloff=4
set wildmenu
set incsearch
set hlsearch
set ignorecase
set smartcase
set signcolumn=yes

" Persistent undo
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo//
endif

" ALE (linting) config
let g:ale_linters = {'python': ['flake8', 'pylsp']}
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
" Use ALE as omnicompletion source (<C-x><C-o>)
set omnifunc=ale#completion#OmniFunc
" Jump to definition / references via ALE's LSP
nnoremap <leader>g :ALEGoToDefinition<CR>
nnoremap <leader>r :ALEFindReferences<CR>
nnoremap K :ALEHover<CR>

let python_highlight_all=1

set t_Co=256
if has('termguicolors')
  set termguicolors
endif
set background=dark
colorscheme PaperColor

" Match pi's background: let Ghostty's terminal background show through
" (pi does not paint its own background either)
hi Normal      guibg=NONE ctermbg=NONE
hi NonText     guibg=NONE ctermbg=NONE
hi LineNr      guibg=NONE ctermbg=NONE
hi SignColumn  guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE

" airline config
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" fzf mappings (replaces ctrlp <C-p>)
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>f :Rg<CR>

" Nerd tree config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
" Open NERDTree when launching with a file, keeping cursor in the file window
autocmd VimEnter * if argc() >= 1 && !isdirectory(argv()[0]) && !exists("s:std_in") | NERDTree | wincmd p | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" Markdown preview toggle (only active in markdown buffers)
autocmd FileType markdown nnoremap <buffer> <leader>md :MarkdownPreviewToggle<CR>
let g:mkdp_auto_close = 1


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

map <leader>n :call RenameFile()<cr>

" Bufexplorer config
nmap <script> <silent> <unique> <Leader><Leader> :BufExplorer<CR>
let g:bufExplorerShowRelativePath=1
