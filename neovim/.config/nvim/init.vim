""""""""""""""""""""""""""""""""""""""""
" General configuration
""""""""""""""""""""""""""""""""""""""""

" Disable swp files
set noswapfile

" Enable persistent undo
set undofile

" Enable the mouse in the terminal
set mouse=a

" Share the system clipboard
set clipboard+=unnamedplus

""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""

" Plugin configuration
call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'morhetz/gruvbox'

call plug#end()

" Search from the git repo root, if we're in a repo, else the cwd
function FuzzyFind(show_hidden)
  " Contains a null-byte that is stripped.
  let gitparent=system('git rev-parse --show-toplevel')[:-2]
  if a:show_hidden
    let $FZF_DEFAULT_COMMAND = g:fzf_default_command . ' --hidden'
  else
    let $FZF_DEFAULT_COMMAND = g:fzf_default_command
  endif
  if empty(matchstr(gitparent, '^fatal:.*'))
    silent execute ':FZF -m ' . gitparent
  else
    silent execute ':FZF -m .'
  endif
endfunction

nnoremap <c-p> :call FuzzyFind(0)<cr>
nnoremap <c-o> :call FuzzyFind(1)<cr>

" Use rg to perform the search, so that .gitignore files and the like are
" respected
let g:fzf_default_command = 'rg --files'

" Airline configuration
let g:airline_powerline_fonts = 1
" Don't show empty warning or error sections
let g:airline_skip_empty_sections = 1
" " Override normal, insert, and visual {, line, block}
let g:airline_mode_map = {
  \ 'n'  : '∙',
  \ 'i'  : '|',
  \ 'v'  : '→',
  \ 'V'  : '↔',
  \ '' : '↕',
  \ }

" Append our Neovim virtualenv to the list of venvs ale searches for
" The search is performed from the buffer directory up, until a name match is
" found; our Neovim venv lives in ~/.nvim-venv
let g:ale_virtualenv_dir_names = ['.env', '.venv', 'env', 'virtualenv', 'venv']
" Explicitly list linters we care about
let g:ale_linters = {'python': ['flake8', 'pylint']}
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""

" Show the executing command
set showcmd
" Don't show the current editing mode
set noshowmode
"
" Theme
set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:airline_theme = 'gruvbox'
colorscheme gruvbox

" Have some context around the current line always on screen
set scrolloff=3
set sidescrolloff=5

" Try to display very long lines, rather than showing @
set display+=lastline

" show trailing whitespace as -, tabs as >-
set listchars=tab:>-,trail:-
set list

" Smart case searching
set ignorecase
set smartcase

" Live substitution
set inccommand=split

if has("nvim")
  set laststatus=1
endif

""""""""""""""""""""""""""""""""""""""""
" Coding style
""""""""""""""""""""""""""""""""""""""""

" Tabs as two spaces
set tabstop=2
set shiftwidth=2
set expandtab

""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""

" change the leader key to space
let mapleader="\<Space>"

" Stop command window from popping u
map q: :q

" clear search highlighting with <space>,
nnoremap <leader>, :noh<cr>

" quick make
map <leader>m :make<CR>

" simple pasting from the system clipboard
" http://tilvim.com/2014/03/18/a-better-paste.html
map <Leader>p :set paste<CR>o<esc>"+]p:set nopaste<cr>

" Scroll up and down visible lines, not buffer lines
noremap j gj
noremap k gk

" Navigate tabs with shift-{h,l}
noremap <S-l> gt
noremap <S-h> gT

" Create splits
nnoremap <Leader>- :split<CR>
nnoremap <Leader>/ :vsplit<CR>

" Quickly save, quit, or save-and-quit
map <leader>w :w<CR>
map <leader>x :x<CR>
map <leader>q :q<CR>

set number                  " show line numbers
set relativenumber          " use relative line numbers
set ruler                   " show line and column number
set showcmd                 " show command in bottom bar
set cursorline              " highlight current line
set colorcolumn=80          " 80 char column
filetype indent on          " load filetype-specific indent files
filetype on
set lazyredraw              " redraw only when we need to
set showmatch               " highlight matching [{()}]

"""""""""""""""""""""""""""""
"   Searching
"""""""""""""""""""""""""""""
set incsearch               " search as characters are entered
set hlsearch                " highlight matches

" Esc ends search
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

"""""""""""""""""""""""""""""
"   Folding
"""""""""""""""""""""""""""""
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
set foldnestmax=10          " 10 nested fold max

" comma open/closes folds
nnoremap , za

set foldmethod=indent       " fold based on indent level


""""""""""""""""""""""""""""""""""""""""
" Filetype specific
""""""""""""""""""""""""""""""""""""""""

" Always assume .tex files are LaTeX
let g:tex_flavor = "latex"

" Don't autocomplete filenames that match these patterns
" Version control
set wildignore=.svn,.git
" Compiled formats
set wildignore+=*.o,*.pyc
" Images
set wildignore+=*.jpg,*.png,*.pdf
" Auxilary LaTeX files
set wildignore+=*.aux,*.bbl,*.blg,*.out,*.toc
" Web development
set wildignore+=vendor,_site,tmp,node_modules,bower_components
" Script outputs
set wildignore+=output

" Enable deoplete
let g:deoplete#enable_at_startup = 1

"Rust specific completion
let g:deoplete#sources#rust#racer_binary='/Users/holmgr/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/Users/holmgr/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
let g:deoplete#sources#rust#documentation_max_height=20 "Max hight of documentation split

au BufNewFile,BufRead *.markdown setlocal syntax=markdown

" Spellchecking in LaTeX, Markdown 
au FileType tex,plaintex,markdown, setlocal spelllang=en_gb spell formatoptions=tcroqlj

" Wrap Python automatically at 80 characters
au FileType python setlocal textwidth=79 formatoptions=tcroqlj

" relativenumber can be very slow when combined with a language whose syntax
" highlighting regexs are complex
" https://github.com/neovim/neovim/issues/2401
" https://groups.google.com/forum/#!topic/vim_use/ebRiypE2Xuw
au FileType tex set norelativenumber
