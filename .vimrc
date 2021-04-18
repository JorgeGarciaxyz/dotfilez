" @JorgeGarciaxyz vimrc, based on @esnilara file https://github.com/esnilara/dotfiles/tree/master/vim
"
" ======================================================================
" GENERAL SETTINGS
" ======================================================================
"
set nocompatible               " Use Vim settings, rather then Vi settings
set nobackup                   " No backup file
set noswapfile                 " No backup file
set pastetoggle=<F2>           " Avoid cascading indents when pasting large amounts of text
set showmode

" Windows split configuration
set winwidth=84
set winheight=5
set winminheight=5
set winheight=999
set switchbuf+=usetab,newtab " Open quickfix view files in new tab

" Undo
call system("mkdir -p $HOME/.vim/undo")
set hidden
set history=1000               " Remember more commands and search history
set directory=~/.vim/swap//
set undodir=~/.vim/undo//
set undofile
set undolevels=1000            " Use many muchos levels of undo
set undoreload=10000

"set visualbell                " Don't beep
set noerrorbells               " Don't beep
set title                      " Change the terminal's title
set scrolloff=3                " Start scrolling 3 lines before the border

" Search
set showmatch                  " Set show matching parenthesis
set ignorecase                 " Ignore case when searching
set smartcase                  " Ignore case if search pattern is all lowercase, case-sensitive otherwise
set incsearch                  " Show search matches as you type

" Tabs and indentation
set nowrap                     " Don't wrap lines
set tabstop=2                  " A tab is two spaces
set expandtab
set backspace=indent,eol,start " Allow backspacing over everything in insert mode
set autoindent                 " Always set autoindenting on
set copyindent                 " Copy the previous indentation on autoindenting
set shiftwidth=2               " Number of spaces to use for autoindenting
set shiftround                 " Use multiple of shiftwidth when indenting with '<' and '>'
set smarttab                   " Insert tabs on the start of a line according to shiftwidth, not tabstop

" Global copy to clipboard
set clipboard^=unnamed,unnamedplus

" Fish shell configuration
"set shell=/bin/sh
set shell=/bin/bash


" Remove Trailing White Space automatically on save
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" Relative number lines
function! NumberToggle()
  if(&nu == 1)
    set nu!
    set rnu
  else
    set nornu
    set nu
  endif
endfunc

" The Silver Searcher Configuration
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

" Teach a Vim to fish...
if &shell =~# 'fish$'
  set shell=sh
endif

" ======================================================================
" KEY MAPS
" ======================================================================

" Map Leader
let mapleader=","

" Emmet
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Toggle relative number lines
"nnoremap <C-n> :call NumberToggle()<CR>

" Paste toggle
nnoremap <F2> :set invpaste paste?<CR>

" NERDTree commands
nmap <leader>ne :NERDTree<CR>
nmap <leader>nf :NERDTreeFind<CR>
map <C-n> :NERDTreeToggle<CR>

" Ag Search for word
nmap <M-k>:Ag "<cword>"<CR>
nmap <Esc>k :Ag "<cword>"<CR>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" fzf
nmap ; :Buffers<CR>
nmap <C-p> :CtrlP<CR>
nmap <Leader>r :Tags<CR>


" Disable arrow keys
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

" ======================================================================
" UI TWEAKS
" ======================================================================
set number                     " Always show line numbers
set laststatus=2               " Always display the status line.
set colorcolumn=90             " Highlight columns > 90
set cursorline                 " Highlight the current line
set hlsearch                   " Highlight search terms
set statusline=%F%m%r%h%w      " Status line display
set statusline+=\ [line/col\ %l,%v]
set enc=utf-8

" Set 256 color support
set t_Co=256
" set term=screen-256color
" let $TERM='screen-256color'
" let &t_AB="\e[48;5;%dm"
" let &t_AF="\e[38;5;%dm"

" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
if (has("nvim"))
  " For Neovim 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

" Enable true color 启用终端24位色
if exists('+termguicolors')
  set termguicolors
endif

" Set Theme
" colorscheme onedark
" colorscheme atom-dark
syntax enable
set background=dark
let g:solarized_termcolors=256      " use solarized 256 fallback
colorscheme solarized8

" Set Vim-Airline Theme
" let g:airline_theme="onedark"

" ======================================================================
" VUNDLE PLUGINS
" ======================================================================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Vim Superpowers
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mattn/emmet-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'rking/ag.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'elixir-editors/vim-elixir'

" fzf and ctrl
" I have troubles in the past while using fzf on debian based distributions
" Use ctrlp as an alternative
" Plugin 'JazzCore/ctrlp-cmatcher'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Syntax support
Plugin  'sheerun/vim-polyglot'

" Git
Plugin 'airblade/vim-gitgutter'

" Visual Enhancements
Plugin 'nathanaelkane/vim-indent-guides'

" Ruby
Plugin 'ngmy/vim-rubocop'

" Syntastic Linting
Plugin 'scrooloose/syntastic'

" Indent
Plugin 'Yggdroot/indentLine'

" markdown
Plugin 'gabrielelana/vim-markdown'

" Solarized Dark
Plugin 'lifepillar/vim-solarized8'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" ======================================================================
" PLUGIN CONFIGURATION
" ======================================================================

" NERDTree
let g:nerdtree_tabs_open_on_console_startup=0        " Set on startup
set wildignore+=/tmp/,*/tmp/*,*.so,*.swp,*.zip       " Ignore files

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers = ['eslint']

augroup vimrc_autocmd
  autocmd!
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()
  " autocmd BufNewFile,BufReadPost *.md,*.markdown set filetype=markdown
  autocmd BufNewFile,BufRead *.mustache,*.hogan,*.hulk,*.hjs set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
  autocmd BufNewFile,BufRead *.handlebars,*.hbs set filetype=html.handlebars syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
augroup END

" Disable HTML Tidy
let g:syntastic_mode_map={ 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['html'] }

" GutenTags Cache Dir
let g:gutentags_cache_dir = '~/.tags_cache'

let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" -------- Ctrl P stuff -------------
" -------- Ctrl P stuff -------------

" set runtimepath^=~/.vim/bundle/ctrlp.vim

" Ignore some folders and files for CtrlP indexing
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\.git$\|\.yardoc\|public$|log\|tmp$',
"  \ 'file': '\.so$\|\.dat$|\.DS_Store$'
"  \ }

"let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"let g:ctrlp_abbrev = {
"    \ 'abbrevs': [
"            \ {
"                \ 'pattern': '\(^@.\+\|\\\@<!:.\+\)\@<! ',
"                \ 'expanded': '',
"                \ 'mode': 'fprz',
"            \ },
"        \ ]
"    \ }

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
"if executable('ag')
"  " Use Ag over Grep
"  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
"endif
" -------- Ctrl P stuff -------------
" -------- Ctrl P stuff -------------

" -------- fzf stuff -------------
" -------- fzf stuff -------------

set rtp+=~/.fzf

nmap ; :Buffers<CR>
nmap <C-p> :Files<CR>
nmap <C-S-p> :GFiles<CR>
nmap <Leader>r :Tags<CR>
" -------- fzf stuff -------------
" -------- fzf stuff -------------

" Move between tabs
nmap <C-S-right> :tabnext<CR>
nmap <C-S-left> :tabprevious<CR>

" Make double-<Esc> clear search highlights
" nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Map ctrl s to save https://stackoverflow.com/questions/3446320/in-vim-how-to-map-save-to-ctrl-s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
